wd1 = '\\halo1\TaubeLab\Ben\Code\SegmentationTool\training_images\SegmentationImages_Guillermo';
imname = 'Liver_TMA_145_23_01.30.2020_[6435,55763]';
%
fn1 = [wd1,'\inform_data\Component_Tiffs\',imname,'_component_data_w_seg.tif'];
fn2 = [wd1,'\superpixel\Component_Tiffs\',imname,'_component_data_seg.tif'];
%
ic = 1;
im = [];
image_info = imfinfo(fn1);
H = image_info(1).Height;
W = image_info(1).Width;
%
for i1 = [1,9]
    ima = imread(fn1, i1);
    ima = reshape(ima, [], 1);
    ima = ima ./ max(ima);
    im(:,ic) = ima;
    ic = ic + 1;
end
%
imc = (225 .* asinh(2 .* im)) * [0 0 1;
                            1 1 1];
imc1 = reshape(imc, H, W, 3);
%imshow(uint8(imc1));
%
im1 = imread(fn1, 11);
im1(:,:,2) = imread(fn1, 12);
%
im1_ii = im1(:,:,1) > 0;
im1_ii = im1_ii + im1(:,:,2)>0;
im1_ii_r = cat(3, 255 * im1_ii, zeros(H,W, 2)); 
%
im2 = imread(fn2, 1);
im2_ii = im2 > 0;
im2_ii_g = cat(3, zeros(H,W), 255 * im2_ii, zeros(H,W));
%
im_t = im1_ii_r + im2_ii_g + imc1;
imshow(uint8(im_t))
%

                        