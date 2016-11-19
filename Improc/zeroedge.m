%% find array members bordering zeros at distance of dist.
% actually this is kind of pointless
% just convolve area of zeros with a filter and it'd be fine.

function [zeroimg] = zeroedge (img, d)
    zeropt = img == 0;
    zerosft = zeropt (1:(end-2*d),(1+d):(end-d)) | zeropt ((1+2*d):end,(1+d):(end-d)) | ...
              zeropt ((1+d):(end-d),1:(end-2*d)) | zeropt ((1+d):(end-d),(1+2*d):end);
    zeroimg = zeros (size(img));
    zeroimg ((1+d):(end-d),(1+d):(end-d)) = zerosft;
end
