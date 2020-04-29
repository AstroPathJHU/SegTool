function compute_pairs()
%%
%
% this is where the tables are computed for cells and cell overlap pct is
% assigned
%
%%
%
% what the UI will deliver in app
%
[app] = readimages();
%
% ML cell table
%
ML_cells = label2idx(app.im_ML);
app.ML_table = crt_int_tbl(app, ML_cells','ML');
%
% get distinct objects in inform
%
IF_cells = getIFdistinct(app);
%
% create the IF table
%
app.IF_table = crt_int_tbl(app, IF_cells, 'IF');
%
% get the cells which pixels overlap with ML
%
q = comp_overlap(app);
%
q.jp = q.IF_pct .* q.ML_pct;
jp = mean(tbl.jp);
%
[x] = add_no(app,q);
%
app.overlap_table = x;
%
end
%%
