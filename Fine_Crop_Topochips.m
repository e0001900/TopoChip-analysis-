%% used for SunM topochips cropping
% created by yu yang
% date Dec 2016

clc
clear all
close all

%% loading file
sdirectory1 = 'C:\Users\Yang\Desktop\Cropped (Fused Ph, Larger ROI)\Image'; % directory for original image
source1 = 'C:\Users\Yang\Desktop\Cropped (Fused Ph, Larger ROI)\Result\';

tiffiles1 = dir([sdirectory1 '\*.png']);% specs for original image
lenTiff1 = length(tiffiles1);

%% pre-processing
for aa = 1:length(tiffiles1);
    % for the following sentence, Mac use /!!! Windows use \!!!
filename1 = [sdirectory1 '\' tiffiles1(aa).name];
fprintf('Processing image %i of %i: %s ...\n',...
        aa, length(tiffiles1), tiffiles1(aa).name) % Print out the process
% load initial image
%a_eq =adapthisteq(a);
% to find the edge using built in algorithm
I = imread(filename1);
BW=edge(I, 'Canny');

% to connect the lines
se = strel('disk',2);
BW1=imdilate(BW, se);

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
[m n] = size(L);
% create empty matrix
M = zeros(num,2);
T1 = zeros(m,n);
N = 0;

%% loop to extract the central part
for a = 1:num
    fprintf('Processing parts %i of %i \n', a, num) % Print out the process
    I3 = (L==a);
    % I4 = im2bw(I3);
    C = bwarea(I3);
    M(a,1) = a;
    M(a,2) = C;
    % find each portal and background 
    if  (C >100000);
       T1 = T1+I3;
       %N = N+1;
    end 
end

%% create mask and crop
location=find(T1==0);
I(location)=0;
imwrite(I,[source1, tiffiles1(aa).name],'tif')


end




