%% extract pixel information from flattened maps
% normally you need something sophisticated to deal with the last row
% because it partly belong to two pixels.
% however in this case we are not intrested in those.
% just hopefully pure colored pixels magnified.

function [pixels, ranges, centers, pmeans, pstds] = pixelate (img, span, offset, border)

% this makes value 1 horizontal and 2 vertical.
msize = flip (size (img));
pixnum = [ceil(msize(1)/span(1))-1 ceil(msize(2)/span(2))-1];

%centers = cell (flip(pixnum));
ranges = cell (flip(pixnum));
pixels = ranges;

centers = zeros ([flip(pixnum) 2]);
pmeans = zeros (flip(pixnum));
pstds = pmeans;

for col = 1:pixnum (1)  % horizontal
    for row = 1:pixnum (2)
        ctr = [span(1)*(col-.5)+offset(1), ...
               span(2)*(row-.5)+offset(2)];
        %centers{row, col} = ctr;
        centers(row, col, :) = ctr;
        
        xrng = (round(ctr(1)-span(1)*.5) + border) :...
                  (round(ctr(1)+span(1)*.5)- border) ;
        xrng = xrng ( xrng > 0 & xrng <= msize(1));
        yrng = (round(ctr(2)-span(2)*.5) + border) :...
                  (round(ctr(2)+span(2)*.5)- border) ;
        yrng = yrng ( yrng > 0 & yrng <= msize(2));
        
        ranges{row, col} = {yrng xrng};
        
        thispix = img(yrng, xrng);
        pixels{row, col} = thispix;
        
        flatpix = reshape (thispix, [], 1);
        pmeans (row, col) = mean(flatpix);
        pstds (row, col) = std (flatpix);

    end
end

end
