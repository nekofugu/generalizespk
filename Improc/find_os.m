%% Find the Optimal offsets to allign with the pixels in the figure

% use photoshop to figure out the exact height of pixels by checking slip
% and then find optimize the image 
% the optimization should be pretty sharp if there is no slip.

function [offset, os_opt] = find_os (img, pixsize, border)

os_opt = zeros (flip( ceil(pixsize)));

tic;
for x_os = 1:ceil(pixsize(1))
    for y_os = 1:ceil(pixsize(2))
        offset = [x_os, y_os];
        [~, ~, ~, ~, tmp] = pixelate (img, pixsize, offset, border);
        os_opt (y_os, x_os) = mean (mean (tmp));
        disp (offset);
    end
end
toc;

[rowmin, minrow] = min (os_opt, [], 1);
[~, mincol] = min (rowmin, [], 2);
minrow = minrow (mincol);

offset = [mincol, minrow];
end


