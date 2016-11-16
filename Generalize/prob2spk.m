%% 
% since schreiber caculate the probability of a spike occuring
% at each time point.
% simple comparison with a random variable transforms it back.
% prob dimentions: n by 1.

function [spk] = prob2spk(prob, t)
    [ptn, chn] = size (probs); 
    spkidx = rand (ptn, chn) < prob;
    spk = t (spkidx);
end

