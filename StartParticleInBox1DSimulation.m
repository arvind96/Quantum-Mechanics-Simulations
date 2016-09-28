function StartParticleInBox1DSimulation()

global MainHandle; %stores the handle for MainGUI

%Reset here
SetTime(0);
SetTimeScale(0.0003);

set(MainHandle.uipanelTopControls, 'Title', 'PARTICLE in 1D BOX');

cla(MainHandle.axesEquations);

%wave equation
str = '$$\psi_n(x,t) = \sqrt{\frac{2}{L}}\sin\left(\frac{n \pi}{L}x\right)e^{-\frac{\iota E_n t}{\hbar}}$$';
text(0.0 , 0.75, str, 'Interpreter', 'latex', 'FontSize', 12, 'Parent', MainHandle.axesEquations);

str = '$$\psi(x,t) = \sum_{n=1}^{\infty}{c_n \psi_n(x,t)}  \;\;\;\;\;  P(x,t) = \psi^{*}(x,t) \psi(x,t)$$';
text(0.0 , 0.25, str, 'Interpreter', 'latex', 'FontSize', 12, 'Parent', MainHandle.axesEquations);

set(MainHandle.uipanelOther1, 'Visible', 'On');
set(MainHandle.uipanelOther2, 'Visible', 'Off');
set(MainHandle.uipanelOther3, 'Visible', 'Off');

set(MainHandle.sliderOther1, 'Min', 3.00, 'Max', 10.00);
SetOtherSliderValue1(6.00);


x = (0:GetOtherSliderValue1()/100:GetOtherSliderValue1());
    
z = ParticleInBoxWave(GetOtherSliderValue1(), GetWaveInC1(), GetWaveInC2(), GetWaveInC3(), x, GetTime());

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

xlim(MainHandle.axes1, [0 GetOtherSliderValue1()]);
ylim(MainHandle.axes1, [-1.5 1.5]);

%probability

SetLineGraph2(plot(MainHandle.axes2, x, real(p)));

%title(MainHandle.axes2, 'Probability with time', 'FontSize', 10, 'FontWeight', 'normal');
set(MainHandle.uipanelAxes2, 'Title', 'PROBABILITY WITH TIME');

hl = legend(MainHandle.axes2, '$$y = P(\psi(x,t))$$');
set(hl, 'Interpreter', 'latex');

xlabel(MainHandle.axes2, '$$x\rightarrow$$', 'Interpreter', 'latex', 'FontSize', 10) % x-axis label
ylabel(MainHandle.axes2, '$$P(x,t)\rightarrow$$', 'Interpreter', 'latex', 'FontSize', 10) % y-axis label

xlim(MainHandle.axes2, [0 GetOtherSliderValue1()]);
ylim(MainHandle.axes2, [-1.5 1.5]);

%current density

SetLineGraph3(plot(MainHandle.axes3, x, real(density)));

%title(MainHandle.axes3, 'Current density with time', 'FontSize', 10, 'FontWeight', 'normal');
set(MainHandle.uipanelAxes3, 'Title', 'CURRENT DENSITY WITH TIME');

hl = legend(MainHandle.axes3, '$$y = j(\psi(x,t))$$');
set(hl, 'Interpreter', 'latex');

xlabel(MainHandle.axes3, '$$x\rightarrow$$', 'Interpreter', 'latex', 'FontSize', 10) % x-axis label
ylabel(MainHandle.axes3, '$$j(x,t)\rightarrow$$', 'Interpreter', 'latex', 'FontSize', 10) % y-axis label

xlim(MainHandle.axes3, [0 GetOtherSliderValue1()]);
ylim(MainHandle.axes3, [-1.5 1.5]);





