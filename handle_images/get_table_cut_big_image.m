function [draw_im, overlap_table] = get_table_cut_big_image(wd, im)
%
% image names and info
%
im_name_csv = [wd,'\inform_data\Component_Tiffs\',...
    im,'_comparison_seg_data.csv'];
im_name_tif = [wd,'\inform_data\Component_Tiffs\',...
    im,'_comparison_seg_data.tif'];
%
draw_im = imread(im_name_tif, 1);
%
overlap_table = readtable(im_name_csv);
%
end