function showallcells(app, pct)
x = app.overlap_table;
ii = x.jp > pct;
%
ol_IF.PixelIdxList = x.IF_cells(ii);
ol_IF.Connectivity = 8;
ol_IF.ImageSize = [app.nRows app.nCols];
ol_IF.NumObjects = sum(ii);
L_IF = labelmatrix(ol_IF); 
%
ol_ML.PixelIdxList = x.ML_cells(ii);
ol_ML.Connectivity = 8;
ol_ML.ImageSize = [app.nRows app.nCols];
ol_ML.NumObjects = sum(ii);
L_ML = labelmatrix(ol_ML);
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
ii = reshape((L_ML > 0), [],1);
im2(:,2) = .4 * 255 * double(ii);
%
im = im + im2;
%
im = reshape(im,app.nRows,app.nCols,3);


imshow(uint8(im))

end
