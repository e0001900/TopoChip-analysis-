# TopoChip-analysis-
Codes for analysing Topochip images 

Images generated from EZ live fluorescence microscope are single images having only one channel and named in the format of Batch11_A01_s2_w1.TIF. The images are auto-focused so no z stack is needed. Hence, the images are sorted by different channels. Then stitched separately. Not sure if what is the problem of stitching these images. 

1. Run **_1_Relocating images.ijm_**

 1.To organize images into different channel folders named as w01,w02,w03,w04,w05 according to the order of the raw images. 
   Only one chip data can be processed for every run. 

2. Run **_2_Renaming images.ijm_**

 1.Rename each image in each channel folder with the file name format tile {iii}.TIF following the original order of raw images prior to stitching.
 
 2.Multiple sets of chip images can be renamed by  adding to “new array” list. 
 
3. Run **_3_Stitching.ijm_**
 1. Don't forget to adjust all the parameters prior to run the codes
 2. Stack images comprising of 5 channels will be generated

4. Run **_4_BackgroundSub.ijm_**
 1. Make sure the ROI folder(for background subtraction)is under Fiji plugin folder.
 
5. Run **_5_CropCoarse.ijm_**
 1. Note down the value printed out in log; useful for next-step fine cropping

5. Run **_5_CropFine.m_**
 1. Adjust parameters prior to run the matlab codes 
 
 
 Yet to be completed


