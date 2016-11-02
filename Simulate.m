function Simulate()

SetApplicationState(-2);

switch GetCurrentSimulation()
    case 11
        UpdateParticleInBox1DSimulation();
    case 12
        UpdateParticleInBox2DSimulation();
    case 21
        UpdateHarmonicOscillator1DSimulation();
    case 22
        
    case 31
        UpdateParticleInFiniteBox1DSimulation();
    case 32
        
    case 41
        
    case 42
        
    case 51
        
    otherwise %may be use case 11

end
    




