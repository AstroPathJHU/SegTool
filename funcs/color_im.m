function [full_color_im, mem_dapi_im, dapi_im] = color_im(fname)
%% ------------------------------------------------------
%% get the color image layers from the component image and put them into a
%% color image. Also return a DAPI only image and a DAPI + Membrane image.
    %
    % color matrix 
    %
     mycol = [0 0 1;
        0 0 0
        0 1 0;
        1 1 0;
        1 0 0;
        0.91 0.41 0.17;
        0 1 1;
        1 0 1;
        1 1 1;
        0 0 0];
    %
    % get the image settings
    %
    wd = '\\bki04\Segmentation\IF_Membrane\inform_data\Component_Tiffs';
    fname = fullfile(wd, fname);
    fname = replace(fname, 'seg','w_seg');
    image_info = imfinfo(fname);
    H = image_info(1).Height;
    W = image_info(1).Width;
    %
    for i1 = 1:10
        im = imread(fname,i1);
        im = reshape(im,[],1);
        im1(:,i1) = im./max(im);
    end
    %
    % Multiply by the color matrix using the sinh transform
    %
    im2 = (180 .* sinh(1.5 .* im1));
    im3 = (300 .* sinh(3 .* im1));
    %
    full_color_im = im2 * mycol;
    %full_color_im = reshape(full_color_im, H, W);
    %
    mem_dapi_im = [im3(:,1),im2(:,9)] * [mycol(1,:); mycol(9,:)];
    %mem_dapi_im =  reshape(mem_dapi_im, H, W);
    %
    dapi_im = im3(:,1) * mycol(1,:);
    %dapi_im = reshape(dapi_im, H, W);
    %
end
    
    