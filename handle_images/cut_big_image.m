%% cut_big_image
% cut the big images into 4 parts to aid in work reduction
%% Usage
% wd = working directory with inform and superpixel sub images
% im = image name
%% example
% wd = '\\halo1\TaubeLab\Ben\Code\SegmentationTool\training_images\SegmentationImages'
% im = 'Melanoma_TMA_1287_40_01.30.2020_[5856,47509]'
%%
function [] = cut_big_image(wd, im, cut_table)
%
if cut_table
    [draw_im, overlap_table] = get_table_cut_big_image(wd, im);
end
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
l_IF = size(image_info, 1);
l_S = size(imfinfo(im_name_S), 1);
%
% compute the fourths
%
HT4 = H / 2;
WT4 = W / 2;
%
ds.ImageLength = HT4 + 10;
ds.ImageWidth = WT4 + 10;
%
H1 = 1:(HT4+10);
H2 = (HT4-9):H;
W1 = 1:(WT4+10);
W2 = (WT4-9):W;
Ws = [W1; W2; W1; W2];
Hs = [H1; H1; H2; H2];
%
% compile the superpixel out image
%
im_S_o = zeros(H, W, l_S, 4);
%
SP_tables = cell(4, l_S);
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
        SP_tables{i2, i1} = table();
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
            %
            ii = im_S_o(:,:,i1, i2) == idx(c);
            im_S_n(ii) = c + cn;
            %
            ii = overlap_table.SP_cellid == idx(c);
            row = overlap_table(ii, :);
            if ~isempty(row)
                row.SP_cellid = repmat(c + cn, height(row), 1);
                SP_tables{i2, i1} = [SP_tables{i2, i1}; row];
            end
            %
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
    d = single(im_S_o(Hs(i2, :),Ws(i2, :),1, i2));
    write(ii,d);
    %
    for i1 = 2:l_S
        writeDirectory(ii)
        ii.setTag(ds);
        d = single(im_S_o(Hs(i2, :),Ws(i2, :),i1, i2));
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
IF_tables = cell(4,l_IF);
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
            IF_tables{i2, i1} = table();
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
                %
                ii = overlap_table.IF_cellid == idx(c);
                row = overlap_table(ii, :);
                if ~isempty(row) && i1 > 13
                    row.IF_cellid = repmat(c + cn, height(row), 1);
                    IF_tables{i2, i1} = [IF_tables{i2, i1}; row];
                end
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
    d = single(im_IF_o(Hs(i2,:),Ws(i2,:),1, i2));
    write(ii,d);
    %
    for i1 = 2:l_IF
        writeDirectory(ii)
        ii.setTag(ds)
        d = single(im_IF_o(Hs(i2,:),Ws(i2,:),i1, i2));
        write(ii,d);
    end
    %
    close(ii)
end
%
% compile the inform out image
%
im_draw_o = zeros(H, W, 4);
%
im_draw_o(H1, W1, 1) = draw_im(H1,W1);
im_draw_o(H1, W2, 2) = draw_im(H1,W2);
im_draw_o(H2, W1, 3) = draw_im(H2,W1);
im_draw_o(H2, W2, 4) = draw_im(H2,W2);
%
for i2 = 1:4
    %
    t1 = [IF_tables{i2, 14}; IF_tables{i2, 15}];
    t2 = SP_tables{i2, 1};
    %
    ii = ismember(overlap_table.pairid, t1.pairid);
    ii2 = ismember(overlap_table.pairid, t2.pairid);
    %ii3 = ismember(overlap_table.pairid, im_draw_o(:,:,i2));
    %
    cells_in_region = ii | ii2;
    overlap_table_region = overlap_table(cells_in_region, :);
    %
    for i1 = 1:height(overlap_table_region)
        %
        ii = t1.pairid == overlap_table_region.pairid(i1);
        if any(ii)
            overlap_table_region.IF_cellid(i1) = t1.IF_cellid(ii);
        end
        %
        ii = t2.pairid == overlap_table_region.pairid(i1);
        if any(ii)
            overlap_table_region.SP_cellid(i1) = t2.SP_cellid(ii);
        end
        %
    end
    %
    overlap_table_region.pairid = [1:height(overlap_table_region)]';
    %
    cn = max(overlap_table_region.pairid); % count start
    %
    draw_cells_1 = label2idx(im_draw_o(:,:,i2));
    idx = find(~cellfun(@isempty, draw_cells_1));
    im_draw_n = zeros(H,W);
    %
    for c = 1:length(idx)
        % set the pixels in the image to my new cell id
        ii = im_draw_o(:,:, i2) == idx(c);
        im_draw_n(ii) = c + cn;
        %
        % get the row from the table
        ii = overlap_table.pairid == idx(c);
        row = overlap_table(ii, :);
        if ~isempty(row) && i1 > 13
            row.pairid = repmat(c + cn, height(row), 1);
            overlap_table_region = [overlap_table_region; row];
        end
    end
    %
    image_name = [wd,'\inform_data\Component_Tiffs\',...
        im,'_',num2str(i2),'_comparison_seg_data.tif'];
    ii = Tiff(image_name,'w');
    ii.setTag(ds)
    d = single(im_draw_n(Hs(i2,:),Ws(i2,:)));
    write(ii, d);
    close(ii)
    %
    writetable(overlap_table_region, replace(image_name, '.tif', '.csv'))
    %
end
%
end