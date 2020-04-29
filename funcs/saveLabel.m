function saveLabel(app)
%%
% create and save the 6 layer label matrix from the overlap_table
% Order is as follows
% ML immune
% ML tumor
% IF immune
% IF tumor
% final immune
% final tumor
%
%%
%
for level = 1:2
    %
    ii = app.q.IF_level == level;
    cells_n1 = app.overlap_table.ML_cells(ii);
    im(:, :, level) = createLabelmatrix(app, cells_n1);
    %
    cells_n1 = app.overlap_table.IF_cells(ii);
    im(:,:,level + 2) = createLabelmatrix(app, cells_n1);
    %
    ii = app.q.IF_level == level & app.overlap_table.include_cell == 3;
    cells_n1 = app.overlap_table.final_cells(ii);
    im(:,:,level + 4) = createLabelmatrix(app, cells_n1);
    %
end
%
% set image output properties
%
ds.Photometric = Tiff.Photometric.MinIsBlack;
ds.BitsPerSample   = 16;
ds.SamplesPerPixel = 1;
ds.SampleFormat = Tiff.SampleFormat.UInt;
ds.RowsPerStrip = 41;
ds.MaxSampleValue = 256;
ds.MinSampleValue = 0;
ds.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
ds.Software = 'MATLAB';
ds.ResolutionUnit = Tiff.ResolutionUnit.Inch;
ds.XResolution = 300;
ds.YResolution = 300;
ds.Compression = Tiff.Compression.LZW;
ds.ImageLength = app.nRows;
ds.ImageWidth = app.nCols;
%
oiname = [app.wd,'\inform_data\Component_Tiffs\',app.fname,...
    'comparison_seg_data.tif'];
%
% write image
%
ii = Tiff(oiname,'w');
%
ii.setTag(ds)
d = uint16(im(:,:,1));
write(ii,d);
%
for i3 = 2:(size(im, 3))
    writeDirectory(ii)
    d = uint16(im(:,:,i3));
    ii.setTag(ds);
    write(ii,d);
end
%
close(ii)
%
end
