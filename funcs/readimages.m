function [app] = readimages()
wd = '\\halo1\TaubeLab\Ben\Code\SegmentationTool\training_images\SegmentationImages_RW\superpixel\Component_Tiffs\*.tif';

fnames = dir(wd);
i1 = 1;
%
fname = fullfile(fnames(i1).folder, fnames(i1).name);
im_ML = read_ML(fname);
app.fname = extractBefore(fnames(i1).name,'_component');
app.wd = extractBefore(fnames(i1).folder,'\superpixel');
%
im_IF(:,:,1) = read_inForm(app, app.fname, 0);
im_IF(:,:,2) = read_inForm(app, app.fname, 1);
im_IF(:,:,3) = read_inForm(app, app.fname, 2);
im_IF(:,:,4) = read_inForm(app, app.fname, 3);
im_IF(:,:,5) = read_inForm(app, app.fname, 4);
%
cc = 1;
for i1 = [-2, -10]
    im = read_inForm(app, app.fname, i1);
    im = im ./ max(im,[],'all');
    im_IF_tmp(:,cc) = reshape(im, [], 1);
    cc = cc + 1;
end
%
% Display DAPI and Membrane
%
app.mem_dapi_im = im_IF_tmp(:,[1 2]);
%
app.col = [1 1 1;
        0 0 1];
s = size(im_IF(:,:,1));
%
nRows = s(1);
nCols = s(2);
%
app.im_IF = im_IF;
app.im_ML = im_ML;
app.nRows = nRows;
app.nCols = nCols;
end