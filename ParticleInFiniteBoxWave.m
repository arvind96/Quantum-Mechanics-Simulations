function [z] = ParticleInFiniteBoxWave(c1, c2, c3, x, t)
    %returns the wavefunction with center of box as origin and length L
    
    %v1 = 1.28
    %v2 = 2.54
    %v3 = 3.73
    
    L = 10;
    
    if(x < -L/2)    %-Inf to -L/2
        z = c1 * 27.5606 * exp((2 * (0.632 - CalculateEnergy(1.28, L)))^0.5 * x) * exp(-1i * CalculateEnergy(1.28, L) * t / 1);
    elseif(x < L/2) %-L/2 to L/2
        z = c1 * 0.4033 * 1 * cos((2 * CalculateEnergy(1.28, L)) ^ 0.5 * x) * exp(-1i * CalculateEnergy(1.28, L) * t / 1);
    else    %L/2 to Inf
        z = c1 * 27.5606 * exp(-(2 * (0.632 - CalculateEnergy(1.28, L)))^0.5 * x) * exp(-1i * CalculateEnergy(1.28, L) * t / 1);
    end
    
    if(x < -L/2)    %-Inf to -L/2
        z = z + c2 * (-1) * (8.4501) * exp((2 * (0.632 - CalculateEnergy(2.54, L)))^0.5 * x) * exp(-1i * CalculateEnergy(2.54, L) * t / 1);
    elseif(x < L/2) %-L/2 to L/2
        z = z + c2 * 0.0985 * 1 * sin((2 * CalculateEnergy(2.54, L)) ^ 0.5 * x) * exp(-1i * CalculateEnergy(2.54, L) * t / 1);
    else    %L/2 to Inf
        z = z + c2 * (8.4501) * exp(-(2 * (0.632 - CalculateEnergy(2.54, L)))^0.5 * x) * exp(-1i * CalculateEnergy(2.54, L) * t / 1);
    end
    
    if(x < -L/2)    %-Inf to -L/2
        z = z + c3 * (-21.9790) * exp((2 * (0.632 - CalculateEnergy(3.73, L)))^0.5 * x) * exp(-1i * CalculateEnergy(3.73, L) * t / 1);
    elseif(x < L/2) %-L/2 to L/2
        z = z + c3 * (0.3940) * 1 * cos((2 * CalculateEnergy(3.73, L)) ^ 0.5 * x) * exp(-1i * CalculateEnergy(3.73, L) * t / 1);
    else    %L/2 to Inf
        z = z + c3 * (-21.9790) * exp(-(2 * (0.632 - CalculateEnergy(3.73, L)))^0.5 * x) * exp(-1i * CalculateEnergy(3.73, L) * t / 1);
    end

end

function e = CalculateEnergy(Vn, L)
    e = (2 * 1 * Vn^2)/(1 * L^2);
end