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
            titles = {'IF','ML'};
            for i1 = 1:2
                if ~ismember([titles{i1},'_cells'], colnames_no)
                    tbl.([titles{i1},'_cells']) = num2cell(tbl.([titles{i1},'_cells']));
                end
            end
            %
            app.q = [app.q; tbl];
            %
        end
