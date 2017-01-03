% Modified by Yang
% Date 05 May 2016
% used for 66*66 chip for SunM
% count from separated 4 chips and added up for full analysis
% Date 02 June 2016
% used for L3 cell detection

format long;
close all
clc;
clear all;

cd('Y:\Dropbox\Hanry Projects\Yu Yang-Staining vs Microscopy\Trial 1\data')
% read file for pile 1 upper left
A=xlsread('quardant 1.xlsx');
% return 0 as the array elements that are NaN
A(isnan(A))=0;b=5; %%  interested column number
% find IntDen
c=A(:,b);
% find the transpoze matrix
c=c';
[row,col]=size(c);
Int_nuc11=c(1,1:4:(end-1));
Int_alb11=c(1,2:4:(end));
Int_ck11=c(1,3:4:(end));
Int_cyp11=c(1,4:4:(end));
% find the ratio between certain fluoro
alb_Int_nuc_Int11=Int_alb11./Int_nuc11;
ck_Int_nuc_Int11=Int_ck11./Int_nuc11;
cyp_Int_nuc_Int11=Int_cyp11./Int_nuc11;

% reshape: vector to matrix
Int_nuc_11 = reshape(Int_nuc11,[33,33]);
Int_alb_11 = reshape(Int_alb11,[33,33]);
Int_ck_11=reshape(Int_ck11,[33,33]);
Int_cyp_11=reshape(Int_cyp11,[33,33]);
% find the reshaped matrix for ratio
alb_Int_nuc_Int_11 = reshape(alb_Int_nuc_Int11,[33,33]);
ck_Int_nuc_Int_11 = reshape(ck_Int_nuc_Int11,[33,33]);
cyp_Int_nuc_Int_11 = reshape(cyp_Int_nuc_Int11,[33,33]);
% find the blank control
% mean_alb11=1;
% mean_cyp11=1;
% mean_unk11=1;

% read file for pile 2 upper right using same procedures
B=xlsread('quardant 2.xlsx');
B(isnan(B))=0;b=5; %%  interested column number
% return 0 as the array elements that are NaN
c=B(:,b);
% find IntDen
c=c';
[row,col]=size(c);
Int_nuc12=c(1,1:4:(end-1));
Int_alb12=c(1,2:4:(end));
Int_ck12=c(1,3:4:(end));
Int_cyp12=c(1,4:4:(end));
alb_Int_nuc_Int12=Int_alb12./Int_nuc12;
ck_Int_nuc_Int12=Int_ck12./Int_nuc12;
cyp_Int_nuc_Int12=Int_cyp12./Int_nuc12;

% reshape: vector to matrix
Int_nuc_12 = reshape(Int_nuc12,[33,33]);
Int_alb_12 = reshape(Int_alb12,[33,33]);
Int_ck_12=reshape(Int_ck12,[33,33]);
Int_cyp_12=reshape(Int_cyp12,[33,33]);
alb_Int_nuc_Int_12 = reshape(alb_Int_nuc_Int12,[33,33]);
ck_Int_nuc_Int_12 = reshape(ck_Int_nuc_Int12,[33,33]);
cyp_Int_nuc_Int_12 = reshape(cyp_Int_nuc_Int12,[33,33]);
mean_alb12=(alb_Int_nuc_Int_12(17,17)+alb_Int_nuc_Int_12(33,1))/2;
mean_ck12=(ck_Int_nuc_Int_12(17,17)+ck_Int_nuc_Int_12(33,1))/2;
mean_cyp12=(cyp_Int_nuc_Int_12(17,17)+cyp_Int_nuc_Int_12(33,1))/2;

% read file for pile 3 lower left using same procedures
C=xlsread('quardant 3.xlsx');
C(isnan(C))=0;b=5; %%  interested column number
% return 0 as the array elements that are NaN
c=C(:,b);
% find IntDen
c=c';
[row,col]=size(c);
Int_nuc21=c(1,1:4:(end-1));
Int_alb21=c(1,2:4:(end));
Int_ck21=c(1,3:4:(end));
Int_cyp21=c(1,4:4:(end));
alb_Int_nuc_Int21=Int_alb21./Int_nuc21;
ck_Int_nuc_Int21=Int_ck21./Int_nuc21;
cyp_Int_nuc_Int21=Int_cyp21./Int_nuc21;

% reshape: vector to matrix
Int_nuc_21 = reshape(Int_nuc21,[33,33]);
Int_alb_21 = reshape(Int_alb21,[33,33]);
Int_ck_21=reshape(Int_ck21,[33,33]);
Int_cyp_21=reshape(Int_cyp21,[33,33]);
alb_Int_nuc_Int_21 = reshape(alb_Int_nuc_Int21,[33,33]);
ck_Int_nuc_Int_21 = reshape(ck_Int_nuc_Int21,[33,33]);
cyp_Int_nuc_Int_21 = reshape(cyp_Int_nuc_Int21,[33,33]);
mean_alb21=(alb_Int_nuc_Int_21(17,17)+alb_Int_nuc_Int_21(33,1))/2;
mean_ck21=(ck_Int_nuc_Int_21(17,17)+ck_Int_nuc_Int_21(33,1))/2;
mean_cyp21=(cyp_Int_nuc_Int_21(17,17)+cyp_Int_nuc_Int_21(33,1))/2;

% read file for pile 4 lower right using same procedures
D=xlsread('quardant 4.xlsx');
D(isnan(D))=0;b=5; %%  interested column number
% return 0 as the array elements that are NaN
c=D(:,b);
% find IntDen
c=c';
[row,col]=size(c);
Int_nuc22=c(1,1:4:(end-1));
Int_alb22=c(1,2:4:(end));
Int_ck22=c(1,3:4:(end));
Int_cyp22=c(1,4:4:(end));
alb_Int_nuc_Int22=Int_alb22./Int_nuc22;
ck_Int_nuc_Int22=Int_ck22./Int_nuc22;
cyp_Int_nuc_Int22=Int_cyp22./Int_nuc22;

% reshape: vector to matrix
Int_nuc_22 = reshape(Int_nuc22,[33,33]);
Int_alb_22 = reshape(Int_alb22,[33,33]);
Int_ck_22=reshape(Int_ck22,[33,33]);
Int_cyp_22=reshape(Int_cyp22,[33,33]);
alb_Int_nuc_Int_22 = reshape(alb_Int_nuc_Int22,[33,33]);
ck_Int_nuc_Int_22 = reshape(ck_Int_nuc_Int22,[33,33]);
cyp_Int_nuc_Int_22 = reshape(cyp_Int_nuc_Int22,[33,33]);
% mean_alb22=1;
% mean_cyp22=1;
% mean_unk22=1;

% Question: to use which one as blank control???
% to find the averaged mean
mean_alb=(mean_alb12+mean_alb21)/2;
mean_ck=(mean_ck12+mean_ck21)/2;
mean_cyp=(mean_cyp12+mean_cyp21)/2;

alb_Int_nuc_Int_mean_top1=zeros(33,33);
ck_Int_nuc_Int_mean_top1=zeros(33,33);
cyp_Int_nuc_Int_mean_top1=zeros(33,33);

alb_Int_nuc_Int_mean_top2=zeros(33,33);
ck_Int_nuc_Int_mean_top2=zeros(33,33);
cyp_Int_nuc_Int_mean_top2=zeros(33,33);

% find the average ratio intensity using all 4 piles
for i=1:1:33;
for j=1:1:33;
%for ratio using uppper left and lower right
% data has been normalised to control
alb_Int_nuc_Int_mean_top1(i,j)=(alb_Int_nuc_Int_11(i,j)/(mean_alb))+(alb_Int_nuc_Int_22(i,j)/(mean_alb))/2;

ck_Int_nuc_Int_mean_top1(i,j)=(ck_Int_nuc_Int_11(i,j)/(mean_ck))+(ck_Int_nuc_Int_22(i,j)/(mean_ck))/2;

cyp_Int_nuc_Int_mean_top1(i,j)=(cyp_Int_nuc_Int_11(i,j)/(mean_cyp))+(cyp_Int_nuc_Int_22(i,j)/(mean_cyp))/2;

% for ratio using upper right and lower left
% data has been normalised to control
alb_Int_nuc_Int_mean_top2(i,j)=(alb_Int_nuc_Int_12(i,j)/(mean_alb))+(alb_Int_nuc_Int_21(i,j)/(mean_alb))/2;

ck_Int_nuc_Int_mean_top2(i,j)=(ck_Int_nuc_Int_12(i,j)/(mean_ck))+(ck_Int_nuc_Int_21(i,j)/(mean_ck))/2;

cyp_Int_nuc_Int_mean_top2(i,j)=(cyp_Int_nuc_Int_12(i,j)/(mean_cyp))+(cyp_Int_nuc_Int_21(i,j)/(mean_cyp))/2;

end
end

%% using signal from selected to detect the bilinary cells
% CYP3A4 is hepatocyte's marker, CK19+ Albumin- is for bilinary cells
% that means cyp+ ck+ alb-

% make threshold
thres1=0.0000000001;
alb_Int_nuc_Int_mean_top11=zeros(33,33);
ck_Int_nuc_Int_mean_top11=zeros(33,33);
cyp_Int_nuc_Int_mean_top11=zeros(33,33);
alb_Int_nuc_Int_mean_top22=zeros(33,33);
ck_Int_nuc_Int_mean_top22=zeros(33,33);
cyp_Int_nuc_Int_mean_top22=zeros(33,33);

t11=find(alb_Int_nuc_Int_mean_top1<thres1);
t12=find(alb_Int_nuc_Int_mean_top1>thres1);
alb_Int_nuc_Int_mean_top11(t11)=0;
alb_Int_nuc_Int_mean_top11(t12)=1;

t21=find(ck_Int_nuc_Int_mean_top1<thres1);
t22=find(ck_Int_nuc_Int_mean_top1>thres1);
ck_Int_nuc_Int_mean_top11(t21)=0;
ck_Int_nuc_Int_mean_top11(t22)=1;

t31=find(cyp_Int_nuc_Int_mean_top1<thres1);
t32=find(cyp_Int_nuc_Int_mean_top1>thres1);
cyp_Int_nuc_Int_mean_top11(t31)=0;
cyp_Int_nuc_Int_mean_top11(t32)=1;

t41=find(alb_Int_nuc_Int_mean_top2<thres1);
t42=find(alb_Int_nuc_Int_mean_top2>thres1);
alb_Int_nuc_Int_mean_top22(t41)=0;
alb_Int_nuc_Int_mean_top22(t42)=1;

t51=find(ck_Int_nuc_Int_mean_top2<thres1);
t52=find(ck_Int_nuc_Int_mean_top2>thres1);
ck_Int_nuc_Int_mean_top22(t51)=0;
ck_Int_nuc_Int_mean_top22(t52)=1;

t61=find(cyp_Int_nuc_Int_mean_top2<thres1);
t62=find(cyp_Int_nuc_Int_mean_top2>thres1);
cyp_Int_nuc_Int_mean_top22(t61)=0;
cyp_Int_nuc_Int_mean_top22(t62)=1;


% cell detection for upper left and lower right
bil_cell_top1=zeros(33,33);
a=find((alb_Int_nuc_Int_mean_top11==0)&(ck_Int_nuc_Int_mean_top11==1));
bil_cell_top1(a)=1;
nonzeros1=nnz(bil_cell_top1);
total1=numel(bil_cell_top1);
ratio1=nonzeros1/total1;

hep_cell_top1=zeros(33,33);
a=find((cyp_Int_nuc_Int_mean_top11==1));
hep_cell_top1(a)=1;
nonzeros2=nnz(hep_cell_top1_cell_top1);
total2=numel(hep_cell_top1);
ratio2=nonzeros2/total2;

% cell detection for upper right and lower left
bil_cell_top2=zeros(33,33);
b=find((alb_Int_nuc_Int_mean_top22==0)&(ck_Int_nuc_Int_mean_top22==1));
bil_cell_top2(b)=1;
nonzeros3=nnz(bil_cell_top2);
total3=numel(bil_cell_top2);
ratio3=nonzeros3/total13

hep_cell_top2=zeros(33,33);
a=find(&(cyp_Int_nuc_Int_mean_top11==1));
hep_cell_top2(a)=1;
nonzeros4=nnz(hep_cell_top2);
total4=numel(hep_cell_top2);
ratio4=nonzeros4/total4;

% write result to excel for different piles
d={'Number';'Nuclei Intensity';'Albumin Intensity';'CK Intensity';'CYP Intensity';'Albumin intensity Normalised to Nucleus Intensity ';'CK intensity Normalised to Nucleus Intensity';'CYP intensity Normalised to Nucleus Intensity'};
Final=[1:1089; Int_nuc11;Int_alb11;Int_ck11;Int_cyp11;alb_Int_nuc_Int11;ck_Int_nuc_Int11;cyp_Int_nuc_Int11];
xlswrite ('Upper left result.xlsx',d);
xlswrite ('Upper left result.xlsx',Final,1,'B1');

d={'Number';'Nuclei Intensity';'Albumin Intensity';'CK Intensity';'CYP Intensity';'Albumin intensity Normalised to Nucleus Intensity ';'CK intensity Normalised to Nucleus Intensity';'CYP intensity Normalised to Nucleus Intensity'};
Final=[1:1089; Int_nuc12;Int_alb12;Int_ck12;Int_cyp12;alb_Int_nuc_Int12;ck_Int_nuc_Int12;cyp_Int_nuc_Int12];
xlswrite ('Upper right result.xlsx',d);
xlswrite ('Upper right result.xlsx',Final,1,'B1');

d={'Number';'Nuclei Intensity';'Albumin Intensity';'CK Intensity';'CYP Intensity';'Albumin intensity Normalised to Nucleus Intensity ';'CK intensity Normalised to Nucleus Intensity';'CYP intensity Normalised to Nucleus Intensity'};
Final=[1:1089; Int_nuc21;Int_alb21;Int_ck21;Int_cyp21;alb_Int_nuc_Int21;ck_Int_nuc_Int21;cyp_Int_nuc_Int21];
xlswrite ('Lower left result.xlsx',d);
xlswrite ('Lower left result.xlsx',Final,1,'B1');

d={'Number';'Nuclei Intensity';'Albumin Intensity';'CK Intensity';'CYP Intensity';'Albumin intensity Normalised to Nucleus Intensity ';'CK intensity Normalised to Nucleus Intensity';'CYP intensity Normalised to Nucleus Intensity'};
Final=[1:1089; Int_nuc22;Int_alb22;Int_ck22;Int_cyp22;alb_Int_nuc_Int22;ck_Int_nuc_Int22;cyp_Int_nuc_Int22];
xlswrite ('Lower right result.xlsx',d);
xlswrite ('Lower right result.xlsx',Final,1,'B1');

% heatmap for mean ratio
% generate heatmap for first group
xlswrite ('alb1.xlsx',alb_Int_nuc_Int_mean_top1);
xlswrite ('ck1.xlsx',ck_Int_nuc_Int_mean_top1);
xlswrite ('cyp1.xlsx',cyp_Int_nuc_Int_mean_top1);
h1=figure();
colormap('redgreencmap')
imagesc(alb_Int_nuc_Int_mean_top1)
colorbar
figname=['alb_Int_nor_mean_top1'];
print('-r300','-dtiff', fullfile(pwd,figname))
h2=figure();
colormap('redgreencmap')
imagesc(ck_Int_nuc_Int_mean_top1)
colorbar
figname=['ck_Int_nor_mean_top1'];
print('-r300','-dtiff', fullfile(pwd,figname))
h3=figure();
colormap('redgreencmap')
imagesc(cyp_Int_nuc_Int_mean_top1)
colorbar
figname=['cyp_Int_nor_mean_top1'];
print('-r300','-dtiff', fullfile(pwd,figname))

% generate heatmap for second group
xlswrite ('alb2.xlsx',alb_Int_nuc_Int_mean_top2);
xlswrite ('ck2.xlsx',ck_Int_nuc_Int_mean_top2);
xlswrite ('cyp2.xlsx',cyp_Int_nuc_Int_mean_top2);
h11=figure();
colormap('redgreencmap')
imagesc(alb_Int_nuc_Int_mean_top2)
colorbar
figname=['alb_Int_nor_mean_top2'];
print('-r300','-dtiff', fullfile(pwd,figname))
h22=figure();
colormap('redgreencmap')
imagesc(ck_Int_nuc_Int_mean_top2)
colorbar
figname=['ck_Int_nor_mean_top2'];
print('-r300','-dtiff', fullfile(pwd,figname))
h33=figure();
colormap('redgreencmap')
imagesc(cyp_Int_nuc_Int_mean_top2)
colorbar
figname=['cyp_Int_nor_mean_top2'];
print('-r300','-dtiff', fullfile(pwd,figname))

% generate heatmap for cell detection
xlswrite ('heatmap 1.xlsx',bil_cell_top1);
xlswrite ('heatmap 2.xlsx',bil_cell_top2);
h11=figure();
colormap('redgreencmap')
imagesc(bil_cell_top1)
colorbar
figname=['bil detection for pile 1'];
print('-r300','-dtiff', fullfile(pwd,figname))
h11=figure();
colormap('redgreencmap')
imagesc(bil_cell_top2)
colorbar
figname=['bil detection for pile 2'];
print('-r300','-dtiff', fullfile(pwd,figname))

xlswrite ('heatmap 3.xlsx',hep_cell_top1);
xlswrite ('heatmap 4.xlsx',hep_cell_top2);
h11=figure();
colormap('redgreencmap')
imagesc(hep_cell_top1)
colorbar
figname=['hep detection for pile 1'];
print('-r300','-dtiff', fullfile(pwd,figname))
h11=figure();
colormap('redgreencmap')
imagesc(hep_cell_top2)
colorbar
figname=['hep detection for pile 2'];
print('-r300','-dtiff', fullfile(pwd,figname))

fprintf('...Done! The ratio of the Bil cell 1 is %0.2f\n', ratio1)
fprintf('...Done! The ratio of the Bil cell 2 is %0.2f\n', ratio2)
fprintf('...Done! The ratio of the Hep cell 1 is %0.2f\n', ratio3)
fprintf('...Done! The ratio of the Hep cell 3 is %0.2f\n', ratio4)