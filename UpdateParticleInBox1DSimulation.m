function UpdateParticleInBox1DSimulation()

while(GetApplicationState() == 1 && GetTime() < 10000)

    x = (0:GetOtherSliderValue1()/100:GetOtherSliderValue1());
    
    z = ParticleInBoxWave(GetOtherSliderValue1(), GetWaveInC1(), GetWaveInC2(), GetWaveInC3(), x, GetTime());
    
    p = CalculateProbability(z);
    
    density = CalculateCurrentDensity(z, ParticleInBoxDiffWave(GetOtherSliderValue1(), GetWaveInC1(), GetWaveInC2(), GetWaveInC3(), x, GetTime()));
    
    set(getfield(GetLineGraph1(), {1}), 'XData', x);
    set(getfield(GetLineGraph1(), {2}), 'XData', x);
    set(getfield(GetLineGraph1(), {1}), 'YData', real(z));
    set(getfield(GetLineGraph1(), {2}), 'YData', imag(z));

    set(getfield(GetLineGraph2(), {1}), 'XData', x);
    set(getfield(GetLineGraph2(), {1}), 'YData', real(p));
    
    set(getfield(GetLineGraph3(), {1}), 'XData', x);
    set(getfield(GetLineGraph3(), {1}), 'YData', real(density));
    
    SetTime(GetTime() + 0.1 * GetTimeScale());
    pause(0.1)

end