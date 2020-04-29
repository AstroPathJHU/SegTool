function [a] = rm_dups(q)
%%
% remove duplicate cellids based on the joint probability for IF and ML
% data
%
%%
a = q;
%
tt = {'IF','ML'};
%
del_idx = [];
%
for i1 = 1:2
    %
    m = a.([tt{i1},'_cellid']);
    jp = a.jp;
    %
    bins = unique(m);
    bins(end+1) = max(bins) + 1;
    %
    [cnt,X] = histcounts(m, bins);
    X(end) = [];
    idx = cnt > 1;
    dups = X(idx);
    %
    for i2 = 1:length(dups)
       rows = find(m == dups(i2));
       jp_n = jp(rows);
       [~,idx] = sort(jp_n,'descend');
       del_idx = [del_idx; rows(idx ~= 1)];
    end
    %
    a(del_idx,:) = [];
end
%
end
%%
    