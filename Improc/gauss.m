function [y] = gauss (x, sig, center)
y = exp ( - (x - center).^2 / (2 * sig .^2));
end
