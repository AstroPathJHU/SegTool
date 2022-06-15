wd = '\\halo1\Taubelab\Ben\Code\SegmentationTool\training_images';
%
P = {'RW'};
N = {'01'};
imname = 'Melanoma_TMA_1287_40_01.30.2020_[5856,47509]_2';
%
gather_simil(wd, P, imname, N);
%------------------------------
P = {'RW'};
N = {'01'};
imname = 'Melanoma_TMA_1287_40_01.30.2020_[5856,47509]_4';
%
gather_simil(wd, P, imname, N);
%---------------------------------
P = {'GA'};
N = {'03'};
imname = 'Melanoma_TMA_1287_40_01.30.2020_[5856,47509]_1';
%
gather_simil(wd, P, imname, N);
%---------------------------------
P = {'GA'};
N = {'03'};
imname = 'Melanoma_TMA_1287_40_01.30.2020_[5856,47509]_3';
%
gather_simil(wd, P, imname, N);
%---------------------------------
P = {'RW'};
N = {'01'};
imname = 'Liver_TMA_145_23_01.30.2020_[18889,61237]';
%
gather_simil(wd, P, imname, N);
%---------------------------------
P = {'GA'};
N = {'03'};
imname = 'Lung_Adeno_TMA_1315_3_01.30.2020_[9030,66610]';
%
gather_simil(wd, P, imname, N);