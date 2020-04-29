function im = get_comp(image, opts)
%%
% get the component image from comparison image
% name from the segmentation training images
% on the halo server
%%
wd = ['\\halo1\Taubelab\Ben\Code\SegmentationTool\training_images\',...
        'SegmentationImages\inform_data\Component_Tiffs'];
iname = extractBefore(image,'comparison');
iname = [wd,'\',iname,'component_data_w_seg.tif'];
im1(:,:) = imread(iname,1);
im1 = reshape((im1./max(im1,[],'all')),[],1);
im(:,1) = im1;
%
if opts == 2
    im2(:,:) = imread(iname,9);
    im2 = reshape((im2./max(im2,[],'all')),[],1);
    %
    cols = [0 0 1;
        1 1 1];
    im(:,2) = im2;
else
    cols = [0 0 1];
end
%
im = 250 .* asinh(3.5 .* im) * cols;
im = reshape(im, 1404,1872,3);
end