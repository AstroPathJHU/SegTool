function app = int_results_cols(app)
%%
% this function intializes the results columns and defines the cells that
% overlap 80% above as the machine learning algorithm cell but defines the
% cell include parameter as 4 instead of 2
% 
%%
x = app.q;
%
% results columns
%
x.include_cell = zeros(height(x),1);
c = zeros(height(x),1);
c = num2cell(c);
x.final_cells = c;
%
% settings for the 80% overlap cells
%
ii = x.jp >= .8;
x.include_cell(ii) = 4;
x.final_cells(ii) = x.ML_cells(ii);
%
% remove empty cells 
%
ii = isnan(x.ML_X_centroid);
x(ii,:) = [];
ii = isnan(x.IF_X_centroid);
x(ii,:) = [];
%
% redefine the cellid
%
x.cellid = (1:height(x))';
app.q = x;
%
end