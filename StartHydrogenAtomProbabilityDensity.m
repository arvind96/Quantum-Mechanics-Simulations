function StartHydrogenAtomProbabilityDensity()

global HydrogenOrbitalGenerationRunning;

if(HydrogenOrbitalGenerationRunning == 1)
    return;
end

HydrogenOrbitalGenerationRunning = 1;

global MainHandle; %stores the handle for MainGUI

set(MainHandle.uipanelTopControls, 'Title', 'HYDROGEN ATOM');

set(MainHandle.uipanelOther1, 'Visible', 'On');
set(MainHandle.uipanelOther2, 'Visible', 'On');
set(MainHandle.uipanelOther3, 'Visible', 'On');

set(MainHandle.sliderOther1, 'Min', 2.00, 'Max', 4.00);
if(GetOtherSliderValue1() > 4)
    SetOtherSliderValue1(2.00);
elseif(GetOtherSliderValue1() < 2)
	SetOtherSliderValue1(2.00);
end
% define constants and orbital shape

% quantum numbers
n = round(GetOtherSliderValue1());           % principal quantum number (shell #)
l = round(GetOtherSliderValue2());           % orbital quantum number (subshell type: s, p, d, f, etc.)
m = round(GetOtherSliderValue3());           % magnetic quantum number (orientation of subshell)

% constants: shape and cutoffs of 3D plots (needs fiddling to get a good plot)
cons.cutoff     = 0.75 * 10^(24); % electron density cutoff (where to put isosurface)
cons.resolution = 200; %75;             % number of calculations per XYZ dimension   
cons.spatialLen = 7;             % length of physical space to view over (angstroms)

switch n
    case 2
        switch l
            case 0
                cons.spatialLen = 10;
            case 1
                cons.spatialLen = 7;
        end
    case 3
        switch l
            case 0
                cons.spatialLen = 20;
            case 1
                cons.spatialLen = 12;
            case 2
                cons.spatialLen = 7;
        end
    case 4
        switch l
            case 0
                cons.spatialLen = 30;
            case 1
                cons.spatialLen = 18;
            case 2
                cons.spatialLen = 12;
            case 3
                cons.spatialLen = 5;
        end
    otherwise
        cons.spatialLen = 50;
end
    
    
% constants: scale size of plot (don't play with)
cons.scale      = 10^(-9.5);         % scaling length of calculation (meters)
cons.meters2ang = 10^(-10);          % convert meters to angstroms
cons.a0         = 5.2820 * 10^(-11); % Bohr radius (meters)

% constants: orbital name and color (doesn't affect calculation)
%[ColorIs]        = makeColors;        % load color values
cons.orbitName   = orbitNameIs(n,l,m);% name that appears in figure titles
cons.outerColor  = [0.7 0.5 0.5];%ColorIs.red;       % color of isosurface
cons.sliceStyle2 = false;             % alternate clip plane for PlotCrossSectionIsosurface

%--------------------------------------------------------------------------
% generate XYZ space, convert to spherical radius, theta, and phi

[xSpace, ySpace, zSpace] = make3Dspace(cons);
[theta, phi, r] = convert2polar(xSpace, ySpace, zSpace);

%--------------------------------------------------------------------------
% calculate wave function (3D vector of probability)

WaveFn = psiCalculation(n,l,m,r,theta,phi,cons);

set(MainHandle.uipanelAxes1, 'Title', 'ORBITAL');
set(MainHandle.uipanelAxes2, 'Title', 'ORBITAL CROSS SECTION');

set(MainHandle.figureMain, 'currentaxes', MainHandle.axes1);
PlotSolidIsosurface(xSpace, ySpace, zSpace, WaveFn, cons);

set(MainHandle.figureMain, 'currentaxes', MainHandle.axes2);
PlotCrossSectionIsosurface(xSpace, ySpace, zSpace, WaveFn, cons);

str = 'Click on the Reset button to generate the probability density surface.';
text(0.0 , 0.75, str, 'FontSize', 12, 'Parent', MainHandle.axesEquations);


str  = ['Current orbital: ' cons.orbitName];
text(0.0 , 0.25, str, 'FontSize', 12, 'Parent', MainHandle.axesEquations);

HydrogenOrbitalGenerationRunning = 0;

end

%%            Mix and make your own hybrid orbitals!
% 
% PlotHydrogenMolecularOrbital is a function designed to plot a hydrogen
% orbital. The orbital is defined by the quantum numbers, which in tern
% determine the number of nodes and harmonic frequencies observed in the
% wavefunction. This program is intended both to display the functions and
% to allow the user to mix and match wave functions (such as for hybrid
% orbitals).
% 
% Radial nodes are determined by Laguerre polynomials, and angular nodes by 
% Legendre polynomials. Details of the calculation are in the radial wave 
% function and angular wave function sections.
% 
% -------------------------------------------------------------------------
% Some notes on the calculation
%  
% Remember that all spatial lengths (angstroms, meters, etc.) are real! 
% you may need to play with the settings to get the plot that you want.
% 
% As the orbital increases in size, increase cons.spatialLen to see it all
% If orbital is missing parts, maybe decrease cons.cutoff by a magnitude
% Increase cons.resolution to make the plot prettier 
%     remember this makes an N^3 increase in computional time
% The wave function is a cubic 3D vector. Keep that in mind when making
%     hybrid orbitals
% Some XYZ axis rotations were needed to align the calculations to Matlab's
%     polar 3D space. 
% 
% -------------------------------------------------------------------------
% notes on the plots
% 
% a small function "makeColors" is included to give some preloaded color
%     values. This is useful for coloring the skin of the orbitals
% the functions PlotSolidIsosurface, PlotCrossSectionIsosurface, and
%     PlotWaveFnSignIsosurface are a good start to visualizing the data
% PlotCrossSectionIsosurface has a color bar. These are multiples of the
%     cutoff value labeled in cons.cutoff
% The cons.sliceStyle2 option is a boolean that switches the clipping plane
%     from YZ to XZ in the PlotCrossSectionIsosurface plot. This is useful
%     for visualizing the inside of certain orbitals
% 


%==========================================================================
%%                      calculate wave function
%==========================================================================

% the wave function is a 3D vector of size [resolution, resolution, resolution]
% calculate it by multiplying each element of the radial and angular components
function [WaveFn] = psiCalculation(n,l,m,r,theta,phi,cons)
WaveFn = radialCalculation(n,l,r,cons) .* angularCalculation(l,m,theta,phi);

% correction 1: remove NaN at atomic nucleus
center = ceil(cons.resolution/2);
WaveFn(center, center, center) = 0;

% correction 2: flip wave function properly when m < 0
if (m < 0 )
    WaveFn = permute(WaveFn, [2 1 3]);
end

end

%% radial wave function

% the radial component is composed of two parts: an exponential term and a
% polynomial term. The exponential term adds attraction to the nucleus of
% the atom. The polynomial term adds electron shell harmonics to create
% nodal spheres

function [RadialFn] = radialCalculation(n,l,r,cons)

% import contants
a0 = cons.a0;

% scaling factors
scalFac1 = sqrt((2/(a0*n))^3 * factorial(n-l-1)/(2*n*factorial(n+l)));
scalFac2 = 1/factorial(n - l + 2*l);

% Part 1:  exponential component (attraction to nucleus)
nuclearComponent = (2*r/(a0*n)) .* exp(-r/(a0*n));

% Part 2:  polynomial component (generates radial nodes)
radialNodeComponent = LaguerrePolynomial(n-l-1, 2*l+1, 2*r/(a0*n));

% combine components to calculate radial wave function
RadialFn = scalFac1 * scalFac2 * nuclearComponent .* radialNodeComponent;

end

% use Laguerre polynomials to introduce nodal spheres into radial function
function [NodalFn] = LaguerrePolynomial(n,m,r)

% initiate polynomial function
NodalFn = zeros(size(r));

% add n coefficient terms to the polynomial
for i = 0:n
    polynomialCoeff = factorial(m+n) * nchoosek(m+n,n-i) / factorial(i);
    NodalFn = NodalFn + polynomialCoeff * (-r).^i;
end

end

%% angular wave function

% the angular component is a cosine function with Legendre polynomials used
% to add nodal planes.

function [AngularFn] = angularCalculation(l,m,theta,phi)

if (abs(m) == 2)
    m = -m;
end
if (m == -2)
    phi = phi + pi/4;
end

% normalization and scaling factors
normFac = abs(sign(m)*(2^0.5) + (sign(abs(m)) - 1)*2);
scalFac = sqrt((2*l+1) / (4*pi) * factorial(l-abs(m)) / factorial(l+abs(m)));

% add nodes to spherical harmonics functions
SphFn1 = scalFac * LegendrePolynomial(l,m,cos(theta))  .* exp(1i*m*phi);
SphFn2 = scalFac * LegendrePolynomial(l,-m,cos(theta)) .* exp(1i*-m*phi);

AngularFn = (SphFn1 + SphFn2) / normFac;

end

% use Legendre polynomials to introduce nodal planes into angular function
function [NodalFn] = LegendrePolynomial(l,m,x)

% initiate polynomial function
NodalFn = zeros(size(x));
numCoeffs = floor(1/2*l - 1/2*abs(m));

% add n coefficient terms to the polynomial
for n = 0:numCoeffs
    polynomialCoeff = (-1)^n * nchoosek(l-2*n,abs(m)) * nchoosek(l,n) * nchoosek(2*l-2*n,l);
    exponent = l - 2*n - abs(m);
    NodalFn = NodalFn + polynomialCoeff * x.^exponent;
end
NodalFn = (-1)^m * (1-x.^2).^(abs(m)/2) .* (factorial(abs(m))/2^l*NodalFn);

end

%==========================================================================
%%               generate 3D space (X Y Z theta phi r)
%==========================================================================

% generate 3D cartesian space based on inputs
function [xSpace, ySpace, zSpace] = make3Dspace(cons)

% import dimensions and scaling factors
resolution = cons.resolution;
spatialLen = cons.spatialLen;
scale      = cons.scale;

% generate XYZ space using meshgrid
xRange = linspace(-spatialLen, spatialLen, resolution) * scale;
yRange = linspace(-spatialLen, spatialLen, resolution) * scale;
zRange = linspace(-spatialLen, spatialLen, resolution) * scale;
[xSpace, ySpace, zSpace] = meshgrid(xRange, yRange, zRange);

end

% most of this function is equivalent to the "cart2sph" function.
% Matlab interprets angles a little differently than a classic calculus
% textbook, as in the engineering-style of polar coordinatles.
% phi and theta are swapped, and the zero-angle is at a -pi/2 angle. 
% Consequently we manually convert the points here.
function [theta, phi, r] = convert2polar(x, y, z)

r     = sqrt(x.^2+y.^2+z.^2);
theta = acos(z./r);     % this is "phi" in the "cart2sph" function
phi   = atan2(y,x);     % this is "theta" in the "cart2sph" function

end

%==========================================================================
%%                      plot wave functions
%==========================================================================

% load up some useful color values
function [ColorIs] = makeColors

ColorIs.red    = [1 0 0];
ColorIs.green  = [0 1 0];
ColorIs.blue   = [0 0 1];

ColorIs.purple = [1 0 1];
ColorIs.cyan   = [0 1 1];
ColorIs.yellow = [1 1 0];

ColorIs.black  = [0 0 0];
ColorIs.grey   = [0.3 0.3 0.3];

end

% convert n l m into a useful name
function [orbitName] = orbitNameIs(n,l,m)
subShells = {'s', 'p', 'd', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm'};
thisM = [num2str(m) num2str(m)];
thisMtmp = num2str(m);
for j = 1:length(thisMtmp)
    thisM(2 * j - 1) = '_';
    thisM(2 * j) = thisMtmp(j);
end
orbitName = [num2str(n) subShells{l+1} thisM];
end

% plot a solid isosurface of the orbital
function PlotSolidIsosurface(xSpace, ySpace, zSpace, WaveFn, cons)

% import dimensions and scaling factors
spatialLen = cons.spatialLen;
meters2ang = cons.meters2ang;
cutoff     = cons.cutoff;
orbitName  = cons.orbitName;
isoColor   = cons.outerColor;

% square the wavefunction to make an electron density map
WaveFn2 = WaveFn .* conj(WaveFn);

% convert inputs to convenient numbers and values
x = xSpace / meters2ang;
y = ySpace / meters2ang;
z = zSpace / meters2ang;
v = WaveFn2 / cutoff;

% patch and interpret isosurface for better coloration
p = patch(isosurface(x,y,z,v,1));
isonormals(x,y,z,v,p);
set(p,'FaceColor',isoColor,'EdgeColor','none');

% lighting, aspect ratio, plot options
daspect([1 1 1]);
view(3); 
axis vis3d;
camlight;
lighting phong;
xlabel('x','FontSize',10);
ylabel('y','FontSize',10);
zlabel('z','FontSize',10);
%title([orbitName ' orbital'],'FontSize',10);
rotate3d on;

% dimensions of plot
plotScale = spatialLen * 1.4;
global MainHandle; %stores the handle for MainGUI
xlim(MainHandle.axes1, [-plotScale plotScale]);
ylim(MainHandle.axes1, [-plotScale plotScale]);
zlim(MainHandle.axes1, [-plotScale plotScale]);

end

% plot a cross section of a solid isosurface of the orbital
function PlotCrossSectionIsosurface(xSpace, ySpace, zSpace, WaveFn, cons)

% import dimensions and scaling factors
spatialLen  = cons.spatialLen;
meters2ang  = cons.meters2ang;
cutoff      = cons.cutoff;
orbitName   = cons.orbitName;
isoColor    = cons.outerColor;
sliceStyle2 = cons.sliceStyle2;

% use alternate clipping plane?
halfLength = 0;
clipRange = [nan,nan,halfLength,nan,nan,nan];
if (sliceStyle2 == true)
    clipRange = [halfLength,nan,nan,nan,nan,nan];
end

% square the wavefunction to make an electron density map
WaveFn2 = WaveFn .* conj(WaveFn);

% convert inputs to convenient numbers and values
x = xSpace / meters2ang;
y = ySpace / meters2ang;
z = zSpace / meters2ang;
v = WaveFn2 / cutoff;

% slice off half the isosurface, change XYZ accordingly
[x,y,z,v] = subvolume(x,y,z,v,clipRange);

% patch and interpret isosurface for better coloration
p1 = patch(isosurface(x,y,z,v,1),'FaceColor',isoColor,'EdgeColor','none');
isonormals(x,y,z,v,p1);
patch(isocaps(x,y,z,v,1),'FaceColor','interp','EdgeColor','none');

% lighting, aspect ratio, plot options
daspect([1 1 1]);
view(3); 
axis vis3d;
camlight;
lighting phong;
xlabel('x','FontSize',10);
ylabel('y','FontSize',10);
zlabel('z','FontSize',10);
%title([orbitName ' orbital cross section'],'FontSize',10);
rotate3d on;

% dimensions of plot
plotScale = spatialLen * 1.4;
global MainHandle; %stores the handle for MainGUI
xlim(MainHandle.axes2, [-plotScale plotScale]);
ylim(MainHandle.axes2, [-plotScale plotScale]);
zlim(MainHandle.axes2, [-plotScale plotScale]);

end