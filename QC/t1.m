wd = '\\halo1\Taubelab\Ben\Code\SegmentationTool\training_images\SegmentationImages_';
P = {'RW','SS', 'GA','JK','AO'};
N = {'01','02','03','04','05'};
%
imname = 'Liver_TMA_145_23_01.30.2020_[6435,55763]';
%
[t,app, out3, L] = gather_simil(wd, P, imname, N);
tbl_dual = sorenson_dice(L);
writetable(tbl_dual, 'image_1_dice.csv')
%{
[LL4, LL2, LL3, idx1] = compute_over(L, LL);
LL2 = array2table(LL2);
LL2.Properties.VariableNames = cellfun(@(x) ['N_',x],N,'Uni',0);
LL2.cellid = f.cellid(idx1);
LL2 = [LL2(:,end), LL2(:,1:end-1)];
writetable(LL2, [wd,'\Results\',imname,'_users_overlaps.csv'])
display(same);display(gg2);display(mean(LL3(LL3>.1)))
%}
%
P = {'RW','SS', 'GA','JK','AO'};
N = {'01','02','03','04','05'};
imname = 'Liver_TMA_145_23_01.30.2020_[6489,53781]';
%
[t,app,out3, L] = gather_simil(wd, P, imname, N);
tbl_dual = sorenson_dice(L);
writetable(tbl_dual, 'image_2_dice.csv')
%[~, same, gg2, f, L, LL] = filter_results(app, wd, imname, t, N);
%{
[LL4, LL2, LL3, idx1] = compute_over(L, LL);
LL2 = array2table(LL2);
LL2.Properties.VariableNames = cellfun(@(x) ['N_',x],N,'Uni',0);
LL2.cellid = f.cellid(idx1);
LL2 = [LL2(:,end), LL2(:,1:end-1)];
writetable(LL2, [wd,'\Results\',imname,'_users_overlaps.csv'])
display(same);display(gg2);display(mean(LL3(LL3>.1)))
%}
%
P = {'RW','SS', 'GA','JK','AO'};
N = {'01','02','03','04','05'};
imname = 'Liver_TMA_145_24_01.30.2020_[5976,53791]';
%
[t,app,out3, L] = gather_simil(wd, P, imname, N);
tbl_dual = sorenson_dice(L);
writetable(tbl_dual, 'image_3_dice.csv')
%[~, same, gg2, f, L, LL] = filter_results(app, wd, imname, t, N);
%{
[LL4, LL2, LL3] = compute_over(L, LL);
LL2 = array2table(LL2);
LL2.Properties.VariableNames = cellfun(@(x) ['N_',x],N,'Uni',0);
writetable(LL2, [wd,'\Results\',imname,'_users_overlaps.csv'])
display(same);display(gg2);display(mean(LL3(LL3>.1)))
%}
%
P = {'RW','SS', 'GA','JK','AO'};
N = {'01','02','03','04','05'};
imname = 'Lung_Adeno_TMA_1315_3_01.30.2020_[5515,52497]';
%
[t,app,out3, L] = gather_simil(wd, P, imname, N);
tbl_dual = sorenson_dice(L);
writetable(tbl_dual, 'image_4_dice.csv')
%[~, same, gg2, f, L, LL] = filter_results(app, wd, imname, t, N);
%{
[LL4, LL2, LL3] = compute_over(L, LL);
LL2 = array2table(LL2);
LL2.Properties.VariableNames = cellfun(@(x) ['N_',x],N,'Uni',0);
writetable(LL2, [wd,'\Results\',imname,'_users_overlaps.csv'])
display(same);display(gg2);display(mean(LL3))
%}
%
P = {'RW','SS', 'GA','JK'};
N = {'01','02','03','04'};
imname = 'Lung_SCC_TMA_1314_6_01.30.2020_[6505,55245]';
%
[t,app,out3,L] = gather_simil(wd, P, imname, N);
tbl_dual = sorenson_dice(L);
writetable(tbl_dual, 'image_5_dice.csv')
%[~, same, gg2, f, L, LL] = filter_results(app, wd, imname, t, N);
%{
[LL4, LL2, LL3] = compute_over(L, LL);
LL2 = array2table(LL2);
LL2.Properties.VariableNames = cellfun(@(x) ['N_',x],N,'Uni',0);
writetable(LL2, [wd,'\Results\',imname,'_users_overlaps.csv'])
display(same);display(gg2);display(mean(LL3))
%}
%
P = {'RW','SS', 'GA','JK'};
N = {'01','02','03','04'};
imname = 'Melanoma_TMA_1215_55_01.30.2020_[5393,65755]';
%
[t,app,out3,L] = gather_simil(wd, P, imname, N);
tbl_dual = sorenson_dice(L);
writetable(tbl_dual, 'image_6_dice.csv')
%
%
P = {'SS'};
N = {'02'};
imname = 'Melanoma_TMA_1287_40_01.30.2020_[6327,55511]';
%
[t,app,out3,L] = gather_simil(wd, P, imname, N);
tbl_dual = sorenson_dice(L);
writetable(tbl_dual, 'image_7_dice.csv')%
%
P = {'SS'};
N = {'02'};
imname = 'Melanoma_TMA_1287_40_01.30.2020_[5856,47509]';
%
[t,app,out3,L] = gather_simil(wd, P, imname, N);
tbl_dual = sorenson_dice(L);
writetable(tbl_dual, 'image_8_dice.csv')
%
P = { 'RW','GA'};
N = {'01','03'};
imname = 'Melanoma_TMA_1270_40_01.30.2020_[7601,47290]';
%
[t,app,out3,L] = gather_simil(wd, P, imname, N);
tbl_dual = sorenson_dice(L);
writetable(tbl_dual, 'image_9_dice.csv')
%
P = { 'RW'};
N = {'01'};
imname = 'Melanoma_TMA_1287_40_01.30.2020_[6327,55511]';
%
[t,app,out3,L] = gather_simil(wd, P, imname, N);
%tbl_dual = sorenson_dice(L);
%writetable(tbl_dual, 'image_10_dice.csv')
%
