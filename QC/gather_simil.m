%%
% wd = 'Z:\Ben\Code\SegmentationTool\assessment';
% P = {'A','G','H','S'};
% imname = 'Liver_TMA_145_23_01.30.2020_[6435,55763]_comparison_seg_data'
%%
function [t, app, out2, L_out] = gather_simil(wd, P, imname,N)
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
nms = {'pairid','class_selection','cell_check','flags','ground_level'};
out2 = [];
t = table();
L_out = [];
%
for i1 = 1:length(P)
    app.IF_filename = [wd,P{i1},'\inform_data\Component_Tiffs\',...
        imname,'_component_data_w_seg.tif'];
    app.SP_filename = [wd,P{i1},'\superpixel\Component_Tiffs\',...
        imname,'_component_data_seg.tif'];
    app.wd = [wd,P{i1}];
    app.seg_col = 225;
    app.fname = imname;
    app = readimages(app);
    [app] = reload_overlap_table(app);
    %
    ds.ImageLength = app.nRows;
    ds.ImageWidth = app.nCols;
    L = compile_applied_seg_label(app);
    %
    nn = num2str(i1);
    if length(nn) < 2
        nn = ['0',nn];
    end
    %
    ii = Tiff(['\\halo1\Taubelab\Ben\Code\SegmentationTool\assessment',...
        '\Results\',imname,'_comparison_seg_data_final_',nn,'.tif'],'w');
    ii.setTag(ds)
    d = uint16(L(:,:,1));
    write(ii,d);
    close(ii)
    %
    t2 = app.overlap_table.flags;
    t4 = [];
    for i2 = 1:2
        t1 =  t2 ./ 2;
        t2 = floor(t1);
        t3 = t1 - t2;
        t4(:,i2) = t3 ~= 0; %#ok<AGROW>
    end
    %
    ot = table();
    ot.cellid = app.overlap_table.pairid;
    ot.multinuc = t4(:,1);
    ii = ~ismember(ot.cellid, unique(L));
    ot(ii,:) = [];
    writetable(ot, ['\\halo1\Taubelab\Ben\Code\SegmentationTool\assessment',...
        '\Results\',imname,'_comparison_seg_data_final_',nn,'.csv'])
    %
    [out] = filter_results(app);
    out2 = [out2;out];
    ut = app.overlap_table(:,nms);
    nms2 = cellfun(@(x) [x,'_',N{i1}], nms(2:end),'Uni',0);
    ut.Properties.VariableNames=([nms(1), nms2]);
    if i1 == 1
        t = ut;
    else
        t = outerjoin(ut, t,'MergeKeys',1);
    end
    L_out(:,:,i1) = L;
    %
end
%
end