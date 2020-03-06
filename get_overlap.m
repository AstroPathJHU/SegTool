function pct = get_overlap(y, x)
%% -----------------------------------------------
% Determine the fractional over lap for Y
% with X
%% -----------------------------------------------
l = length(y);
ii = ismember(y, x);
pct = sum(ii) ./ l;
end