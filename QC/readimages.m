%
function app = readimages(app)
%%
% this function reads in the images and gather necessary
% metadata along the way
%
%%
%
% get the inform image number of layers and dims
%
app.e = 0;
try
    im_info = imfinfo(app.IF_filename);
catch
    app.e = 2;
end
%
layers = length(im_info);
app.nRows = im_info(1).Height;
app.nCols = im_info(1).Width;
%
if layers ~= 15
    app.e = 1;
    return;
end
%
% read INFORM IMAGE
%
try
    ic = 0;
    app.im_IF = zeros(app.nRows, app.nCols, 5);
    for i1 = 11:15
        ic = ic + 1;
        app.im_IF(:,:,ic) = imread(app.IF_filename,i1);
    end
    %
    ic = 0;
    app.mem_dapi_im = zeros(app.nRows * app.nCols, 2);
    for i1 = [1, 9]
        im = imread(app.IF_filename, i1);
        im = im ./ max(im,[],'all');
        ic = ic + 1;
        app.mem_dapi_im(:,ic) = reshape(im, [], 1);
    end
    %
catch
    app.e = 2;
end
%
% read the superpixel image; we denote this as SP in the code
% for 'machine learning'
%
%
try
    app.im_SP = zeros(app.nRows, app.nCols, 2);
    for i1 = 1:2
        app.im_SP(:,:,i1) = imread(app.SP_filename, i1);
    end
catch
    app.e = 3;
end
%
% create inform segmenation boundary image
%
app.im_IF_seg_brds = zeros(app.nRows, app.nCols, 1);
%
for i1 = 2:3
    brd = (imdilate(app.im_IF(:,:,i1), ...
        ones(3,3)) - app.im_IF(:,:,i1)) > 0;
    app.im_IF_seg_brds(brd) = app.seg_col;
end
%
% create superpixel segmenation boundary image
%
app.im_SP_seg_brds = zeros(app.nRows, app.nCols, 1);
%
for i1 = 1:2
    brd = (imdilate(app.im_SP(:,:,i1), ...
        ones(3,3)) - app.im_SP(:,:,i1)) > 0;
    app.im_SP_seg_brds(brd) = app.seg_col;
end
%
end
%