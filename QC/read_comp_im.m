function app = read_comp_im(app)
%%
% this function reads in the image with the drawn cells to memory
%%
oiname = [app.wd,'\inform_data\Component_Tiffs\',app.fname,...
    '_comparison_seg_data.tif'];
%
% read in drawn cells
%
image_info = imfinfo(oiname);
app.nRows = image_info(1).Height;
app.nCols = image_info(1).Width;
%
switch length(image_info)
    case 6
        %
        % convert old version to new version
        %
        app.draw_im = zeros(app.nRows, app.nCols);
        x = app.overlap_table;
        for level = 1:2
            ii = x.IF_level == level & x.class_selection == 3;
            L = imread(oiname,level + 4);
            cells_n1 = x.pairid(ii);
            c = reshape(L,1,[]);
            ii = c > 0;
            app.draw_im(ii) = cells_n1(c(ii));
            %
        end
        %
    case 2
        %
        app.draw_im = imread(oiname, 1);
        %
    case 1
        %
        app.draw_im = imread(oiname, 1);
        %
end
%
% get the cell objects from the drawn image
%
d_cells_n1 = label2idx(app.draw_im);
rp = regionprops(app.draw_im,'Centroid');
rp = struct2cell(rp);
rp = cell2mat(rp);
%
% get the logical index in the table and the pairid of the cell
% of interest (pairid is the value in the label matrix)
%
ii = app.overlap_table.class_selection == 3;
idx = app.overlap_table.pairid(ii);
%
ii1 = idx > length(d_cells_n1);
if any(ii1)
    ii2 = ismember(app.overlap_table.pairid,idx(ii1));
    app.overlap_table.class_selection(ii2) = -1;
    ii = app.overlap_table.class_selection == 3;
    idx = app.overlap_table.pairid(ii);
end
%
% pre-allocate final object variables
%
app.paired_cells = cell(height(app.overlap_table), 1);
app.x_centroids = zeros(height(app.overlap_table), 1);
app.y_centroids = zeros(height(app.overlap_table), 1);
%
% insert the proper values from the drawn cells into the final
% object variables
%
cells_n1 = d_cells_n1(idx);
app.paired_cells(ii) = cells_n1;
tmp = rp(1:2:end)';
app.x_centroids(ii) = tmp(idx);
tmp = rp(2:2:end)';
app.y_centroids(ii) = tmp(idx);
%
% get IF objects into the final objects variables
%
ii = app.overlap_table.class_selection == 1;
cells_n1 = app.overlap_table.IF_cells(ii);
app.paired_cells(ii) = cells_n1;
app.x_centroids(ii) = app.overlap_table.IF_X_centroid(ii);
app.y_centroids(ii) = app.overlap_table.IF_Y_centroid(ii);
%
% get the SP objects for the rest in the final object variables
%
ii = (app.overlap_table.class_selection == 2 |...
    app.overlap_table.class_selection == 4 | ...
    app.overlap_table.class_selection == 5);
cells_n1 = app.overlap_table.SP_cells(ii);
app.paired_cells(ii) = cells_n1;
app.x_centroids(ii) = app.overlap_table.SP_X_centroid(ii);
app.y_centroids(ii) = app.overlap_table.SP_Y_centroid(ii);
%
end
