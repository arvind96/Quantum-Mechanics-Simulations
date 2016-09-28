function UpdateParticleInBox2DSimulation()

while(GetApplicationState() == 1 && GetTime() < 10000)

    [x,y] = meshgrid(0:GetOtherSliderValue1()/50:GetOtherSliderValue1());
    
    z = ParticleInBoxWave(GetOtherSliderValue1(), GetWaveInC1(), GetWaveInC2(), GetWaveInC3(), x, GetTime()) .* ParticleInBoxWave(GetOtherSliderValue1(), GetWaveInC1(), GetWaveInC2(), GetWaveInC3(), y, GetTime());

    p = CalculateProbability(z);
    
    density = CalculateCurrentDensity(z, ParticleInBoxDiffWave(10, GetWaveInC1(), GetWaveInC2(), GetWaveInC3(), x, GetTime()));
    
    set(getfield(GetSurfaceGraph1(), {1}), 'XData', x);
    set(getfield(GetSurfaceGraph1(), {1}), 'YData', y);
    set(getfield(GetSurfaceGraph1(), {1}), 'ZData', real(z));
    %set(getfield(GetLineGraph1(), {2}), 'YData', imag(z));

    set(getfield(GetSurfaceGraph2(), {1}), 'XData', x);
    set(getfield(GetSurfaceGraph2(), {1}), 'YData', y);
    set(getfield(GetSurfaceGraph2(), {1}), 'ZData', real(p));
    
    %set(getfield(GetLineGraph3(), {1}), 'YData', real(density));
    
    SetTime(GetTime() + 0.1 * GetTimeScale());
    pause(0.1)

end