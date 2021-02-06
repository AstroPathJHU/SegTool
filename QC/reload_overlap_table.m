%%
% app.wd = 'Z:\Ben\Code\SegmentationTool\assessment\A';
% app.fname = 'Liver_TMA_145_23_01.30.2020_[6435,55763]_comparison_seg_data'
%%
function [app] = reload_overlap_table(app)
%
% read the old table
%
ofname = [app.wd,'\inform_data\Component_Tiffs\',app.fname,...
    '_comparison_seg_data.csv'];
x = readtable(ofname);
%
% convert old table format to new
%
if width(x) == 14
    x.ground_level = ones(height(x),1);
end
%
ii = x.pairid == 0;
x(ii, :) = [];
%
% get SP cell objects
%
app.cells_n = label2idx(app.im_SP)';
m1 = regionprops(app.im_SP(:,:,1),'centroid');
app.tmp_mid = struct2cell(m1);
app = crt_int_tbl(app, 'SP');
app.SP_table = app.SP_table(:,{'SP_cellid','SP_cells'});
x = outerjoin(x, app.SP_table,...
    'Type','left','Keys',{'SP_cellid'},'MergeKeys',1);
%
% get IF cell objects
%
app = getIFdistinct(app);
app = crt_int_tbl(app, 'IF');
app.IF_table = app.IF_table(:,{'IF_cellid','IF_cells'});
x = outerjoin(x, app.IF_table,...
    'Type','left','Keys',{'IF_cellid'},'MergeKeys',1);
x = sortrows(x,'pairid','ascend');
%
% remove edge cells from the displays
%
app.q = x;
rm_edge_cells(app, 2)
%
% add cell counter
%
x.counter = zeros(height(x),1);
ii = x.cell_check > 0;
x.counter(ii) = (1:length(find(ii)))';
%
app.overlap_table = x;
%
app = read_comp_im(app);
%
end