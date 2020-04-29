function app =  getIFdistinct(app)
%%
% get the distinct cell objects from both inform cell segmentation layers
%
%%
%
% get distinct objects in inform
%
im = app.im_IF(:,:,2);
IF_cells_1 = label2idx(im);
m1 = regionprops(im,'centroid');
m1 = struct2cell(m1);
%
im = app.im_IF(:,:,3);
IF_cells_2 = label2idx(im);
m2 = regionprops(im,'centroid');
m2 = struct2cell(m2);
%
if length(IF_cells_1) > length(IF_cells_2)
    nn = length(IF_cells_1);
else
    nn = length(IF_cells_2);
end
%
IF_cellso = cell(nn, 1);
mo = cell(1,nn);
%
ii = ~cellfun(@isempty,IF_cells_1);
IF_cellso(ii) = IF_cells_1(ii);
mo(ii) = m1(ii);
%
ii = ~cellfun(@isempty,IF_cells_2);
IF_cellso(ii) = IF_cells_2(ii);
mo(ii) = m2(ii);
%
app.cells_n = IF_cellso;
app.m = mo;
%
end
