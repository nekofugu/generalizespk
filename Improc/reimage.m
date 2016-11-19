%% Project the pixels back to the original resolution
% the align vector is the difference between the detected edge and 
% location of the edge on the aligned images.

function [imnew] = reimage (pmeans, centers, pixsize, align, imsize)
%ctrlast = squeeze(centers (end, end, :));
%imnew = zeros (round(ctrlast(1)+pixsize(1)), round (ctrlast(2)+pixsize(2)));
imnew = zeros (imsize);
pixnum = flip(size (pmeans) );

for xidx = 1:pixnum(1)
    for yidx = 1:pixnum(2)
        thisctr = squeeze (centers (yidx, xidx, :));
        low = round(align+thisctr'-pixsize/2);
        hgh = round(align+thisctr'+pixsize/2);
        imnew (low(2):hgh(2), low(1):hgh(1)) = pmeans (yidx, xidx);
    end
end

end
