%%
% wd = 'Z:\Ben\Code\SegmentationTool\assessment';
% imname = 'Liver_TMA_145_23_01.30.2020_[6435,55763]_comparison_seg_data'
% P = {'S','H','G','A'};
% t
%%
function [qcd, same, gg2, f, L, LL] = filter_results(app, wd, imname, t, P)
%
f=t;
ii1 = zeros(height(f),1);
for i1 = 1:length(P)
    ii = f.(['include_cell_',P{i1}]) == 0;
    ii1 = ii + ii1;
end
f(ii1>0,:) = [];
%
ii1 = zeros(height(f),1);
for i1 = 1:length(P)
    e = cellfun(@isempty,f.(['final_cells_',P{i1}]));
    ii1 = e + ii1;
end
e = ii1>0;
f(e,:) = [];
%
ii = f.(['include_cell_',P{i1}]) == 4;
same = sum(ii);
f(ii,:) = [];
%
for i1 = 1:length(P)
L(:,:,i1) = createLabelmatrix(app, f.(['final_cells_',P{i1}]));
LL(:,i1) = cellfun(@(y) length(y), f.(['final_cells_',P{i1}]));
%
writetable(f,[wd,'\Results\',imname,'_user_comp.csv'])
%
qcd = height(f);
%
for i1 = 1:length(P)
    gg =  groupcounts(f, ['include_cell_',P{i1}]);
    gg.Properties.VariableNames = {'type',['GC_',P{i1}]};
    if i1 == 1
        gg2 = gg;
    else
        gg2 = outerjoin(gg2,gg, 'MergeKeys',1);
    end
end
%
%nms = cellfun(@(x)[x,'_include_cell'],P,'Uni',0);
%gg = groupcounts(f, nms);
%
end