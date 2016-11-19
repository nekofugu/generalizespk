%% Specify parameters.

clear;
close all;

lm.dst = 13;
lm.dif = 65;
lm.str = 95;
lm.set = [300 100];

border = 3;

% pixels are 24X15
pixsize = [24.5 15.5]; % horizontal and vertical
% looping through offset to see which one produces the minimum variance
sigma = pixsize/2;

mapsize = [650 1200];

filt.swid =3; 
filt.zwid =6;
filt.twid = 5;

thresval = 180;

paths.fname = '0_25_B';
paths.inpath = '..\\Inputs\\';
paths.outpath = '..\\Tables\\';

imscan (paths, pixsize, mapsize, sigma, border, lm, filt, thresval, 0);
