wd = '\\bki04\Segmentation\TMAs\Melanoma_TMA_1287_40_01.30.2020\superpixel\Component_Tiffs';
%
fname = dir([wd,'\*tif']);
%
for i1 = 1:2
    fn = fullfile(wd,fname(i1).name);
    im(:,:,i1) = imread(fn,1);
end
%
cname = extractBefore(fname(1).name,'_param1');
cwd = '\\bki04\Segmentation\TMAs\Melanoma_TMA_1287_40_01.30.2020\inform_data\Component_Tiffs';
%
cname = [cwd,'\',cname,'.tif'];
%
n = 1;
for i1 = [1,9]
    im1 = imread(cname,i1);
    im1 = reshape(im1,[],1);
    imc(:,n) = im1 ./ max(im1);
    n = n+1;
end
%
col = [0 0 1;
    1 1 1];
%
imc = 250 .* asinh(2.5 .* imc);
imc2 = imc * col;
%
imc2 = reshape(imc2, 1404, 1872, 3);
%
ax1 = subplot(2,2,1);
imshow(uint8(imc2))
%
ima = label2rgb(im(:,:,1),'prism', 'k','shuffle');
aa = .25;
ii = ima > 0;
imc3 = imc2;
imc3(ii) = (1-aa) .* imc2(ii) + aa .* double(ima(ii));
ax2 = subplot(2,2,2);
imshow(uint8(imc3))
%
imb = label2rgb(im(:,:,2),'prism', 'k','shuffle');
aa = .25;
ii = imb > 0;
imc3 = imc2;
imc3(ii) = (1-aa) .* imc2(ii) + aa .* double(imb(ii));
ax4 = subplot(2,2,4);
imshow(uint8(imc3))
%
ax3 = subplot(2,2,3);
imshow(uint8(imc2))
%
linkaxes([ax1 ax2 ax3 ax4])
%{
ima = label2rgb(im(:,:,1),'prism', 'k','shuffle');
aa = .25;
ii = ima > 0;
imc3 = imc2;
imc3(ii) = (1-aa) .* imc2(ii) + aa .* double(ima(ii));
subplot(2,2,2);
imshow(uint8(imc3))
%}



