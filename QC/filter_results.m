%%
% wd = 'Z:\Ben\Code\SegmentationTool\assessment';
% imname = 'Liver_TMA_145_23_01.30.2020_[6435,55763]_comparison_seg_data'
% P = {'S','H','G','A'};
% t
%%
function [out] = filter_results(app)
%
% total IF cells
%
out = [];
e = 0;
ii = unique(app.overlap_table.IF_cellid);
ii = ii ~= 0;
out(1,2) = sum(ii);
%
% total IF cells with duplicates
%
ii1 = ~cellfun(@isempty, app.overlap_table.IF_cells);
%out(1,2) = sum(ii1);
%
% row indicies of duplicates
%
x = app.overlap_table;
x = x(x.IF_cellid > 0,:);
[B,ia,ib]=unique(x.IF_cellid,'rows','stable');
ind = find(hist(ib,unique(ib))>1);
%
for i1 = 1:length(ind)
   rows = find(x.IF_cellid ==...
       B(ind(i1)));
   ii1 = all(x.class_selection(rows(1))== ...
       x.class_selection(rows));
   if ~ii1
       disp('warning IF cell dups not the same')
       x.class_selection(rows) = x.class_selection(rows(end));
   end
end
%
if e == 1
    return
end
%
% selected IF cells without duplicates
%
out(1,1) = sum(app.overlap_table.class_selection(ii) == 1);
%
% total SP cells
%
e = 0;
ii = unique(app.overlap_table.SP_cellid);
ii = ii ~= 0;
out(1,4) = sum(ii);
%
% total IF cells with duplicates
%
ii1 = ~cellfun(@isempty, app.overlap_table.SP_cells);
%out(1,5) = sum(ii1);
%
% row indicies of duplicates
%
x = app.overlap_table;
x = x(x.SP_cellid > 0,:);
[B,ia,ib]=unique(x.SP_cellid,'rows','stable');
ind = find(hist(ib,unique(ib))>1);
%
for i1 = 1:length(ind)
   rows = find(x.SP_cellid ==...
       B(ind(i1)));
   ii1 = all(x.class_selection(rows(1))== ...
       x.class_selection(rows));
   if ~ii1
       disp('warning SP cell dups not the same')
       x.class_selection(rows) = x.class_selection(rows(end));
   end
end
%
if e == 1
    return
end
%
% selected SP cells without duplicates
%
out(1,3) = sum(app.overlap_table.class_selection(ii) == 2);
%
% get total number of pairs checked
%
ii = (~cellfun(@isempty, app.overlap_table.SP_cells)...
    & ~cellfun(@isempty, app.overlap_table.IF_cells)) &...
    app.overlap_table.cell_check > 0; 
out(1,10) = sum(ii);
%
% get total number of pairs
%
ii = ~cellfun(@isempty, app.overlap_table.SP_cells)...
    & ~cellfun(@isempty, app.overlap_table.IF_cells);
out(1,11) = sum(ii);
%
% get total pairs indicated as IF
%
out(1,5) = sum(app.overlap_table.class_selection(ii) == 1);
%
% get total pairs indicated as SP
%
out(1,6) = sum(app.overlap_table.class_selection(ii) == 2);
%
% get total pairs indicated as both
%
out(1,7) = sum(app.overlap_table.class_selection(ii) == 5);
%
% get total pairs indicated as neither
%
out(1,8) = sum(app.overlap_table.class_selection(ii) == -1) ...
    + sum(app.overlap_table.class_selection(ii) == 3)...
    + sum(app.overlap_table.class_selection(ii) == -3);
%
% get total pairs indicated as artifact 
%
out(1,9) = sum(app.overlap_table.class_selection(ii) == -2);
%
% get unique IF cells in pairs 
%
out(1,12) = sum(unique(app.overlap_table.IF_cellid(ii)) ~=0 );
%
% get unique SP cells in pairs 
%
out(1,13) = sum(unique(app.overlap_table.SP_cellid(ii)) ~=0 );
%
% get total nonpairs idicated as positive for IF
%
ii = cellfun(@isempty, app.overlap_table.SP_cells)...
    & ~cellfun(@isempty, app.overlap_table.IF_cells);
out(1,14) = sum(app.overlap_table.class_selection(ii) == 1);
%
% get total IF non-paired cells
%
out(1,15) = sum(ii);
%
% get total nonpairs idicated as positive for SP
%
ii = ~cellfun(@isempty, app.overlap_table.SP_cells)...
    & cellfun(@isempty, app.overlap_table.IF_cells);
out(1,16) = sum(app.overlap_table.class_selection(ii) == 2);
%
% get total SP non-paired cells
%
out(1,17) = sum(ii);
%
% drawn cells
%
out(1,18) = sum(app.overlap_table.class_selection == 3);
%
% added cells
%
ii = cellfun(@isempty, app.overlap_table.SP_cells)...
    & cellfun(@isempty, app.overlap_table.IF_cells);
out(1,19) = sum(app.overlap_table.class_selection(ii) == 3);
%
end