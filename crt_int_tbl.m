function app = crt_int_tbl(app, tt)
%%
% intialize the table for the overlap computation
%
%%
cells_n = app.cells_n;
m = app.m;
%
tbl = table();
tbl.([tt,'_cellid']) = (1:length(cells_n))';
tbl.([tt,'_cells']) = cells_n;
tbl.([tt,'_centriods']) = m;
[x,y] = cellfun(@(x)ind2sub([app.nRows,app.nCols],x),cells_n,'Uni',0);
tbl.([tt,'_x']) = x;
tbl.([tt,'_y']) = y;
tbl.([tt,'_n_pixels']) = cellfun('length',cells_n);
%
if strcmp(tt, 'ML')
    app.ML_table = tbl;
elseif strcmp(tt,'IF')
    app.IF_table = tbl;
end
%%
end