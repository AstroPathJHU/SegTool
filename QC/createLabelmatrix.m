function L = createLabelmatrix(app, cells_n1)
%%
% create a label matrix L from the cells in cells_n
%
%%
%
L = zeros(app.nRows, app.nCols, 'single');
%
for i1 = 1:length(cells_n1)
    idx = cells_n1{i1};
    if length(idx) == 1
        continue
    end
    L(idx) = i1;
end
%
end