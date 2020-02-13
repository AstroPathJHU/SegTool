function im = read_ML(fname)
   %
   wd = '\\bki04\Segmentation\IF_Membrane\Correction';
   fname = fullfile(wd,fname);
   %
   im = imread(fname);
   im = reshape(im, [],1);
end