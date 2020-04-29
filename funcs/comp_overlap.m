        function app = comp_overlap(app)
            %%
            % This function computes the overlaps and adds them to the appropriate rows
            % in the table
            %
            %%
            o = [];
            for level = 1:2
                im1 = app.im_IF(:,:,level+1);
                overlap = im1 > 0 & app.im_ML > 0;
                pairs = [im1(overlap), app.im_ML(overlap)];
                [ii, ~, kk] = unique(pairs, 'rows');
                pairs_cnt = [ii,accumarray(kk,1)];
                %
                idx1 = pairs_cnt(:,1);
                idx2 = pairs_cnt(:,2);
                %
                app = crt_ovr_tbl(app,idx1,...
                    pairs_cnt(:,2) ,pairs_cnt(:,3), 'IF');
                %
                app = crt_ovr_tbl(app,idx2,...
                    pairs_cnt(:,1) ,pairs_cnt(:,3), 'ML');
                %
                tbl = outerjoin(app.o_tbl_IF,app.o_tbl_ML,'MergeKeys',1);
                %
                tbl.IF_level = repmat(level, height(tbl),1);
                o = [o;tbl];
            end
            %
            app.q = o;
            %
        end
