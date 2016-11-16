%% caculate cross correlation between two functions for all time differences
% produce results on the same scale as corrcoef for all time differences.
% this is nessary because group xcorr runs out of memory FAST.

function [xcors, lags] = xcorcoef (lh, rh, maxlag)

    %% make sure input arrays have the same length
    lhn = length (lh);
    rhn = length (rh);
    n = min (lhn, rhn);
    if (lhn ~= rhn)
        disp ('warning, input array lengths not equal');
        lh = lh (1:n);
        rh = rh (1:n);
    end
    
    if (isempty (maxlag))
        maxlag = n;
    end
    
    %% caculate cross correlation for centered inputs
    lh = lh - mean (lh);
    rh = rh - mean (rh);
    [xraw, lags] = xcorr(lh, rh, maxlag);
       
    %% manipuate result into the same scale as corrcoef
    % xcorr output dot product for each time differences
    % for centered arrays, divide this by number of samples for covariance.
    covar = xraw / n;
    xcors = covar /(std(lh) * std (rh));

end
