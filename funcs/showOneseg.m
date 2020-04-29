function showOneseg(app, opts)
%%
% this function is designed to veiw the segmentation results at different
% parts of the code processing to check that no image or cell data is
% corrupted during the processing
%
% opts == 1: machine learning image, no processing
% opts == 2: inform image immune cells, no processing
% opts == 3: inform image tumor cells, no processing
% opts == 4: machine learning cells after defining objects
% opts == 5: inform cells after defining objects
% opts == 6: machine learning image, after computing overlaps, immune cells
% opts == 7; inform image, after computing overlaps, immune cells
% opts == 8: machine learning image, after computing overlaps, tumor cells
% opts == 9; inform image, after computing overlaps, tumor cells
%%
%
figure();
%
if opts == 4
    cells = app.ML_table.ML_cells;
elseif opts == 5
    cells = app.IF_table.IF_cells;
elseif opts == 1
    imshow(255 * uint8(app.im_ML))
    return
elseif opts == 2
    imshow(255 * uint8(app.im_IF(:,:,2)))
    return
elseif opts == 3
    imshow(255 * uint8(app.im_IF(:,:,3)))
    return
elseif opts == 6
    ii = app.overlap_table.IF_level == 1;
    cells = app.overlap_table.ML_cells(ii);
elseif opts == 7
    ii = app.overlap_table.IF_level == 1;
    cells = app.overlap_table.IF_cells(ii);
elseif opts == 8
    ii = app.overlap_table.IF_level == 2;
    cells = app.overlap_table.ML_cells(ii);
elseif opts == 9
    ii = app.overlap_table.IF_level == 2;
    cells = app.overlap_table.IF_cells(ii);
end
%
ol_IF.PixelIdxList = cells;
ol_IF.Connectivity = 8;
ol_IF.ImageSize = [app.nRows app.nCols];
ol_IF.NumObjects = length(cells);
L_IF = labelmatrix(ol_IF); 
%
col = [1 1 1;
        0 0 1];
im = app.mem_dapi_im;
%
im = (225 .* asinh(2 .* im)) * col;
%
im2 = zeros(app.nRows * app.nCols,3);
ii = reshape((L_IF > 0), [],1);
im2(:,1) = .4 * 255 * double(ii);
%
im = im + im2;
im = reshape(im,app.nRows,app.nCols,3);
%
imshow(uint8(im))
end