%% Load the image

clear;
close all;

img = imread ('0_25_A.png');
img = 255 - mean (img, 3);

lmdst = 14;
lmstr = 255;
border = 3;

ori = greymap (img, [0 255]);

%% Find and remove the edge
[edge, iml, imr] = figedge (img, lmdst, lmstr, border);
% find edge should separte the image in 2.
% both of them still have the same size.
% one have only left half, the other only right half.


%% locate pixels

% pixels are 24X15
pixsize = [24.5 15.5]; % horizontal and vertical
% looping through offset to see which one produces the minimum variance

[offset, os_opt] = find_os (imr, pixsize, border);
greymap (os_opt, [min(min(os_opt)) max(max(os_opt))]);

[pixels, ranges, centers, pmeans, pstds] = pixelate (imr, pixsize, offset, border);
greymap (pmeans, [0 255]);

centerp = squeeze (reshape (centers, [], 1, 2));
figure (ori); hold on;
plot (centerp(:,1), centerp(:,2), '+');

%%  need to find the first pixel to the right and below the edge


%investigate 2 things
% pixels on the left of the landmark does not appear continous with pixels
% on the right 
% confirmed, aligned only vertically.
% 30 cells, photoshop measures 759 long.
% actual length is 25.33 ?


% pixels to the far right appears to be slipping slightly.
