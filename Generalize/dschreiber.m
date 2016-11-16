%% Caculate normalized similarities according to distances.
% there is the Schreiber distance, but it's not very good
% van Rossum's measure is probably better
% van Rossum distnace is systematically effected by spiking rate
% while Schreiber's isn't.


function [dists] = dschreiber (probs)
    
    [~, chn] = size (probs); 

    dists = zeros (chn);

    mag_calc = @(n) sqrt (dot(probs(:,n), probs(:,n)));
    magns = arrayfun (mag_calc, 1:chn);

    for i = 1:chn
        for j= i:chn
            dists (i,j) = dot (probs(:,i), probs(:,j)) / (magns (i)* magns(j));
        end 
    end

    dists = dists + dists' - eye (chn);
end
