%% Find the right edge, to find the buttom edge, transpose.

function [redge, zlft] = r_edge (imthres, align)

[rows, ~] = size (imthres);
rlast = @(row) find(imthres(row, :), 1, 'last');
redge = arrayfun (rlast, (1:rows)','UniformOutput', 0);
inrng = ~ cellfun (@isempty, redge);
redge = [find(inrng) cell2mat(redge(inrng))];

rfill = [redge(:,1)+align(1) redge(:,2)+align(2)];
zlft = zeros (size (imthres));
zlft (1:rfill(1,1), 1:rfill(1,2)) = 1;
[zhgh, ~] = size (rfill);
for rowid = 1:zhgh
    zlft (rfill(rowid,1), 1:rfill(rowid,2)) = 1;
end
