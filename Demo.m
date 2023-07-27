% Created by DXY, 06/10/2019.
clear; close all; clc;

% alpha = 1000;  beta= 0.01;  gamma = 0.1;  lambda = 10; % ��ز�������
alpha = 1000;  beta= 0.01;  gamma = 0.1;  lambda = 10; % ��ز�������
error_W = 10; error_I = 10;      % initial stopping criteria error_R and error_I
stop = 0.01;                      % stopping criteria
gamma1 = 2.2;
work_folder = './Test/'; 
file_list = dir(fullfile(work_folder,'*.png'));
%if ~exist('./Outputs/real_input_demo_1lz','dir')
   %mkdir('./Outputs/real_input_demo_1lz');
%end
outdir = './Test-ABILD/';
for i = 1 : 1 : length(file_list)
    im_name = file_list(i).name;
    input_im = im2double(imread([work_folder,im_name]));
     [r,c,~] = size(input_im);
    im_r = input_im(:,:,1);
    im_g = input_im(:,:,2);
    im_b = input_im(:,:,3);  
	mean_S_r = mean2(im_r);
	mean_S_g = mean2(im_g);
	mean_S_b = mean2(im_b);
    max_mean = max( max(mean_S_r,mean_S_g), mean_S_b);
    

        C_g = ones(r,c)*max_mean;
        [I_g, W_g] = processing_1(input_im(:,:,2), alpha, beta, gamma, lambda, error_I, error_W, stop, C_g);
        C_b = ones(r,c)*max_mean;
        [I_b, W_b] = processing_1(input_im(:,:,3), alpha, beta, gamma, lambda, error_I, error_W, stop, C_b);  
        C_r = ones(r,c)*max_mean;            
        [I_r, W_r] = processing_1(input_im(:,:,1), alpha, beta, gamma, lambda, error_I, error_W, stop, C_r);

	I = cat(3,I_r,I_g,I_b);
    J = DC(I); 
    imwrite(J,[outdir,im_name],'png');
    disp(i);
    
   
end