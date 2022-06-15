wd = '\\halo1\Taubelab\Ben\Code\SegmentationTool\training_images';
P = {'RW','SS', 'GA','JK','AO'};
N = {'01','02','03','04','05'};
%
imname = 'Liver_TMA_145_23_01.30.2020_[6435,55763]';
%
gather_simil(wd, P, imname, N);
%
P = {'RW','SS', 'GA','JK','AO'};
N = {'01','02','03','04','05'};
imname = 'Liver_TMA_145_23_01.30.2020_[6489,53781]';
%
gather_simil(wd, P, imname, N);
%
P = {'RW','SS', 'GA','JK','AO'};
N = {'01','02','03','04','05'};
imname = 'Liver_TMA_145_24_01.30.2020_[5976,53791]';
%
gather_simil(wd, P, imname, N);
%
P = {'RW','SS', 'GA','JK','AO'};
N = {'01','02','03','04','05'};
imname = 'Lung_Adeno_TMA_1315_3_01.30.2020_[5515,52497]';
%
gather_simil(wd, P, imname, N);
%
P = {'RW','SS', 'GA','JK'};
N = {'01','02','03','04'};
imname = 'Lung_SCC_TMA_1314_6_01.30.2020_[6505,55245]';
%
gather_simil(wd, P, imname, N);
%
P = {'RW','SS', 'GA','JK'};
N = {'01','02','03','04'};
imname = 'Melanoma_TMA_1215_55_01.30.2020_[5393,65755]';
%
gather_simil(wd, P, imname, N);
%
P = {'SS', 'RW'};
N = {'02','01'};
imname = 'Melanoma_TMA_1287_40_01.30.2020_[6327,55511]';
%
gather_simil(wd, P, imname, N);
%
P = {'SS'};
N = {'02'};
imname = 'Melanoma_TMA_1287_40_01.30.2020_[5856,47509]';
%
[t,app,out3,L] = gather_simil(wd, P, imname, N);
%
P = { 'RW','GA'};
N = {'01','03'};
imname = 'Melanoma_TMA_1270_40_01.30.2020_[7601,47290]';
%
[t,app,out3,L] = gather_simil(wd, P, imname, N);
%
