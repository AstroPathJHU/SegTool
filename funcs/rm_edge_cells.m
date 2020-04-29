function app = rm_edge_cells(app)
%%
%
% this function removes the cells that touch the edges of the images from
% the training set
%
%%
x = app.q;
%
% build an empty image and get the border pixels
%
im_e = zeros(app.nRows, app.nCols);
im_e(1,1:app.nCols) = ones(1, app.nCols);
im_e(app.nRows,1:app.nCols) = ones(1, app.nCols);
im_e(1:app.nRows, 1) = ones(1, app.nRows);
im_e(1:app.nRows, app.nCols) = ones(1, app.nRows);
ii = find(im_e);
%
% find where either the machine learning or the inform algorithm defines
% cells with any pixels touching the edge of the image
%
ML_edges_p = cellfun(@(y) sum(ismember(y, ii)), x.ML_cells);
IF_edges_p = cellfun(@(y) sum(ismember(y, ii)), x.IF_cells);
edges_p = ML_edges_p + IF_edges_p;
%
% remove those rows from the table
%
idx = find(edges_p);
x(idx,:) = [];
app.q = x;
%
end