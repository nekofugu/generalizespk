%% Load the image


function [] = imscan (paths, pixsize, mapsize, sigma, border, lm, filt, thresval, debugging)


%% Read in file
img = imread ([paths.inpath paths.fname '.png']);
img = 255 - mean (img, 3);

%% Find and remove the edge
[lmark, iml, imr] = figedge (img, lm.dst, lm.dif, lm.str, border);
% find edge should separte the image in 2.
% both of them still have the same size.
% one have only left half, the other only right half.
align = lm.set - lmark;


%% Detect LEC and MEC

%iori = greymap (img, [0 255]); hold on;

sharps = img - conv2 (img, gauss2D([filt.swid filt.swid]), 'same');
zeroimg = (img>0) .* conv2 ( +(img == 0), gauss2D([filt.zwid filt.zwid]), 'same') * 255.;

combimg = zeroimg + sharps + img;
%greymap (combimg, [0 255]);
%title ('composite');

imthres = conv2( +(combimg> thresval), ones(filt.twid), 'same');
imthres = imthres == 0;
%greymap (imthres, [0 1]);
%title ('threshold');

CC = bwconncomp(imthres);
cluslist = CC.PixelIdxList;
cluslist = cluslist (2:end); 
% the first one is always the the white around the figure.
calcsize = @(clus) length(clus);
clussize = cellfun (calcsize, cluslist);

[~, guessidx] = max (clussize);
guess = zeros (size (imthres) );
guess (cluslist {guessidx}) = 1;
%greymap (guess, [0 1]);

% looking for edges
[redge, rzone] = r_edge (guess, align);
[bedge, bzone] = r_edge (guess', flip (align) );
bedge = fliplr (bedge);
bzone = bzone';
zoneout = rzone & bzone;

% strategy: % locate the MEC
% find the lower edge and right edge
% merge those at button right
% extend lower edge left
% extend right edge up.

%% locate pixels

% since the figures are not aligned, 
% we need to reproject them back onto original resolution.
% assuming the sulcus are aligned.

[offset_r, os_opt_r] = find_os (imr, pixsize, border);
[~, ~, centersr, rmeans, ~] = pixelate (imr, pixsize, offset_r, border);
imr = reimage (rmeans, centersr, pixsize, align, mapsize);

[offset_l, ~] = find_os (iml, pixsize, border);
[~, ~, centersl, lmeans, ~] = pixelate (iml, pixsize, offset_l, border);
iml = reimage (lmeans, centersl, pixsize, align, mapsize);

markerl = squeeze(reshape (centersl,[],1,2));
markerl = markerl(markerl(:,1) < lmark(1), :);
markerr = squeeze(reshape (centersr,[],1,2));
markerr = markerr(markerr(:,1) > lmark(1), :);
markers = [markerl; markerr];

imnew = iml(1:mapsize(1),1:mapsize(2)) +imr (1:mapsize(1),1:mapsize(2));
imnew = conv2 (imnew, gauss2D(sigma), 'same');
%imnew = conv2 (iml+imr, gauss2D(sigma), 'same');

% will need to convolve the resulting image with a guassian

% combine aligned images into a map
% where each pixel has a list of probability and
% and associated target percentile.

%% amount of time it takes to save this file is significant.
tic
dlmwrite ([paths.outpath paths.fname '_Z' '.xls'], zoneout,'delimiter','\t');
dlmwrite ([paths.outpath paths.fname '_A' '.xls'], imnew,'delimiter','\t','precision','%.1f');
toc;

%% debuging, plotting, so on so forth.
iori = greymap (img, [0 255]);
hold on;
%figure (iori); 
plot ([lmark(1) lmark(1)], [0 lmark(2)], '-');
%figure (iori); 
plot (markers(:,1), markers(:,2), 'b+');
plot (redge(:, 2),redge(:, 1), 'g-');
plot (bedge(:, 2),bedge(:, 1), 'r-');
% button and right edges have y on the first column
% they are indexes
saveas (iori, [paths.outpath paths.fname '_F' '.png']);

ires = greymap (imnew, [0 255]);
saveas (ires, [paths.outpath paths.fname '_R' '.png']);

if (debugging)
    greymap (os_opt_r, [min(min(os_opt_r)) max(max(os_opt_r))]);
    greymap (rmeans, [0 255]);
    greymap (zoneout, [0 1]);
end

end
