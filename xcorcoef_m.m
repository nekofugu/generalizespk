%% Create a 3D array of cross correlations
% for all pairs of signals and all time lags
% x and y are id of the signals
% z are are the time lags.

function [xcors, lags] = xcorcoef_m (sigs, maxlag)
[~, chn] = size (sigs); 

% group xcorr can't even do 60 seconds of it.
% will need to do them pair by pair.
xcors = zeros (chn, chn, maxlag*2+1);
tic;
for i = 1:chn
    for j = i:chn
        [xcors(i,j,:), lags] = xcorcoef (sigs(:,i), sigs(:,j), maxlag);
        xcors(j,i,:) = flip(xcors(i,j,:));
    end
end
toc;



end
