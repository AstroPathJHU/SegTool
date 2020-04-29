wd = '\\halo1\TaubeLab\Ben\Code\SegmentationTool\assessment';
%
n = {'A','S','G'};
limit = 400;
image = 'Liver_TMA_145_23_01.30.2020_[6435,55763]_comparison_seg_data';
c = get_comp(image);
%
overlap_table = {};
%
for i1 = 1:length(n)
    n1 = n{i1};
    fd = [wd,'\',n1,'\',image];
    %
    im = [];
    for i2 = 1:6
        im(:,:,i2) = imread([fd,'.tif'], i2);
    end
    %
    x = readtable([fd,'.csv']);
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
        for i2 = 1:length(iY)
            c = find(L == iY(i2));
            ii = x.ML_cellid == cells_n(iY(i2));
            x.ML_cells(ii) = {c};
        end
        %
        ii = x.IF_level == level;
        L = im(:,:,level + 2);
        cells_n = x.IF_cellid(ii);
        %
        [~,iY,~] = unique(cells_n, 'last');
        for i2 = 1:length(iY)
            c = find(L == iY(i2));
            ii = x.IF_cellid == cells_n(iY(i2));
            x.IF_cells(ii) = {c};
        end
        %
        ii = x.IF_level == level & x.include_cell == 3;
        L = im(:,:,level + 4);
        cells_n = x.cellid(ii);
        %
        Y = unique(cells_n);
        for i2 = 1:length(Y)
            c = find(L == i2);
            x.final_cells(Y(i2)) = {c};
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
    overlap_table{i1} = x;
    %
end
%
B = [];
ML = [];
IF =[];
Draw =[];
reject = [];
%
for i1 = 1:length(n)
    x = overlap_table{i1};
    ii = x.cellid <= limit;
    x = x(ii,:);
    %
    ii = x.include_cell == 4;
    B(:,i1) = ii;
    x2 = x;
    x2(ii,:) = [];
    %
    app.nRows = 1404;
    app.nCols = 1872;
    L(:,:,i1) = createLabelmatrix(app, x2.final_cells);
    LL(:,i1) = cellfun(@(y) length(y), x2.final_cells);
    %
    ii = x.include_cell == 2;
    ML(:,i1) = ii;
    ii = x.include_cell == 1;
    IF(:,i1) = ii;
    ii = x.include_cell == 3;
    Draw(:,i1) = ii;
    ii = x.include_cell == -1;
    reject(:,i1) = ii;
    %
end
%
sB = sum(B,2);
ii = sB ~= 3 & sB ~= 0;
sB2 = sum(ii);
sB3 = sum(B, 1);
%
sML = sum(ML,2);
ii = sML ~= 3 & sML ~= 0;
sML2 = sum(ii);
sML3 = sum(ML, 1);
%
sIF = sum(IF,2);
ii = sIF ~= 3 & sIF ~= 0;
sIF2 = sum(ii);
sIF3 = sum(IF, 1);
%
sDraw = sum(Draw,2);
ii = sDraw ~= 3 & sDraw ~= 0;
sDraw2 = sum(ii);
sDraw3 = sum(Draw, 1);
%
sreject = sum(reject,2);
ii = sreject ~= 3 & sreject ~= 0;
sreject2 = sum(ii);
sreject3 = sum(reject, 1);
%
res = table();
res.names = n';
res.Overlapped_cells = sB3';
res.ML_cells = sML3';
res.IF_cells = sIF3';
res.Drawn_cells = sDraw3';
res.reject_cells = sreject3';
%
L1 = L(:,:,1);
L2 = L(:,:,2);
L3 = L(:,:,3);
%
overlap = L1 > 0 & L2 > 0 & L3;
pairs = [L1(overlap), L2(overlap), L3(overlap)];
[ii, ~, kk] = unique(pairs, 'rows');
pairs_cnt = [ii,accumarray(kk,1)];
%
idx1 = pairs_cnt(:,1);
idx2 = pairs_cnt(:,2);
idx3 = pairs_cnt(:,3);
% 
LL2(:,1) = pairs_cnt(:,4) ./ LL(idx1, 1);
LL2(:,2) = pairs_cnt(:,4) ./ LL(idx2, 2);
LL2(:,3) = pairs_cnt(:,4) ./ LL(idx3, 3);
%
LL3 = LL2(:,1) .* LL2(:,2) .* LL2(:,3);
ii = LL3 < .8 & LL3 > .1;
LL5 = find(ii);
LL4(:,1) = LL5;
LL4(:,2)= LL3(ii);
LL4 = sortrows(LL4, 2);
