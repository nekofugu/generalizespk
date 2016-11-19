%% Create 2D gaussian convolution filter
function [gaussf] = gauss2D (sigma)

% creating a guassian smoothing filter.
fwid = 4;
fwin = round(fwid * sigma);

gaussx = 1;
if (sigma (1) > 0)
    gaussx = gauss (-fwin(1):fwin(1), sigma(1), 0);
end

gaussy = 1;
if (sigma (2) > 0)
    gaussy = gauss (-fwin(2):fwin(2), sigma(2), 0)';
end

xlen = length(gaussx);
ylen = length(gaussy);  
% because when you repmat something, their length changes.

gaussx = repmat(gaussx, ylen, 1);
gaussy = repmat(gaussy, 1, xlen);
gaussf = gaussx .* gaussy;
gaussf = gaussf / sum(sum(gaussf));

% imnew = conv2 (imnew, gaussf, 'same');

end
