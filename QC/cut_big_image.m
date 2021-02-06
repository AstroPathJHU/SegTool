%% cut_big_image
% cut the big images into 4 parts to aid in work reduction
%% Usage
% wd = working directory with inform and superpixel sub images
% im = image name
%% example
% wd = '\\halo1\TaubeLab\Ben\Code\SegmentationTool\training_images\SegmentationImages'
% im = 'Melanoma_TMA_1287_40_01.30.2020_[5856,47509]'
%%
function [] = cut_big_image(wd, im)
%
% set image output properties
%
ds.Photometric = Tiff.Photometric.MinIsBlack;
ds.BitsPerSample   = 16;
ds.SamplesPerPixel = 1;
ds.SampleFormat = Tiff.SampleFormat.IEEEFP;
ds.RowsPerStrip = 41;
ds.MaxSampleValue = 256;
ds.MinSampleValue = 0;
ds.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
ds.Software = 'MATLAB';
ds.ResolutionUnit = Tiff.ResolutionUnit.Inch;
ds.XResolution = 300;
ds.YResolution = 300;
ds.Compression = Tiff.Compression.LZW;
%
% image names and info
%
im_name_IF = [wd,'\inform_data\Component_Tiffs\',...
    im,'_component_data_w_seg.tif'];
im_name_S = [wd,'\superpixel\Component_Tiffs\',...
    im,'_component_data_seg.tif'];
%
% image info
%
image_info = imfinfo(im_name_IF);
H = image_info(1).Height;
W = image_info(1).Width;
ds.BitsPerSample = image_info(1).BitDepth;
ds.ImageLength = H;
ds.ImageWidth = W;
l_IF = size(image_info, 1);
l_S = size(imfinfo(im_name_S), 1);
%
% compute the fourths
%
HT4 = H/ 2;
WT4 = W/ 2;
%
H1 = 1:(HT4+10);
H2 = (HT4-9):H;
W1 = 1:(WT4+10);
W2 = (WT4-9):W;
%
% compile the superpixel out image
%
im_S_o = zeros(H, W, l_S, 4);
%
for i1 = 1:l_S
    im_S = imread(im_name_S, i1);
    im_S_o(H1,W1,i1, 1) = im_S(H1,W1);
    im_S_o(H1,W2,i1, 2) = im_S(H1,W2);
    im_S_o(H2,W1,i1, 3) = im_S(H2,W1);
    im_S_o(H2,W2,i1, 4) = im_S(H2,W2);
    %
    for i2 = 1:4
        %
        if ismember(i1, [2])
            cn = ct(i2);
        else
            cn = 0;
        end
        %
        S_cells_1 = label2idx(im_S_o(:,:,i1,i2));
        idx = find(~cellfun(@isempty, S_cells_1));
        im_S_n = zeros(H,W);
        %
        for c = 1:length(idx)
            ii = im_S_o(:,:,i1, i2) == idx(c);
            im_S_n(ii) = c + cn;
        end
        %
        im_S_o(:,:,i1, i2) = im_S_n;
        ct(i2) = length(idx);
        %
    end
    %
end
%
% write out the im_S_o images
%
for i2 = 1:4
    ii = Tiff([wd,'\superpixel\Component_Tiffs\',...
        im,'_',num2str(i2),'_component_data_seg.tif'],'w');
    ii.setTag(ds)
    d = single(im_S_o(:,:,1, i2));
    write(ii,d);
    %
    for i1 = 2:l_S
        writeDirectory(ii)
        ii.setTag(ds);
        d = single(im_S_o(:,:,i1, i2));
        write(ii,d);
    end
    %
    close(ii)
end
%
% compile the inform out image
%
im_IF_o = zeros(H, W, l_IF, 4);
%
for i1 = 1:l_IF
    im_IF = imread(im_name_IF, i1);
    im_IF_o(H1,W1,i1, 1) = im_IF(H1,W1);
    im_IF_o(H1,W2,i1, 2) = im_IF(H1,W2);
    im_IF_o(H2,W1,i1, 3) = im_IF(H2,W1);
    im_IF_o(H2,W2,i1, 4) = im_IF(H2,W2);
    if i1 > 11
        %
        for i2 = 1:4
            %
            if ismember(i1, [13,15])
                cn = ct(i2);
            else
                cn = 0;
            end
            %
            IF_cells_1 = label2idx(im_IF_o(:,:,i1,i2));
            idx = find(~cellfun(@isempty, IF_cells_1));
            im_IF_n = zeros(H,W);
            %
            for c = 1:length(idx)
                ii = im_IF_o(:,:,i1, i2) == idx(c);
                im_IF_n(ii) = c + cn;
            end
            %
            im_IF_o(:,:,i1, i2) = im_IF_n;
            ct(i2) = length(idx);
            %
        end
    end
end
%
% write out the im_IF_o
%
for i2 = 1:4
    ii = Tiff([wd,'\inform_data\Component_Tiffs\',...
        im,'_',num2str(i2),'_component_data_w_seg.tif'],'w');
    ii.setTag(ds)
    d = single(im_IF_o(:,:,1, i2));
    write(ii,d);
    %
    for i1 = 2:l_IF
        writeDirectory(ii)
        ii.setTag(ds)
        d = single(im_IF_o(:,:,i1, i2));
        write(ii,d);
    end
    %
    close(ii)
end
%
end