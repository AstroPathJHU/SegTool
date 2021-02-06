function tbl_dual = sorenson_dice(L)
%
ss = size(L);
%
combs = (ss(3)*(ss(3)-1))/2;
tbl_dual = array2table(zeros(0,2), 'VariableNames', {'cellid_a','cellid_b'});
%
k = 1;
j = (k+1):ss(3);
k_count = 0;
stepupval = ss(3) - 1;
%
% get the dual intersections
%
for i1 = 1:combs
    %
    % get the separate objects and their counts
    %
    k_count = k_count + 1;
    kn = j(k_count);
    overlap = L(:,:,k)>0 & L(:,:,kn)>0 ;
    L1 = L(:,:,k);
    L2 = L(:,:,kn);
    pairs = [L1(overlap), L2(overlap)];
    [ii, ~, kk] = unique(pairs, 'rows');
    pairs_cnt = [ii,accumarray(kk,1)];
    %
    % totals for each object in the image
    %
    [ii, ~, kk] = unique(L1);
    LL1 = [ii,accumarray(kk,1)];
    [ii, ~, kk] = unique(L2);
    LL2 = [ii,accumarray(kk,1)];
    %
    ss2 = max(LL1(:,1));
    ii1 = zeros(ss2,1);
    ii1(LL1(2:end,1)) = LL1(2:end,2);
    %
    ss2 = max(LL2(:,1));
    ii2 = zeros(ss2,1);
    ii2(LL2(2:end,1)) = LL2(2:end,2);
    %
    LL3 = 2 * pairs_cnt(:,3) ./ (ii1(pairs_cnt(:,1)) +...
        ii2(pairs_cnt(:,2)));
    %
    tbl = array2table([pairs_cnt(:,1:2),LL3]);
    %
    tbl.Properties.VariableNames = {'cellid_a','cellid_b',...
        ['cd_',num2str(k),'_',num2str(kn)]};
    ii = tbl.(['cd_',num2str(k),'_',num2str(kn)]) < .1;
    tbl(ii,:) = [];
    tbl_dual = outerjoin(tbl, tbl_dual, 'MergeKeys', true);
    %
    if k_count == stepupval
        stepupval = stepupval - 1;
        k_count = 0;
        k = k + 1;
        j = (k+1):ss(3);
    end
    %
end
%
% remove nans
%
for i1 = 1:width(tbl_dual)
    ii = isnan(table2array(tbl_dual(:,i1)));
    if find(ii, 1)
        tbl_dual{ii,i1} = 0;
    end
end
%
end
