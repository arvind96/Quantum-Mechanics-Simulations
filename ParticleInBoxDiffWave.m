function [z] = ParticleInBoxDiffWave(L, c1, c2, c3, x, t)
    z = c1 * (2/L)^0.5 * (1*pi / L) *cos(1*pi*x / L) * exp(-1i*CalculateEnergy(1, L)*t / 1) + + c2 * (2/L)^0.5 * (2*pi / L) *cos(2*pi*x / L) * exp(-1i*CalculateEnergy(2, L)*t / 1) + c3 * (2/L)^0.5 * (3*pi / L) *cos(3*pi*x / L) * exp(-1i*CalculateEnergy(3, L)*t / 1);
end

function e = CalculateEnergy(n, L)
    e = n^2 * pi^2 * 1 / 2 * 1 * L^2;
end