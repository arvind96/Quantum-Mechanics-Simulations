function StartHarmonicOscillator1DSimulation()

global MainHandle; %stores the handle for MainGUI

%Reset here
SetTime(0);
SetTimeScale(0.5500);

set(MainHandle.uipanelTopControls, 'Title', 'HARMONIC OSCILLATOR in 1D');

cla(MainHandle.axesEquations);

%wave equation
str = '$$\psi_n(y,t) = \left(\frac{\alpha}{\pi}\right)^{1/4}\frac{1}{\sqrt{2^{n}n!}} H_n(y) e^{-y^{2}/2} e^{-\frac{\iota E_n t}{\hbar}}  \;\;\;\;\; where, \; y = \sqrt{\alpha}x, \; \alpha = \frac{m\omega}{\hbar}$$';
text(0.0 , 0.75, str, 'Interpreter', 'latex', 'FontSize', 12, 'Parent', MainHandle.axesEquations);

str = '$$\psi(x,t) = \sum_{n=1}^{\infty}{c_n \psi_n(x,t)}  \;\;\;\;\;  P(x,t) = \psi^{*}(x,t) \psi(x,t)$$';
text(0.0 , 0.25, str, 'Interpreter', 'latex', 'FontSize', 12, 'Parent', MainHandle.axesEquations);

set(MainHandle.uipanelOther1, 'Visible', 'Off');
set(MainHandle.uipanelOther2, 'Visible', 'Off');
set(MainHandle.uipanelOther3, 'Visible', 'Off');

x = (-6:0.1:6);
    
z = HarmonicOscillatorWave(GetWaveInC1(), GetWaveInC2(), GetWaveInC3(), x, GetTime());

p = CalculateProbability(z);

density = CalculateCurrentDensity(z, HarmonicOscillatorDiffWave(GetWaveInC1(), GetWaveInC2(), GetWaveInC3(), x, GetTime()));

%wavefunction

SetLineGraph1(plot(MainHandle.axes1, x, real(z), x, imag(z)));

set(MainHandle.uipanelAxes1, 'Title', 'WAVE FUNCTION WITH TIME');

hl = legend(MainHandle.axes1, '$$y = real(\psi(x,t))$$', '$$y = img(\psi(x,t))$$');
set(hl, 'Interpreter', 'latex');

xlabel(MainHandle.axes1, '$$x\rightarrow$$', 'Interpreter', 'latex', 'FontSize', 10) % x-axis label
ylabel(MainHandle.axes1, '$$\psi(x,t)\rightarrow$$', 'Interpreter', 'latex', 'FontSize', 10) % y-axis label

xlim(MainHandle.axes1, [-6 6]);
ylim(MainHandle.axes1, [-1.5 1.5]);

%probability

SetLineGraph2(plot(MainHandle.axes2, x, real(p)));

set(MainHandle.uipanelAxes2, 'Title', 'PROBABILITY WITH TIME');

hl = legend(MainHandle.axes2, '$$y = P(\psi(x,t))$$');
set(hl, 'Interpreter', 'latex');

xlabel(MainHandle.axes2, '$$x\rightarrow$$', 'Interpreter', 'latex', 'FontSize', 10) % x-axis label
ylabel(MainHandle.axes2, '$$P(x,t)\rightarrow$$', 'Interpreter', 'latex', 'FontSize', 10) % y-axis label

xlim(MainHandle.axes2, [-6 6]);
ylim(MainHandle.axes2, [-1.5 1.5]);

%current density

SetLineGraph3(plot(MainHandle.axes3, x, real(density)));

set(MainHandle.uipanelAxes3, 'Title', 'CURRENT DENSITY WITH TIME');

hl = legend(MainHandle.axes3, '$$y = j(\psi(x,t))$$');
set(hl, 'Interpreter', 'latex');

xlabel(MainHandle.axes3, '$$x\rightarrow$$', 'Interpreter', 'latex', 'FontSize', 10) % x-axis label
ylabel(MainHandle.axes3, '$$j(x,t)\rightarrow$$', 'Interpreter', 'latex', 'FontSize', 10) % y-axis label

xlim(MainHandle.axes3, [-6 6]);
ylim(MainHandle.axes3, [-1.5 1.5]);

