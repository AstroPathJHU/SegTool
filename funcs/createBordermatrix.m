function L = createBordermatrix(app,cells_n1)
%
L = zeros(app.nRows, app.nCols, 'uint16');
%
for i1 = 1:length(cells_n1)
    idx = cells_n1{i1};
    if length(idx) == 1
        continue
    end
    L(idx) = i1;
end
%
% get boardering pixels by dilating and subtracting the cells
% themseleves
%
L2 = L > 0;
L(:,:,1) = (imdilate(L,ones(3,3)) - L) > 0;
L(:,:,2) = L2;
%
end