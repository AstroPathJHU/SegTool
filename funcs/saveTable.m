function saveTable(app)
%%
% This function saves the app.overlap_table as a .csv file without the
% cells in it
%
%%
x = app.overlap_table;
%
x.final_cells = [];
x.IF_cells = [];
x.ML_cells = [];
%
ofname = [app.wd,'\inform_data\Component_Tiffs\',app.fname,...
    '_comparison_seg_data.csv'];
writetable(x, ofname)
%
end