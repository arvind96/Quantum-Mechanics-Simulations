function [P] = CalculateProbability(Z)
P = conj(Z) .* Z;