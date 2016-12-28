# TopoChip-analysis-
Codes for analysing Topochip images 

Images generated from EZ live fluorescence microscope are single images having only one channel and named in the format of Batch11_A01_s2_w1.TIF. The images are auto-focused so no z stack is needed. Hence, the images are sorted by different channels. Then stitched separately. Not sure if what is the problem of stitching these images. 

1. Run **_1_Relocating images.ijm_**

 1.To organize images into different channel folders named as w01,w02,w03,w04,w05 according to the order of the raw images. 
   Only one chip data can be processed for every run. 

2. Run **_2_Renaming images.ijm_**

 1.Rename each image in each channel folder with the file name format tile {iii}.TIF following the original order of raw images prior to stitching.
 
 2.Multiple sets of chip images can be renamed by  adding to “new array” list. 

Yet to be completed
…

Run 3_Stitching.ijm
Run 4_BackgroundSub.ijm
Run 5_CropCoarse.ijm
Run 6_CropFine.ijm
