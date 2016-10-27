function StartParticleInFiniteBox1DSimulation()

global MainHandle; %stores the handle for MainGUI

%Reset here
SetTime(0);
SetTimeScale(1.5000);

set(MainHandle.uipanelTopControls, 'Title', 'PARTICLE in FINITE 1D BOX');

cla(MainHandle.axesEquations);

%wave equation
str = '$$\psi_1(x,t) = De^{\alpha x};  \;\;\;  \psi_2(x,t) = Asin(kx) + Bcos(kx); \;\;\; \psi_3(x,t) = He^{-\alpha x}$$';
text(0.0 , 0.66 + 0.165, str, 'Interpreter', 'latex', 'FontSize', 11, 'Parent', MainHandle.axesEquations);

str = '$$For \; symmetric \; A = 0 \; and \; G = H, \; For \; antisymmetric \; B = 0 \; and \; G = -H$$';
text(0.0 , 0.33 + 0.165, str, 'Interpreter', 'latex', 'FontSize', 11, 'Parent', MainHandle.axesEquations);

str = '$$\psi(x,t) = \psi_1 (if x < -L/2),\;\;\psi_2 (if \; -L/2 < x < L/2),\;\;\psi_3 (if \; x > L/2)  \;\;\;\;\;  P(x,t) = \psi^{*}(x,t) \psi(x,t)$$';
text(0.0 , 0.165, str, 'Interpreter', 'latex', 'FontSize', 11, 'Parent', MainHandle.axesEquations);

set(MainHandle.uipanelOther1, 'Visible', 'Off');
set(MainHandle.uipanelOther2, 'Visible', 'Off');
set(MainHandle.uipanelOther3, 'Visible', 'Off');

set(MainHandle.sliderOther1, 'Min', 3.00, 'Max', 10.00);
SetOtherSliderValue1(6.00);


x = (-15:0.1:15);
XSize = size(x);
z = x;
for K = 1:1:XSize(2)
  z(K) = ParticleInFiniteBoxWave(GetWaveInC1(), GetWaveInC2(), GetWaveInC3(), x(K), GetTime());
end

p = CalculateProbability(z);

density = CalculateCurrentDensity(z, ParticleInBoxDiffWave(GetOtherSliderValue1(), GetWaveInC1(), GetWaveInC2(), GetWaveInC3(), x, GetTime()));

%wavefunction

SetLineGraph1(plot(MainHandle.axes1, x, real(z), x, imag(z)));

%title(MainHandle.axes1, 'Wave function with time', 'FontSize', 10, 'FontWeight', 'normal');
set(MainHandle.uipanelAxes1, 'Title', 'WAVE FUNCTION WITH TIME');

hl = legend(MainHandle.axes1, '$$y = real(\psi(x,t))$$', '$$y = img(\psi(x,t))$$');
set(hl, 'Interpreter', 'latex');

xlabel(MainHandle.axes1, '$$x\rightarrow$$', 'Interpreter', 'latex', 'FontSize', 10) % x-axis label
ylabel(MainHandle.axes1, '$$\psi(x,t)\rightarrow$$', 'Interpreter', 'latex', 'FontSize', 10) % y-axis label

xlim(MainHandle.axes1, [-15 15]);
ylim(MainHandle.axes1, [-0.8 0.8]);

%probability

SetLineGraph2(plot(MainHandle.axes2, x, real(p)));

%title(MainHandle.axes2, 'Probability with time', 'FontSize', 10, 'FontWeight', 'normal');
set(MainHandle.uipanelAxes2, 'Title', 'PROBABILITY WITH TIME');

hl = legend(MainHandle.axes2, '$$y = P(\psi(x,t))$$');
set(hl, 'Interpreter', 'latex');

xlabel(MainHandle.axes2, '$$x\rightarrow$$', 'Interpreter', 'latex', 'FontSize', 10) % x-axis label
ylabel(MainHandle.axes2, '$$P(x,t)\rightarrow$$', 'Interpreter', 'latex', 'FontSize', 10) % y-axis label

xlim(MainHandle.axes2, [-15 15]);
ylim(MainHandle.axes2, [-0.8 0.8]);

%current density

SetLineGraph3(plot(MainHandle.axes3, x, real(density)));

%title(MainHandle.axes3, 'Current density with time', 'FontSize', 10, 'FontWeight', 'normal');
set(MainHandle.uipanelAxes3, 'Title', 'CURRENT DENSITY WITH TIME');

hl = legend(MainHandle.axes3, '$$y = j(\psi(x,t))$$');
set(hl, 'Interpreter', 'latex');

xlabel(MainHandle.axes3, '$$x\rightarrow$$', 'Interpreter', 'latex', 'FontSize', 10) % x-axis label
ylabel(MainHandle.axes3, '$$j(x,t)\rightarrow$$', 'Interpreter', 'latex', 'FontSize', 10) % y-axis label

xlim(MainHandle.axes3, [-GetOtherSliderValue1() GetOtherSliderValue1()]);
ylim(MainHandle.axes3, [-2 2]);