%% Name: Topochips analysis
% created by Yu Yang
% date: Jan 2017
% modified by Yang
% used for SunM

clc; clear all; close all

%% loading image
sdirectory1 = uigetdir('','Choose the folder directory for channel 2 dapi');% directory for channel 2 dapi
sdirectory2 = uigetdir('','Choose the folder directory for channel 3 alb'); % directory for channel 3 alb
sdirectory3 = uigetdir('','Choose the folder directory for channel 5 ck19'); % directory for channel 5 ck19
source1 = uigetdir('','Choose the folder directory for processed dapi saving directory'); % processed dapi saving directory
source2 = uigetdir('','Choose the folder directory for processed alb saving directory'); % processed alb saving directory
source3 = uigetdir('','Choose the folder directory for processed ck19 saving directory'); % processed ck19 saving directory

% settings 
tiffiles1 = dir([sdirectory1 '\*.tif']);% specs for 1
lenTiff1 = length(tiffiles1);
tiffiles2 = dir([sdirectory2 '\*.tif']);% specs for 2
lenTiff2 = length(tiffiles2);
tiffiles3 = dir([sdirectory3 '\*.tif']);% specs for 3
lenTiff3 = length(tiffiles3);



% The blank is teh value pre-calculated!!!
cd('D:\Jordon\FineCropped\split channels\blank');
sig2blank = imread('0166-0003.tif');
sig3blank = imread('0166-0004.tif');
tmp11=sum(sum(sig2blank));
tmp22=sum(sum(sig3blank));
blank=tmp11/tmp22;

%saving directory
cd('D:\Jordon\FineCropped\split channels\analysis');

% initializing variables
	numpre=zeros(length(tiffiles1),1);
	%name=zeros(length(tiffiles1),1);
	ch3value = zeros(lenTiff1,1);
	ch5value = zeros(lenTiff1,1);
	R1 = zeros(lenTiff1,1);
	R2 = zeros(lenTiff1,1);
	Rx = zeros(lenTiff1,1);
	Rf = zeros(lenTiff1,1);

%% image processing for every well
for aa = 1:length(tiffiles1);
    % for the following sentence, Mac use /!!! Windows use \!!!
	filename1 = [sdirectory1 '\' tiffiles1(aa).name];
	filename2 = [sdirectory2 '\' tiffiles2(aa).name];
	filename3 = [sdirectory3 '\' tiffiles3(aa).name];
	fprintf('Processing image %i of %i: %s ...\n',...
        aa, length(tiffiles1), tiffiles1(aa).name) % Print out the process
	% load initial image
	dapi = imread(filename1);
	sig2 = imread(filename2);
	sig3 = imread(filename3);
	% convert to unit 8 image
	%dapi = im2uint32(dapi);
	%sig2 = im2uint32(sig2);
	%sig3 = im2uint32(sig3);
	% binarization
	level1 = graythresh(dapi);
	BWdapi = im2bw(dapi,level1);
	level2 = graythresh(sig2);
	BWsig2 = im2bw(sig2,level2);
	level3 = graythresh(sig3);
	BWsig3 = im2bw(sig3,level3);
	
	% process on the dapi
	imwrite(BWdapi,[source1,'dapi_processed_',num2str(aa),'.tif'],'tif')
	
	[L,num] = bwlabel(BWdapi);
	numpre(aa,1)=num;
	counts2=0;
	
	counts3=0;
	
	%% analyzing the image
	% for alb intensity
	tmp1=sum(sum(sig2));
	ch3value(aa) = tmp1;
	
	% for ck19 intensity
	tmp2=sum(sum(sig3));
	ch5value(aa) = tmp2;
	
	% for normalized alb intensity
	R1(aa) =  tmp1/num;
	
	% for normalized ck19 intensity
	R2(aa) =  tmp2/num;
	
	% for normalized alb and ck19 intensity
	Rx(aa) =  tmp1/tmp2;
	
	% for normalized alb and ck19 intensity versus blank
	Rf(aa) =  tmp1/tmp2/blank;
	
end

name = cellstr(cat(1,tiffiles1.name));
	
% writing excel result for sphero number and data 
filename1 = 'resultforTopochips.xlsx';
cell=[1:aa];
index=cell';
allResults = [numpre,ch3value,ch5value,R1,R2,Rx,Rf];

sheet = 1;
xlRange = 'C2';
xlswrite(filename1,allResults,sheet,xlRange)

sheet = 1;
xlRange = 'B2';
xlswrite(filename1,name,sheet,xlRange)

sheet = 1;
xlRange = 'A2';
xlswrite(filename1,index,sheet,xlRange)
	
filename = 'resultforTopochips.xlsx';
headings = {'Chip number','Chip name', 'Cell number', 'alb intensity', 'ck19 intensity', 'normalized alb', 'normalized ck19', 'normalized alb ver ck19', 'Normalized versus blank'};
sheet = 1;
xlRange = 'A1';
xlswrite(filename,headings,sheet,xlRange)
