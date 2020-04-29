%%
% wd = 'Z:\Ben\Code\SegmentationTool\assessment\A';
% imname = 'Liver_TMA_145_23_01.30.2020_[6435,55763]_comparison_seg_data'
%%
function [x, im] = reload_overlap_table(wd, imname)
%
x = readtable([wd,'\',imname,'.csv']);
%
im = [];
for i1 = 1:6
    im(:,:,i1) = imread([wd,'\',imname,'.tif'], i1);
end
%
x.ML_cells = repmat({0},height(x),1);
x.IF_cells = repmat({0},height(x),1);
x.final_cells = repmat({0},height(x),1);
%
for level = 1:2
    %
    ii = x.IF_level == level;
    L = im(:,:,level);
    cells_n1 = x.ML_cellid(ii);
    %
    [~,iY,~] = unique(cells_n1, 'last');
    for i1 = 1:length(iY)
        c = find(L == iY(i1));
        ii = x.ML_cellid == cells_n1(iY(i1));
        x.ML_cells(ii) = {c};
    end
    %
    ii = x.IF_level == level;
    L = im(:,:,level + 2);
    cells_n1 = x.IF_cellid(ii);
    %
    [~,iY,~] = unique(cells_n1, 'last');
    for i1 = 1:length(iY)
        c = find(L == iY(i1));
        ii = x.IF_cellid == cells_n1(iY(i1));
        x.IF_cells(ii) = {c};
    end
    %
    ii = x.IF_level == level & x.include_cell == 3;
    L = im(:,:,level + 4);
    cells_n1 = x.cellid(ii);
    %
    Y = unique(cells_n1);
    for i1 = 1:length(Y)
        c = find(L == i1);
        x.final_cells(Y(i1)) = {c};
    end
    %
end
%
ii = x.include_cell == 2 | x.include_cell == 4;
x.final_cells(ii) = x.ML_cells(ii);
%
ii = x.include_cell == 1;
x.final_cells(ii) = x.IF_cells(ii);
%
end