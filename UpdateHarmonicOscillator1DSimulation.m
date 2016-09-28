function UpdateHarmonicOscillator1DSimulation()

x = (-6:0.1:6);

while(GetApplicationState() == 1 && GetTime() < 10000)

    z = HarmonicOscillatorWave(GetWaveInC1(), GetWaveInC2(), GetWaveInC3(), x, GetTime());
    
    p = CalculateProbability(z);
    
    density = CalculateCurrentDensity(z, HarmonicOscillatorDiffWave(GetWaveInC1(), GetWaveInC2(), GetWaveInC3(), x, GetTime()));
    
    set(getfield(GetLineGraph1(), {1}), 'YData', real(z));
    set(getfield(GetLineGraph1(), {2}), 'YData', imag(z));

    set(getfield(GetLineGraph2(), {1}), 'YData', real(p));
    
    set(getfield(GetLineGraph3(), {1}), 'YData', real(density));
    
    SetTime(GetTime() + 0.1 * GetTimeScale());
    pause(0.1)

end