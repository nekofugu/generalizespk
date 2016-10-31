%% Caculate normalized similarities according to distances.
% there is the Schreiber distance, but it's not very good
% van Rossum's measure is probably better
% van Rossum distnace is systematically effected by spiking rate
% while Schreiber's isn't.


function [dists] = drossum (probs)
    
    [~, chn] = size (probs); 

    dists = zeros (chn);

    for i = 1:chn
        for j= i:chn
            dists (i, j) = mean ((probs(:,i)- probs(:,j)).^2);
        end 
    end

    %dists = dists + dists' - eye (chn);
    dists = dists + dists';
end
