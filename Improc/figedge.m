%% Detect the rihnal sulcus ? landmark
% there box is denoted by two bright lines separated by a fixed distance


function [edge, iml, imr] = figedge (img, lmdst, lmstr, border)

isize = size(img);

% just subract a slided pciture with itself
lshft = img (:, 1:(end-lmdst));
rshft = img (:, (1+lmdst):end);
diff = rshft - lshft;
nodiff = diff == 0;
hlight = lshft == lmstr;
lmark = nodiff & hlight;

% it's so thin you can't see it
% but code can find it.
findlm = @(row) find(lmark(row,:), 1);
ledge = arrayfun (findlm, 1:isize(1), 'UniformOutput', 0);
medge = cell2mat (ledge);

xedge = mode (medge);

hasedge = @(rescel) ~isempty(rescel) && rescel == xedge;
yedge = cellfun (hasedge, ledge);
yedge = find (yedge, 1);
edge = [xedge yedge];

% the best way to align the figures
% is probably by the first pixel.
iml = img;
imr = img;

iml (:, (xedge-border):end) = 0;
imr (:, 1:(xedge+lmdst+border)) = 0;

%img (:,(-border:lmdst+border)+xedge) = 0;

end
