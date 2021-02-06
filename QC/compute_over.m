%%
%
%%
function [LL4, LL2, LL3, idx1] = compute_over(L)
%
ss = size(L);
overlap = L(:,:,1) > 0;
%
for i1 = 2:ss(3)
    overlap = overlap > 0 & L(:,:,i1) > 0;
end
%
pairs = [];
for i1 = 1:ss(3)
    Ln = L(:,:,i1);
    pairs = [pairs, Ln(overlap)];
end
%
[ii, ~, kk] = unique(pairs, 'rows');
pairs_cnt = [ii,accumarray(kk,1)];
%
for i1 = 1:ss(3)
    [ii, ~, kk] = unique(L(:,:,i1));
    LL{i1} = [ii,accumarray(kk,1)];
end
%
for i1 = 1:ss(3)
    ss2 = max(LL{i1}(:,1));
    ii = zeros(ss2,1);
    ii(LL{i1}(2:end,1)) = LL{i1}(2:end,2);
    ii2 = find(ii);
    LL2(:,i1) = pairs_cnt(:,ss(3) + 1) ./ LL{i1}(ii(pairs_cnt(:,i1)));
end
%
LL3 = LL2(:,1);
for i1 = 2:ss(3)
    LL3 = LL2(:,i1) .* LL3;
end
%LL3 = LL2(:,1) .* LL2(:,2) .* LL2(:,3) .* LL2(:,4);
ii = LL3 < .8 & LL3 > .1;
LL5 = find(ii);
LL4(:,1) = LL5;
LL4(:,2)= LL3(ii);
LL4 = sortrows(LL4, 2);
%
end

        
        