%% plot data in img as a greyscale map in the specified range.

function [fhandle] = greymap (img, rng)

fhandle = figure ();
image (img, 'CDataMapping', 'scaled'); 
caxis (rng);
axis image;
colormap ('gray'); 
colorbar;

end
