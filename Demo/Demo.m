clc; clear; close all;
dbstop if error;
addpath(genpath('functions'));
addpath(genpath('../imagemetrics'));
%% loadimages
[MS_name, MS_path] = uigetfile('../image pairs/*.tif', 'Choose MS image');
[Pan_name, Pan_path] = uigetfile('../image pairs/*.tif', 'Choose Pan image');
MS=imread(fullfile(MS_path, MS_name));
Pan=imread(fullfile(Pan_path, Pan_name));
%% Pre-treatment
MS=double(MS);
SMS=MS;
Pan=double(Pan);
Pan=imresize(Pan,1/4,'bicubic');
DMS=imresize(MS,1/4,'bicubic');
UMS=imresize(DMS,4,'bicubic');
Pan=Pan/4095*1023;
%% Pansharpening
F=Pansharpening(UMS,Pan);
%% Metric
sol  = imagemetrics(MS,DMS,Pan,F);
%% Visualization
for k = 1 : 3
    HMS_write(:,:,k)=F(:,:,k)/max((max(F(:,:,1))));
    HMS_write(:,:,k) = imadjust(HMS_write(:,:,k),stretchlim(HMS_write(:,:,k)),[0.1,0.9]);
    MS_write(:,:,k)=MS(:,:,k)/max((max(MS(:,:,1))));
    MS_write(:,:,k) = imadjust(MS_write(:,:,k),stretchlim(MS_write(:,:,k)),[0.1,0.9]);
    UMS_write(:,:,k)=UMS(:,:,k)/max((max(MS(:,:,1))));
    UMS_write(:,:,k) = imadjust(UMS_write(:,:,k),stretchlim(UMS_write(:,:,k)),[0.1,0.9]);
end
%% Writing
folder = '../result';
Pan=Pan/max(Pan(:));
imwrite(HMS_write,strcat(folder,'/Fused_',MS_name));
imwrite(MS_write,strcat(folder,'/Original_',MS_name));
imwrite(UMS_write,strcat(folder,'/UMS_',MS_name));
imwrite(uint8(Pan * 255),fullfile(folder,Pan_name));