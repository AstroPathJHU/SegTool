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