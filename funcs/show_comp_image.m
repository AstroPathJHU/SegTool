function show_comp_image(i1)
%% -----------------------------------------
%% show the ML image overlayed with the inform multipass 
%% -----------------------------------------
wd = '\\bki04\Segmentation\IF_Membrane\Correction\*.tif';
fnames = dir(wd);
%
fname = fnames(i1).name;
image_info = imfinfo(fullfile(fnames(i1).folder,fname));
H = image_info(1).Height;
W = image_info(1).Width;
%
% get the dapi only image
%
[im_full, im_mem, im_dapi] = color_im(fname);
im_dapis = reshape(im_dapi, H, W, 3);
F = figure('units','normalized','outerposition',[0 0 1 1])
Rect = [0.1, 0.07, 0.9, 0.9];
[pos1, pos] = tight_subplot(2, 2, .01, 0.01, 0.18);
axes( pos1(3));
imshow(uint8(im_dapis));
%
im_mem = reshape(im_mem, H, W, 3);
axes(pos1(4));
imshow(uint8(im_mem));
%
im_full = reshape(im_full, H, W, 3);
axes(pos1(1));
imshow(uint8(im_full));
%
% get the ML image in green
%
im_ML = zeros(H * W, 3);
im_ML(:,2) = read_ML(fname);
im_ML(:,2) = .5 * 255 .* (im_ML(:,2) > 0);
%
% get the immune and tumor images in red
%
im1 = read_inForm(fname, 1);
%
im2 = read_inForm(fname, 2);
%
im_IF = zeros(H*W, 3);
im_IF(:,1) = im1 + im2;
im_IF(:,1) = .5 * 255 .* (im_IF(:,1) > 0);
%
% take a subtraction of the two mask to make final mask 
%
im_mask = im_ML + im_IF;
im_f = im_mask + im_dapi;
im_f = reshape(im_f, H, W,3);
%imshow(uint8(im_f))
%
im_mask = reshape(im_mask, H, W, 3);
axes(pos1(2)); imshow(uint8(im_mask));
linkaxes(pos1,'xy')
%maxfig(F,1); 
%
end