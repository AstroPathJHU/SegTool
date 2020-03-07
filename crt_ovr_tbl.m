function tbl = crt_ovr_tbl(app,idx,pairs,cnt,tt)
%%
% define the table with the overlaps in it
%
%%
if strcmp(tt, 'ML')
    tbl_in = app.ML_table;
elseif strcmp(tt, 'IF')
    tbl_in = app.IF_table;
end
%
tbl = tbl_in(idx,:);
tbl.([tt,'_overlap']) =  cnt;
tbl.([tt,'_pct']) = double(tbl.([tt,'_overlap']))...
    ./ tbl.([tt,'_n_pixels']);
tbl.([tt,'_paired_w']) = pairs;
tbl.cellid = (1:height(tbl))';
%
if strcmp(tt, 'ML')
    app.o_tbl_ML = tbl;
elseif strcmp(tt, 'IF')
    app.o_tbl_IF = tbl;
end
%
end