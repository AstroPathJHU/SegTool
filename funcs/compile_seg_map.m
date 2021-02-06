function compile_seg_map(app)
    %    
    x = app.overlap_table;
    tt1 = app.tt - 50;
    ll1 = app.ll - 50;
    bb1 = app.bb + 50;
    rr1 = app.rr + 50;
    %
    if app.tt < 1
        app.tt = 1;
    end
    if app.bb > app.nRows
        app.bb = app.nRows;
    end
    if app.ll < 1
        app.ll = 1;
    end
    if app.rr > app.nCols
        app.rr = app.nCols;
    end
    %
    im = zeros(app.nRows, app.nCols);
    im(tt1:bb1,ll1:rr1) = 1;
    idx = find(im);
    idx = find(cellfun(@(x) sum(ismember(x,idx)),app.paired_cells));
    gl = x.ground_level(idx);
    %
    mlow = min(x.ground_level);
    mhigh = max(x.ground_level);
    app.applied_seg_im = zeros(app.nRows, app.nCols);
    %
    for m_count = mlow:mhigh
        ii = gl == m_count;
        cells_n1 = app.paired_cells(idx(ii));
        im1 = createBordermatrix(app, cells_n1);
        app.applied_seg_im(im1(:,:,2) > 0) = 0;
        app.applied_seg_im(im1(:,:,1) > 0) = 1;
        %
    end
    %
    app.applied_seg_im = single(app.applied_seg_im)...
        .* app.seg_col;
end
    