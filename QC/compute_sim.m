%%
%
%%
function [four, three, two] = compute_sim(f)
%
% find all two's
%
ii1 = zeros(height(f),1);
for i1 = 1:length(P)
    ii = f.([P{i1},'_include_cell']) == 2;
    ii1 = ii + ii1;
end
%
four_two = sum(ii1 == 4);
three_two = sum(ii1 == 3);
two_two = sum(ii1 == 2);
%
% find all one's
%
ii1 = zeros(height(f),1);
for i1 = 1:length(P)
    ii = f.([P{i1},'_include_cell']) == 1;
    ii1 = ii + ii1;
end
%
four_one = sum(ii1 == 4);
three_one = sum(ii1 == 3);
two_one = sum(ii1 == 2);
%
% find all negone's
%
ii1 = zeros(height(f),1);
for i1 = 1:length(P)
    ii = f.([P{i1},'_include_cell']) == -1;
    ii1 = ii + ii1;
end
%
%
four_neg_one = sum(ii1 == 4);
three_neg_one = sum(ii1 == 3);
two_neg_one = sum(ii1 == 2);
%
four = four_two + four_one + four_neg_one;
three = three_two + three_one + three_neg_one;
two = two_two + two_one + two_neg_one;
%
end
