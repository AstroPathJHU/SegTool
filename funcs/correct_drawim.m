wd = ['\\halo1\TaubeLab\Ben\Code\SegmentationTool\',...
    'training_images\SegmentationImages_SS\inform_data\Component_Tiffs'];
fname = 'Liver_TMA_145_23_01.30.2020_[6489,53781]_comparison_seg_data.csv';
tt = readtable([wd,'\',fname]);
imname = replace(fname,'csv','tif');
%
im = imread([wd,'\',imname],1);
%
im(im > height(tt)) = 0;
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
ds.ImageLength = 1404;
ds.ImageWidth = 1872;
%
ii = Tiff([wd,'\',imname],'w');
%
ii.setTag(ds)
d = uint16(im(:,:,1));
write(ii,d);
close(ii)