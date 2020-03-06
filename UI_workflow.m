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
app.ML_table = crt_ovr_tbl(app, ML_cells');
%
% get distinct objects in inform
%
IF_cells = getIFdist(app);
%
% create the IF table
%
app.IF_table = crt_ovr_tbl(app, IF_cells);
%
% get the cells which pixels overlap with ML
%
for level = 1:2
    im1 = app.im_IF(:,:,level);
    app = comp_overlap(app,im1,level);
end
%
ii1 = app.IF_table.pct_L1 > .8 | app.IF_table.pct_L2 > .8;
ol_IF_t = app.IF_table(ii1,:);
%
ol_IF.PixelIdxList = app.IF_table.cells(ii1);
ol_IF.Connectivity = 8;
ol_IF.ImageSize = [nRows nCols];
ol_IF.NumObjects = sum(ii1);
L_IF = labelmatrix(ol_IF);
%
x1 = app.IF_table.x(ii1);
y1 = app.IF_table.y(ii1); 
%
ii2 = app.ML_table.pct_L1 > .8 | app.ML_table.pct_L2 > .8;
ol_ML_t = app.ML_table(ii2,:);
%
ol_ML.PixelIdxList = app.ML_table.cells(ii2);
ol_ML.Connectivity = 8;
ol_ML.ImageSize = [nRows nCols];
ol_ML.NumObjects = sum(ii2);
L_ML = labelmatrix(ol_ML);
%
im = zeros(nRows,nCols,3);
im(:,:,1) = L_IF;
im(:,:,2) = L_ML;
imshow(uint8(im(:,:,:) > 0)*255)

%
ii3 = ismember(ol_IF_t.pair_L1, ol_ML_t.cellid) |...
        ismember(ol_IF_t.pair_L2, ol_ML_t.cellid);
ii4 = ismember(ol_ML_t.pair_L1, ol_IF_t.cellid) |...
        ismember(ol_ML_t.pair_L2, ol_IF_t.cellid);
%
ol_IF.PixelIdxList = ol_IF_t.cells(ii3);
ol_IF.Connectivity = 8;
ol_IF.ImageSize = [nRows nCols];
ol_IF.NumObjects = sum(ii3);
L_IF = labelmatrix(ol_IF);
%
ol_ML.PixelIdxList = ol_ML_t.cells(ii4);
ol_ML.Connectivity = 8;
ol_ML.ImageSize = [nRows nCols];
ol_ML.NumObjects = sum(ii4);
L_ML = labelmatrix(ol_ML);
%
im = zeros(nRows,nCols,3);
im(:,:,1) = L_IF;
im(:,:,2) = L_ML;
imshow(uint8(im(:,:,:) > 0)*255)
%
end