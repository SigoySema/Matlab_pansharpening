%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% MAIN: REDUCED RESOLUTION VALIDATION %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear all;
close all;

%% Analyzed image choice

im_tag = 'WV2'; sensor = 'none';
%sensor = 'WV2';

%im_tag = 'China'; % sensor = 'none';
%sensor = 'IKONOS';

% im_tag = 'Tls1';
% sensor = 'none';

%im_tag = 'WV3';  sensor = 'none';
%sensor = 'IKONOS';

%im_tag = 'GF2';  sensor = 'none';

%% Quality Index Blocks
Qblocks_size = 32;

%% Interpolator
bicubic = 0;

%% Cut Final Image
%flag_cut_bounds = 1;
%dim_cut = 11;
flag_cut_bounds = 0;
dim_cut = 0;

%% Threshold values out of dynamic range
thvalues = 0;

%% Print Eps
printEPS = 0;

%% Resize Factor
ratio = 4;

%% Radiometric Resolution
L = 11;

%% %%%%%%%%%%%%%%%%%%%%%%%% Dataset load %%%%%%%%%%%%%%%%%%%%%%%%%%
%"\\Mac\Home\Desktop\MatlabWorkspace\pansharpeningtoolver_1_3\Pansharpening Tool ver 1.3\Main_Reduced_Resolution.m"
%"\\Mac\Home\Desktop\MatlabWorkspace\pansharpeningtoolver_1_3\Pansharpening Tool ver 1.3\Datasets"
switch im_tag
    case 'WV2'
        %load('Datasets/Rome_RR.mat');
        %I_MS = imread('\\Mac\Home\Desktop\MatlabWorkspace\pansharpeningtoolver_1_3\Pansharpening Tool ver 1.3\Datasets\WV2\ms\761.tif')
        %I_MS = imread('\\Mac\Home\Desktop\MatlabWorkspace\pa nsharpeningtoolver_1_3\Pansharpening Tool ver 1.3\Datasets\WV2\ms\761.tif')
        %I_MS = imread('/home/b507/Documents/MATLAB/pansharpeningtoolver_1_3/Pansharpening Tool ver 1.3/Output_img/WV2/MSDCNNwv2/test/761.tif')
        %I_MS = imread('\\Mac\Home\Desktop\MatlabWorkspace\pansharpeningtoolver_1_3\Pansharpening Tool ver 1.3\Datasets\WV2\pan\761.tif')
        %I_PAN_LR = imread('/home/b507/Documents/MATLAB/pansharpeningtoolver_1_3/Pansharpening Tool ver 1.3/Datasets/WV2/pan/761.tif')
        I_MS = imread(fullfile(pwd, 'Datasets', 'yaogan','WV2_data','ms',sprintf('%d.tif', indexImage))); 
        I_MS_loaded = I_MS;
        I_PAN_LR = imread(fullfile(pwd, 'Datasets', 'WV2','pan',sprintf('%d.tif', indexImage)));
        I_PAN_loaded = I_PAN_LR;
        
        im_prepare='resize';
        im_prepare='resize';
    case 'China'
        load('Datasets/China_RR.mat');
        I_MS = I_MS(:,:,[1,3,4,2]);
        I_MS_loaded = I_MS;
        I_PAN_loaded = I_PAN_LR;
        im_prepare='resize';
    case 'Tls1'
        load('Datasets/Pleiades_Sim.mat');
        im_prepare = 'donothing';
    case 'WV3'
        I_MS = imread('/home/b507/Documents/MATLAB/pansharpeningtoolver_1_3/Pansharpening Tool ver 1.3/Datasets/WV3/ms/2152.tif')
        I_MS_loaded = I_MS;
        I_PAN_LR = imread('/home/b507/Documents/MATLAB/pansharpeningtoolver_1_3/Pansharpening Tool ver 1.3/Datasets/WV3/pan/2152.tif')
        I_PAN_loaded = I_PAN_LR;
        im_prepare='resize';
    
    case 'GF2'
        I_MS = imread('/home/b507/Documents/MATLAB/pansharpeningtoolver_1_3/Pansharpening Tool ver 1.3/Datasets/GF2/ms/2807.tif')
        I_MS_loaded = I_MS;
        I_PAN_LR = imread('/home/b507/Documents/MATLAB/pansharpeningtoolver_1_3/Pansharpening Tool ver 1.3/Datasets/GF2/pan/2807.tif')
        I_PAN_loaded = I_PAN_LR;
        im_prepare='resize';
    
end

if strcmp(im_tag,'WV2') || strcmp(im_tag,'China') ||strcmp(im_tag,'WV3')||strcmp(im_tag,'GF2')
    I_GT = double(I_MS_loaded);
end

%% %%%%%%%%%%%%%    Preparation of image to fuse            %%%%%%%%%%%%%%

if strcmp(im_prepare,'resize')
    if (size(I_MS_loaded,1) == size(I_PAN_loaded,1)) && (size(I_MS_loaded,2) == size(I_PAN_loaded,2))
          I_MS_LR = resize_images(I_MS_loaded,I_PAN_loaded,ratio,sensor);
       
          I_PAN = double(I_PAN_LR);
    else
          [I_MS_LR, I_PAN]=resize_images(I_MS_loaded,I_PAN_loaded,ratio,sensor);
    end
end


%% Upsampling

if strcmp(im_tag,'WV2') || strcmp(im_tag,'China')|| strcmp(im_tag,'WV3')||strcmp(im_tag,'GF2')
        
    if bicubic == 1
        H = zeros(size(I_PAN,1),size(I_PAN,2),size(I_MS_LR,3));    
        for idim = 1 : size(I_MS_LR,3)
            H(:,:,idim) = imresize(I_MS_LR(:,:,idim),ratio);
        end
        I_MS = H;
    else
        I_MS = interp23tap(I_MS_LR,ratio);
    end
  
end

