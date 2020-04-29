function app = reload_overlap_table(app)
%%
% this function reads in the comparison seg data and label matrix then
% rearranges to the overlap_table
%
%%
ofname = [app.wd,'\inform_data\Component_Tiffs\',app.fname,...
    'comparison_seg_data.csv'];
x = readtable(ofname);
%
oiname = [app.wd,'\inform_data\Component_Tiffs\',app.fname,...
    'comparison_seg_data.tif'];
for i1 = 1:6
    im(:,:,i1) = imread(oiname, i1);
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
    cells_n = x.ML_cellid(ii);
    %
    [~,iY,~] = unique(cells_n, 'last');
    for i1 = 1:length(iY)
        c = find(L == iY(i1));
        ii = x.ML_cellid == cells_n(iY(i1));
        x.ML_cells(ii) = {c};
    end
    %
    ii = x.IF_level == level;
    L = im(:,:,level + 2);
    cells_n = x.IF_cellid(ii);
    %
    [~,iY,~] = unique(cells_n, 'last');
    for i1 = 1:length(iY)
        c = find(L == iY(i1));
        ii = x.IF_cellid == cells_n(iY(i1));
        x.IF_cells(ii) = {c};
    end
    %
    ii = x.IF_level == level & x.include_cell == 3;
    L = im(:,:,level + 4);
    cells_n = x.cellid(ii);
    %
    Y = unique(cells_n);
    for i1 = 1:length(Y)
        c = find(L == Y(i1));
        x.final_cells(ii) = {c};
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
app.overlap_table = x;
%
end