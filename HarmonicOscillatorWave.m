function [z] = HarmonicOscillatorWave(c1, c2, c3, x, t)
    z = c1 .* exp((-x.^2)/2) .* exp(-1i * 1 * t/2) + c2 .* 2^0.5 .* x .* exp((-x.^2)/2) .* exp(-1i * 3 * t/2) + c3 .* 2^(-0.5) .* (2 .* x.^2 - 1) .* exp((-x.^2)/2) .* exp(-1i * 5 * t/2);
end