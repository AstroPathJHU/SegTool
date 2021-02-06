cp = app.paired_cells;
%
% make sure levels are in the right order
%
ids = app.overlap_table.pairid;
gg = app.overlap_table.ground_level;
gg2 = gg(ids);
%
% for each cell compute any overlaps 
%
u_gg = unique(gg2);
overlap_list = zeros(length(cp),1);
%
for i1 = 1:length(cp)
    %
    % current cell
    %
    c_cp = cp(i1);
    %
    % get all cells from pairids in this group, remove the current cell
    % from the list
    %
    c_gg = gg2(i1);
    idx = find(gg2 == c_gg);
    m_ii = idx(idx == i1);
    cc_cp = cp;
    cc_cp(m_ii) = {0};
    %
    ii = cellfun(@(x) intersect(c_cp{i2}, x), cc_cp, 'Uni', 0);
    overlap_i = cellfun(@(x) any(x, 'all'), ii);
    %
    if any(overlap_i, 'all')
        %
        % warn of overlap
        %
        fprintf('overlap in %d\n', i1) 
        %
        % make the overlap_list value for this cell 1
        %
        overlap_list(i1) = 1;        
    end
    %
end
%
    overlap_i = 1;

    %
    % while overlap_i is true there are overlapping cells
    %
    while overlap_i
        if overlap_list(i1)
            %
            % serve cell up
            %
            
            %
            % change gg2
            %
            
        else
            break
        end
    end
        
for i1 = 1:length(u_gg)
    u_gg1 = u_gg(i1);
    ii = gg2 == u_gg1;
    c_cp = cp(ii);
    for i2 = 1:length(c_cp)
        cc_cp = c_cp;
        cc_cp(i2) = {0};
        ii = cellfun(@(x) intersect(c_cp{i2}, x), cc_cp, 'Uni', 0);
        ii2 = cellfun(@(x) any(x, 'all'), ii);
        if any(ii2)
end