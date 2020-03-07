function app = no_o_tbl(app, idx, tbl_in, colnames, z)
%%
% create the table of the size of the overlap table for cells without
% overlaps
%
%%
no_tbl = tbl_in;
no_tbl(idx,:) = [];
no_tbl.cellid = (z + 1:z + height(no_tbl))';
colnames_no = no_tbl.Properties.VariableNames;
ii = ~ismember(colnames, colnames_no);
tbl = array2table(zeros(height(no_tbl),sum(ii)));
tbl = [no_tbl, tbl];
tbl.Properties.VariableNames = [colnames_no,colnames(ii)];
%
tt = {'IF','ML'};
for i1 = 1:2
    tbl.([tt{i1},'_cells']) = num2cell(tbl.([tt{i1},'_cells']));
    tbl.([tt{i1},'_centriods']) = num2cell(tbl.([tt{i1},'_centriods']));
    tbl.([tt{i1},'_y']) = num2cell(tbl.([tt{i1},'_y']));
    tbl.([tt{i1},'_x']) = num2cell(tbl.([tt{i1},'_x']));
end
%
app.q = [app.q; tbl];
%
end