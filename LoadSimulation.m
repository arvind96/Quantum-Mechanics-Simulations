function LoadSimulation()

switch GetCurrentSimulation()
    case 11
        StartParticleInBox1DSimulation();
    case 12
        StartParticleInBox2DSimulation();
    case 21
        StartHarmonicOscillator1DSimulation();
    case 22
        
    case 31
        StartParticleInFiniteBox1DSimulation();
    case 32
        
    case 41
        
    case 42
        
    case 51
        StartHydrogenAtomProbabilityDensity();
    otherwise %may be use case 11

end