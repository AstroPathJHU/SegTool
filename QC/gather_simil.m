%%
% wd = 'Z:\Ben\Code\SegmentationTool\assessment';
% P = {'A','G','H','S'};
% imname = 'Liver_TMA_145_23_01.30.2020_[6435,55763]_comparison_seg_data'
%%
function [t, app] = gather_simil(wd, P, imname,N)
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
%
nms = {'cellid','include_cell','final_cells'};
t = table();
for i1 = 1:length(P)
    [x, im] = reload_overlap_table([wd,'\',P{i1}], imname);
    %
    s = size(im);
    app.nRows = s(1);
    app.nCols = s(2);
    ds.ImageLength = app.nRows;
    ds.ImageWidth = app.nCols;
    L(:,:,i1) = createLabelmatrix(app, x.final_cells);
    LL(:,i1) = cellfun(@(y) length(y), x.final_cells);
    %
    nn = num2str(i1);
    if length(nn) < 2
        nn = ['0',nn];
    end
    %
    ii = Tiff([wd,'\Results\',imname,'_final_',nn,'.tif'],'w');
    ii.setTag(ds)
    d = uint16(L(:,:,i1));
    write(ii,d);
    close(ii)
    %
    ut = x(:,nms);
    nms2 = cellfun(@(x) [x,'_',N{i1}], nms(2:3),'Uni',0);
    ut.Properties.VariableNames=([nms(1), nms2]);
    if i1 == 1
        t = ut;
    else
        t = outerjoin(ut, t,'MergeKeys',1);
    end
    %
end
%
end