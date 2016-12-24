%% used for SunM topochips cropping
% created by yu yang
% date Dec 2016

clc; clear all; close all

%% loading file
dirIn = uigetdir('','Choose the folder that contains all the coarse cropped images');
dirOut = uigetdir('','Choose the folder for output images');
f = filesep; % file separator
tiffiles = dir([dirIn f '*.png']); % specs for original image
lenTif = length(tiffiles);

%% pre-processing
for i = 1:lenTif
imname = [dirIn f tiffiles(i).name];
fprintf('Processing image %i of %i: %s ...\n',...
        i, lenTif, tiffiles(i).name) % Print out the process
% load initial image
%a_eq =adapthisteq(a);
% to find the edge using built in algorithm
I = imread(imname);
BW=edge(I, 'Canny');

% to connect the lines
SE = strel('disk',2);
BW1=imdilate(BW, SE);

% to fill up the inner holes
BW2=imfill(BW1, 'holes');

% to remove the unnecessary connection
% you can tune the length of line (50 to higher number)
SE = strel('line',50,90);
BW3=imopen(BW2, SE);
SE = strel('line',50,0);
BW4=imopen(BW3, SE);

% find labeled square
[L, num]= bwlabel(BW4);
[m, n] = size(L);
% create empty matrix
M = zeros(num,2);
T1 = zeros(m,n);
N = 0;

%% loop to extract the central part
for j = 1:num
    fprintf('Processing parts %i of %i \n', j, num) % Print out the process
    I3 = (L==j);
    % I4 = im2bw(I3);
    C = bwarea(I3);
    M(j,1) = j;
    M(j,2) = C;
    % find each portal and background 
    if  (C > 100000);
       T1 = T1+I3;
       %N = N+1;
    end 
end

%% create mask and crop
location = find(T1==0);
I(location) = 0;
imwrite(I,[dirOut, tiffiles(i).name],'tif')


end




