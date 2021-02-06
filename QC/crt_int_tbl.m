function app = crt_int_tbl(app, tt)
%%
% intialize the table for the overlap computation
%%
cells_n1 = app.cells_n;
m1 = app.tmp_mid;
m1 = cell2mat(m1);
m_o = m1(1:2:end);
m_e = m1(2:2:end);
%
tbl = table();
tbl.([tt,'_cellid']) = (1:length(cells_n1))';
tbl.([tt,'_cells']) = cells_n1;
tbl.([tt,'_X_centroid']) = m_o';
tbl.([tt,'_Y_centroid']) = m_e';
tbl.([tt,'_n_pixels']) = cellfun('length',cells_n1);
%
if strcmp(tt, 'SP')
    app.SP_table = tbl;
elseif strcmp(tt,'IF')
    app.IF_table = tbl;
end
%
end
%