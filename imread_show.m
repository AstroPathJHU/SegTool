
function [] = imread_show(i1)
wd = '\\bki04\Segmentation\IF_Membrane\Correction\*.tif';
fnames = dir(wd);
%
%i1 = 2;

fname = fullfile(fnames(i1).folder,fnames(i1).name);
im1 = imread(fname,1);
figure();imshow(im1>0)
im2 = imread(fname,2);
figure();imshow(im2>0)
end