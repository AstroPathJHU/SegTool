function L = createBordermatrix(app, cells_n1)
%%
% create a label matrix L from the cells in cells_n
%
%%
%
L = zeros(app.nRows,...
    app.nCols, 'uint16');
%
for i1 = 1:length(cells_n1)
    idx = cells_n1{i1};
    if length(idx) == 1
        continue
    end
    %
    L(idx) = i1;
end
%
% get boardering pixels by dilating and subtracting the cells
% themseleves
%
L = (imdilate(L,ones(3,3)) - L) > 0;
L(:,:,2) = imfill(L,'holes')-L;
L = L .* 225;
%
end
%