%% plot cross correlations between a pair of probabilities

function [] = plotxcor (xcors, lags, idxz, ref, other, rows, cols)
    subplot (rows, cols, other);
    sig = squeeze (xcors (ref, other, :));
    plot (lags, sig);
    grid on;
    axis ([min(lags) max(lags) -1 1]);
    xlabel sec;
    title (num2str(other));
    
    %val_zero = sig(idxz);
    %text (lags(idxz), val_zero, num2str(val_zero, 3));
    
    %[valmin, idxmin] = min (sig);
    %text (lags(idxmin), valmin, num2str(valmin));
    %[valmax, idxmax] = max (sig);
    %text (lags(idxmax), valmax, num2str(valmax));
end
