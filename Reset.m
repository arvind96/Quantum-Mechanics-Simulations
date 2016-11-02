function Reset()

global MainHandle; %stores the handle for MainGUI

SetApplicationState(0);

SetTime(0);
SetTimeScale(0.55);

SetWaveInC1(0.5);
SetWaveInC1Priority(3);
SetWaveInC2(0.4);
SetWaveInC2Priority(2);
SetWaveInC3Priority(1);
NormalizeC();

cla(MainHandle.axesEquations);
cla(MainHandle.axes1);
cla(MainHandle.axes2);
cla(MainHandle.axes3);
legend(MainHandle.axes1, 'off');
legend(MainHandle.axes2, 'off');
legend(MainHandle.axes3, 'off');

zoom off;
pan off;
rotate3d off;


SetLayout();
LoadSimulation();