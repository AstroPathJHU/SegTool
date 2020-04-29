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
% ML cell table, first define objects and find centroids
%
app.cells_n = label2idx(app.im_ML)';
im = app.im_ML(:,:,1);
m1 = regionprops(im,'centroid');
app.m = struct2cell(m1);
%
% add to a table
%
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
app.q.jp = app.q.IF_pct .* app.q.ML_pct;
%
% add non overlapping cells
%
app = add_no(app);
%
% remove edge cells, get linear indicies of all boarder pixels
%
app = rm_edge_cells(app);
%
% intialize the final results columns and for 80% or above overlap save 
% ML algorithm segmentation
app = int_results_cols(app);
%
% saves results
%
x = app.q;
app.overlap_table = x;
save([app.wd,'\inform_data\Component_Tiffs\',app.fname,'_overlap_table'],'x')
%
end
%%
