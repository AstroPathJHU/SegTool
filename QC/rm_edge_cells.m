function rm_edge_cells(app, opt)
%%
% this function removes the cells that touch the edges of the
% images from the training set
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
% find where either the machine learning or the inform
% algorithm defines cells with any pixels touching the edge of
% the image
%
if opt == 1
    SP_edges_p = cellfun(@(y) sum(ismember(y, ii)), x.SP_cells);
    IF_edges_p = cellfun(@(y) sum(ismember(y, ii)), x.IF_cells);
    edges_p = SP_edges_p + IF_edges_p;
    %
    % remove those rows from the table
    %
    idx = edges_p > 0;
    x(idx,:) = [];
    app.q = x;
    %
else
    %
    im = app.im_SP(:,:,1);
    SP_cells_1 = label2idx(im);
    SP_edges_p = cellfun(...
        @(y) sum(ismember(y, ii)), SP_cells_1);
    %
    im = app.im_IF(:,:,2);
    IF_cells_1 = label2idx(im);
    IF_edges_p_1 = cellfun(...
        @(y) sum(ismember(y, ii)), IF_cells_1);
    %
    im = app.im_IF(:,:,3);
    IF_cells_2 = label2idx(im);
    IF_edges_p_2 = cellfun(...
        @(y) sum(ismember(y, ii)), IF_cells_2);
    %
    idx = find(ismember(app.im_SP(:,:,1), find(SP_edges_p)) | ...
        ismember(app.im_IF(:,:,2), find(IF_edges_p_1)) | ...
        ismember(app.im_IF(:,:,3), find(IF_edges_p_2)));
    %
    % remove those pixels from the im_mem_dapi and segmentation
    % images
    %
    app.mem_dapi_im(idx) = 0;
    app.im_SP(idx) = 0;
    app.im_IF(idx + 2 * app.nCols * app.nRows) = 0;
    app.im_IF(idx + 3 * app.nCols * app.nRows) = 0;
    %
end
%
end
%