function app = compute_pairs()
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
app.cells_n = label2idx(app.im_ML)';
m = regionprops(app.im_ML,'centroid');
app.m = struct2cell(m(:))';
app = crt_int_tbl(app, 'ML');
%
% get distinct objects in inform
%
app = getIFdistinct(app);
%
% create the IF table
%
app = crt_int_tbl(app, 'IF');
%
% get the cells which pixels overlap with ML
%
app = comp_overlap(app);
%
app.q.jp = app.q.IF_pct .* app.q.ML_pct;
%
app = add_no(app);
x = app.q;
x.include_cell = zeros(height(x),1);
c = zeros(height(x),1);
c = num2cell(c);
x.final_cells = c;
x.final_cell_x = c;
x.final_cell_y = c;
%
app.overlap_table = x;
%
writetable(x, [app.wd,'\',app.fname,'_overlap_table.xlsx'])
%
end
%%
