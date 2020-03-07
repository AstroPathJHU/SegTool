function app = comp_overlap(app)
%%
% This function computes the overlaps and adds them to the appropriate rows
% in the table
%
%%
q = [];
for level = 1:2
    im1 = app.im_IF(:,:,level);
    overlap = im1 > 0 & app.im_ML > 0;
    pairs = [im1(overlap), app.im_ML(overlap)];
    [ii, ~, kk] = unique(pairs, 'rows');
    pairs_cnt = [ii,accumarray(kk,1)];
    %
    idx1 = pairs_cnt(:,1);
    idx2 = pairs_cnt(:,2);
    %
    o_tbl_IF = crt_ovr_tbl(app,idx1,...
        pairs_cnt(:,2) ,pairs_cnt(:,3), 'IF');
    %
    o_tbl_ML = crt_ovr_tbl(app,idx2,...
        pairs_cnt(:,1) ,pairs_cnt(:,3), 'ML');
    %
    tbl = outerjoin(o_tbl_IF,o_tbl_ML,'MergeKeys',1);
    %
    tbl.IF_level = repmat(level, height(tbl),1);
    q = [q;tbl];
end
%
app.q = q;
end