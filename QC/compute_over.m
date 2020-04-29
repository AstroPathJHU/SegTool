%%
%
%%
function [LL4, LL2, LL3, idx1] = compute_over(L,LL)
%
L1 = L(:,:,1);
L2 = L(:,:,2);
L3 = L(:,:,3);
%L4 = L(:,:,4);
%
overlap = L1 > 0 & L2 > 0 & L3 > 0;% & L4 > 0;
pairs = [L1(overlap), L2(overlap), L3(overlap)];%, L4(overlap)];
[ii, ~, kk] = unique(pairs, 'rows');
pairs_cnt = [ii,accumarray(kk,1)];
%
idx1 = pairs_cnt(:,1);
idx2 = pairs_cnt(:,2);
idx3 = pairs_cnt(:,3);
%idx4 = pairs_cnt(:,4);
% 
LL2(:,1) = pairs_cnt(:,4) ./ LL(idx1, 1);
LL2(:,2) = pairs_cnt(:,4) ./ LL(idx2, 2);
LL2(:,3) = pairs_cnt(:,4) ./ LL(idx3, 3);
%LL2(:,4) = pairs_cnt(:,5) ./ LL(idx4, 4);
%
LL3 = LL2(:,1) .* LL2(:,2) .* LL2(:,3);% .* LL2(:,4);
ii = LL3 < .8 & LL3 > .1;
LL5 = find(ii);
LL4(:,1) = LL5;
LL4(:,2)= LL3(ii);
LL4 = sortrows(LL4, 2);
%
end

        
        