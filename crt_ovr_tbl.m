function tbl = crt_ovr_tbl(app, cells_n)
%%
% intialize the table for the overlap computation
%
%%
tbl = table();
tbl.cellid = (1:length(cells_n))';
tbl.cells = cells_n;
[x,y] = cellfun(@(x)ind2sub([app.nRows,app.nCols],x),cells_n,'Uni',0);
tbl.x = x;
tbl.y = y;
tbl.n_pixels = cellfun('length',cells_n);
%
tbl.overlap_L1 = zeros(height(tbl),1);
tbl.overlap_L2 = zeros(height(tbl),1);
%
tbl.pct_L1 = zeros(height(tbl),1);
tbl.pct_L2 = zeros(height(tbl),1);
%
tbl.pair_L1 = zeros(height(tbl),1);
tbl.pair_L2 = zeros(height(tbl),1);
%
end