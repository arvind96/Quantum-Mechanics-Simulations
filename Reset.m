function Reset()

SetApplicationState(0);

SetTime(0);
SetTimeScale(0.55);

SetWaveInC1(0.5);
SetWaveInC1Priority(3);
SetWaveInC2(0.4);
SetWaveInC2Priority(2);
SetWaveInC3Priority(1);
NormalizeC();

SetLayout();
LoadSimulation();