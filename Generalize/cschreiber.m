%% the gaussian convolution

function [prob_out, t, spk_rate] = cschreiber(train, interval, w_coef, fs, oversample)
s_peri = 1/(fs*oversample);
% I can oversample for the convolution, then downsample
% for later operations.

spk = train (train>interval(1) & train<interval(2));
spk_rate = length (spk) / (interval(2)-interval(1));
%width of the gaussian kernel depends on the spiking rate.
%the faster a train spikes the narrower the kernel

t = interval(1):s_peri:interval(2);
prob = zeros (length(t), 1);
idx = int32(round((spk-interval(1))/s_peri))+1;
prob (idx) = 1;

win_leng = w_coef / spk_rate;
w_buff = 6* win_leng *fs;

g_ker = gauss ( ((-w_buff):w_buff)*s_peri, win_leng, 0);
g_ker = g_ker / sum (g_ker);
% the values of gaussian kernel need to sum to one
% each value is the probability of the spike at THAT point.
% to convert back to spike train, 
% simply check if a uniform random value is smaller.

prob_out = conv (prob, g_ker, 'same');
t = t (1:oversample:end);
prob_out = prob_out (1:oversample:end);

end



