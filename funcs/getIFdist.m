function IF_cells = getIFdist(app)
%%
% get the distinct cell objects from both inform cell segmentation layers
%
%%
%
% get distinct objects in inform
%
IF_cells_1 = label2idx(app.im_IF(:,:,1));
%
IF_cells_2 = label2idx(app.im_IF(:,:,2));
%
if length(IF_cells_1) > length(IF_cells_2)
    nn = length(IF_cells_1);
else
    nn = length(IF_cells_2);
end
%
IF_cells = cell(nn, 1);
%
ii = ~cellfun(@isempty,IF_cells_1);
IF_cells(ii) = IF_cells_1(ii);
%
ii = ~cellfun(@isempty,IF_cells_2);
IF_cells(ii) = IF_cells_2(ii);
%
end