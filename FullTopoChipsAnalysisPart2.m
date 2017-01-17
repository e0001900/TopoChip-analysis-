%% Name: Topochips analysis
% created by Yu Yang
% date: Jan 2017
% modified by Yang
% used for SunM
% step 2 generating heatmap and averaging

clc; clear all; close all
cd('D:\Jordon\FineCropped\split channels\analysis');
%% loading data
data=xlsread('resultforTopochips.xlsx');

% select data, Rx for example, to generate the primary heatmap
b=9; %% column number
% return 0 as the array elements that are NaN
temdata=data(:,9);
nor_alb_ck19 = reshape(temdata,[66,66]); % change the size as needed
h1=figure();
colormap('hot')
imagesc(nor_alb_ck19)
colorbar

%% re-arrange the matrix and find the average
% left part
for i=1:1:33
    for j=1:1:33
    nor_alb_ck19_mean1(i,j)=(nor_alb_ck19(i,j)+nor_alb_ck19(i+33,j+33))/2;
    end
end

% right part
for i=1:1:33
    for j=34:1:64
    nor_alb_ck19_mean2(i,j)=(nor_alb_ck19(i,j)+nor_alb_ck19(i+33,j-33))/2;
    end
end

% generate the heatmap (averaged)
data_ave=cat(2,nor_alb_ck19_mean1, nor_alb_ck19_mean2);
h2=figure();
colormap('hot')
imagesc(data_ave)
colorbar
