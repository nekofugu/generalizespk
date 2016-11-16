%% Testing normalized schreiber method.

clear;
close all;
clc;

%load ('R52_CA1.mat');
load ('R44_CA3.mat');

%train = allts {2,4};

interval = [0 400];
w_coef = 1/6;
% coef of 1/2 create a continous curve - firing rate
% of 1/8 create a field of distinct spikes - firing probability.
fs = 1000;
oversample = 1;


%% Discretize data into firing probabilities

ts = reshape (allts, [], 1);
hasspk = ~cellfun (@isempty, ts);
ts = ts (hasspk);

spk2prob = @ (spk) cschreiber (spk, interval, w_coef, fs, oversample);
tic;
[probs, t, rates] = cellfun (spk2prob, ts, 'UniformOutput', 0);
toc;

probs = cell2mat (probs');
[ptn, chn] = size (probs); 
t = t{1}';

rates = cell2mat (rates);


%% Largely uncorrelated, each component have one power that is 85% or over
% especially if centered.
%[coefs, comps, late] = pca (probs, 'Centered', false);
[coefs, comps, late] = pca (probs, 'Centered', true);
figure ();
clrbar3 (coefs);
xlabel ('comps');
ylabel ('sigs');
title ('PCA coefficients');

corrs = corrcoef (probs);
figure ();
clrbar3 (corrs);
title ('Signal Corr');

dists = dschreiber (probs);
distsrt = sort (dists);
figure ();
clrbar3 (dists)
title ('Schreiber Dist');
figure ();
plot (distsrt);
axis ([0 chn-1 0 1]);
grid on;


%% draw the first two as an example
showidx = 1:10000;
showchn = [2 3];
figure();
plot (showidx/fs, probs(showidx, showchn));
grid on;
