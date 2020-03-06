function app = comp_overlap(app,im1,level)
%%
% This function computes the overlaps and adds them to the appropriate rows
% in the table
%
%%
overlap = im1 > 0 & app.im_ML > 0;
pairs = [im1(overlap), app.im_ML(overlap)];
[ii, ~, kk] = unique(pairs, 'rows');
pairs_cnt = [ii,accumarray(kk,1)];
%
idx1 = pairs_cnt(:,1);
idx2 = pairs_cnt(:,2);
%
if level == 1
        %
        app.IF_table.overlap_L1(idx1) = pairs_cnt(:,3);
        app.IF_table.pct_L1 = app.IF_table.overlap_L1...
            ./ app.IF_table.n_pixels;
        app.IF_table.pair_L1(idx1) = pairs_cnt(:,2);
        %
        app.ML_table.overlap_L1(idx2) = pairs_cnt(:,3);
        app.ML_table.pct_L1 = app.ML_table.overlap_L1...
            ./ app.ML_table.n_pixels;
        app.ML_table.pair_L1(idx2) = pairs_cnt(:,1);
        %
elseif level == 2
        %
        app.IF_table.overlap_L2(idx1) = pairs_cnt(:,3);
        app.IF_table.pct_L2 = app.IF_table.overlap_L2...
            ./ app.IF_table.n_pixels;
        app.IF_table.pair_L2(idx1) = pairs_cnt(:,2);
        %
        app.ML_table.overlap_L2(idx2) = pairs_cnt(:,3);
        app.ML_table.pct_L2 = app.ML_table.overlap_L2...
            ./ app.ML_table.n_pixels;
        app.ML_table.pair_L2(idx2) = pairs_cnt(:,1);
        %
end
%
end