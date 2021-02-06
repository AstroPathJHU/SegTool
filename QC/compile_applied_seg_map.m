function compile_applied_seg_map(app)
%
x = app.overlap_table;
%
idx = 1:length(app.paired_cells);
gl = x.ground_level;
%
mlow = min(x.ground_level);
mhigh = max(x.ground_level);
app.applied_seg_im = zeros(app.nRows,...
    app.nCols);
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
%