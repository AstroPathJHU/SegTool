function app = getIFdistinct(app)
%%
% get the distinct cell objects from both inform cell segmentation layers
%
%%
%
% get distinct objects in inform
%
im = app.im_IF(:,:,1);
IF_cells_1 = label2idx(im);
m1 = regionprops(im,'centroid');
m1 = struct2cell(m1(:))';
%
im = app.im_IF(:,:,2);
IF_cells_2 = label2idx(im);
m2 = regionprops(im,'centroid');
m2 = struct2cell(m2(:))';
%
if length(IF_cells_1) > length(IF_cells_2)
    nn = length(IF_cells_1);
else
    nn = length(IF_cells_2);
end
%
IF_cells = cell(nn, 1);
m = cell(nn,1);
%
ii = ~cellfun(@isempty,IF_cells_1);
IF_cells(ii) = IF_cells_1(ii);
m(ii) = m1(ii);
%
ii = ~cellfun(@isempty,IF_cells_2);
IF_cells(ii) = IF_cells_2(ii);
m(ii) = m2(ii);
%
app.cells_n = IF_cells;
app.m = m;
%
end