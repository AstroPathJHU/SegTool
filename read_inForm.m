function im = read_inForm(fname, layer)
    %
    wd = '\\bki04\Segmentation\IF_Membrane\inform_data\Component_Tiffs';
    fname = replace(fname, 'seg','w_seg');
    fname = fullfile(wd,fname);
    %
    im1 = imread(fname,11 + layer);
    im = reshape(im1, [], 1);
    %
end