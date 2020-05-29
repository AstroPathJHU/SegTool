function im = read_inForm(app, fname, layer)
    %
    wd = [app.wd,'\inform_data\Component_Tiffs'];
    fname = fullfile(wd,[fname, '_component_data_w_seg.tif']);
    %
    im = imread(fname,11 + layer);
    %
end