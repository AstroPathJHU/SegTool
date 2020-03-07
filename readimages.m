function [app] = readimages()
wd = '\\bki04\Segmentation\IF_Membrane\ML_data\Component_Tiffs\*.tif';
fnames = dir(wd);
i1 = 2;
%
fname = fullfile(fnames(i1).name);
im_ML = read_ML(fname);
%
im_IF(:,:,1) = read_inForm(fname, 1);
im_IF(:,:,2) = read_inForm(fname, 2);
%
cc = 1;
for i1 = [-2, -10]
    im = read_inForm(fname, i1);
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