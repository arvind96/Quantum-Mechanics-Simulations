function StartParticleInBox2DSimulation()

global MainHandle; %stores the handle for MainGUI

%Reset here
SetTime(0);
SetTimeScale(0.0003);

set(MainHandle.uipanelTopControls, 'Title', 'PARTICLE in 2D BOX');

cla(MainHandle.axesEquations);

%wave equation
str = '$$\psi_n(x,t) = \sqrt{\frac{2}{L_x}}\sin\left(\frac{n \pi}{L_x}x\right)e^{-\frac{\iota E_n t}{\hbar}} \;\;\;\;\; \psi_n(y,t) = \sqrt{\frac{2}{L_y}}\sin\left(\frac{n \pi}{L_y}y\right)e^{-\frac{\iota E_n t}{\hbar}}$$';
text(0.0 , 0.75, str, 'Interpreter', 'latex', 'FontSize', 12, 'Parent', MainHandle.axesEquations);

str = '$$\psi(x,y,t) = \psi(x,t) \psi(y,t)  \;\;\;\;\;  P(x,y,t) = \psi^{*}(x,y,t) \psi(x,y,t)$$';
text(0.0 , 0.25, str, 'Interpreter', 'latex', 'FontSize', 12, 'Parent', MainHandle.axesEquations);

set(MainHandle.uipanelOther1, 'Visible', 'On');
set(MainHandle.uipanelOther2, 'Visible', 'Off');
set(MainHandle.uipanelOther3, 'Visible', 'Off');

set(MainHandle.sliderOther1, 'Min', 3.00, 'Max', 10.00);
SetOtherSliderValue1(6.00);


[x,y] = meshgrid(0:GetOtherSliderValue1()/50:GetOtherSliderValue1());
    
z = ParticleInBoxWave(GetOtherSliderValue1(), GetWaveInC1(), GetWaveInC2(), GetWaveInC3(), x, GetTime()) .* ParticleInBoxWave(GetOtherSliderValue1(), GetWaveInC1(), GetWaveInC2(), GetWaveInC3(), y, GetTime());

p = CalculateProbability(z);

density = CalculateCurrentDensity(z, ParticleInBoxDiffWave(10, GetWaveInC1(), GetWaveInC2(), GetWaveInC3(), x, GetTime()));

%wavefunction

SetSurfaceGraph1(mesh(MainHandle.axes1, x, y, real(z)));

set(MainHandle.uipanelAxes1, 'Title', 'WAVE FUNCTION WITH TIME');

%legend(MainHandle.axes1, texlabel('z = real(psi(x,y,t))'),texlabel('y = img(psi(x,t))'));

xlabel(MainHandle.axes1, '$$x$$', 'Interpreter', 'latex', 'FontSize', 10) % x-axis label
ylabel(MainHandle.axes1, '$$y$$', 'Interpreter', 'latex', 'FontSize', 10) % y-axis label
zlabel(MainHandle.axes1, '$$\psi(x,t)\rightarrow$$', 'Interpreter', 'latex', 'FontSize', 10) % z-axis label

xlim(MainHandle.axes1, [0 GetOtherSliderValue1()]);
ylim(MainHandle.axes1, [0 GetOtherSliderValue1()]);
zlim(MainHandle.axes1, [-1 1]);

caxis(MainHandle.axes1, [-1,1]);

%probability

SetSurfaceGraph2(mesh(MainHandle.axes2, x, y, real(p)));

set(MainHandle.uipanelAxes2, 'Title', 'PROBABILITY WITH TIME');

%legend(MainHandle.axes2, texlabel('z = P(psi(x,y,t))'));

xlabel(MainHandle.axes2, '$$x$$', 'Interpreter', 'latex', 'FontSize', 10) % x-axis label
ylabel(MainHandle.axes2, '$$y$$', 'Interpreter', 'latex', 'FontSize', 10) % y-axis label
zlabel(MainHandle.axes2, '$$P(x,y,t)\rightarrow$$', 'Interpreter', 'latex', 'FontSize', 10) % z-axis label

xlim(MainHandle.axes2, [0 GetOtherSliderValue1()]);
ylim(MainHandle.axes2, [0 GetOtherSliderValue1()]);
zlim(MainHandle.axes2, [0.0 1.0]);

caxis(MainHandle.axes2, [-1,1]);

%current density

SetLineGraph3(plot(MainHandle.axes3, x, real(density)));

set(MainHandle.uipanelAxes3, 'Title', 'CURRENT DENSITY WITH TIME');

legend(MainHandle.axes3, texlabel('y = j(psi(x,t))'));

xlabel(MainHandle.axes3, '$$x\rightarrow$$', 'Interpreter', 'latex', 'FontSize', 10) % x-axis label
ylabel(MainHandle.axes3, '$$j(x,t)\rightarrow$$', 'Interpreter', 'latex', 'FontSize', 10) % y-axis label

xlim(MainHandle.axes3, [0 GetOtherSliderValue1()]);
ylim(MainHandle.axes3, [-1.5 1.5]);





