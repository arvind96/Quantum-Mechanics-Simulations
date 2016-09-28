function [J] = CalculateCurrentDensity(Z, DelZOverDelx)
J = imag (conj(Z) .* DelZOverDelx);