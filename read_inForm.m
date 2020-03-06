function im = read_inForm(fname, layer)
    %
    wd = '\\bki04\Segmentation\IF_Membrane\inform_data\Component_Tiffs';
    fname = replace(fname, 'seg','w_seg');
    fname = fullfile(wd,fname);
    %
    im = imread(fname,11 + layer);
    %
end