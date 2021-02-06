function im = compile_applied_seg_label(app)
%
x = app.overlap_table;
%
idx = 1:length(app.paired_cells);
gl = x.ground_level;
%
mlow = min(x.ground_level);
mhigh = max(x.ground_level);
im = zeros(app.nRows,...
    app.nCols);
%
for m_count = mlow:mhigh
    ii = gl == m_count;
    cells_n1 = app.paired_cells(idx(ii));
    im1 = createLabelmatrix(app, cells_n1, idx(ii));
    im(im1(:,:,1) > 0) = im1(im1(:,:,1) > 0);
    %
end
%
end
%