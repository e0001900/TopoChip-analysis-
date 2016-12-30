//Created by Yu Yang
//Modified Dec 2016 by SunM + Chan Way 
//input: images in the whole one folder 
//Outcome: images will be separated into  channels in the order of w01, w02,w03,w04,w05 without renaming 
//Optimized for EZ live images 

//Variables to change
x = 17; //number of images along x
y = 17; //number of images along y
n = 5; //here n serve as number of different channels 
offset = 0; //0:no empty first row needed; 1:for creating empty first row
RowOrCol = 0; //0:images are in row-by-row; 1:images are in col-by-col ???Not sure how to do it 
imtype = "tif"; //tif, png, etc
//Ch_list = newArray("Ph"); //actually we don't need this one 
setBatchMode(true); //Comment out this line if speed is not needed (20x faster without displaying images)

input = getDirectory("Choose the folder that contains the images for processing");
list = getFileList(input);
sep = File.separator; //the file name separator character ("/" or "\")

//Create a folder for each n and move the images into the right folder
for (k=0; k<n; k++) { // Only for n<100
	if (k+1 < 10) {	
		output = input + "w0" + (k+1) + sep;
	}
	else {
		output = input + "w" + (k+1) + sep;
	}
	File.makeDirectory(output);

	for (i=k; i<list.length; i+=n)
 {
		File.rename(input+list[i], output+list[i]); //move images to different n folder
	}
	//splitCh(Ch_list, imtype, output); //split images from one n into different ch
	//for (c=0; c<1; c++)  //rename the images for each channel
		//dirC = output  + sep;
		//renameRow(offset, RowOrCol, dirC, x, y, imtype);
	
}	

print("Relocating images Done!");



function splitCh(Ch_list, imtype, dir) {
	//this function split the tiff stacks from a folder into respective channels
	//Ch_list in reverse order of the stacks
	list = getFileList(dir);
	for (c=0; c<Ch_list.length; c++) { //create a folder for each ch
		File.makeDirectory(dir + Ch_list[c]);
	}
	for (f=0; f<list.length; f++) { //loop through all the tiff stacks
		open(dir + list[f]);
		run("Stack to Images");
		for (c=0; c<Ch_list.length; c++) { //split the tiff stacks into respective ch
			saveAs(imtype, dir+Ch_list[c]+File.separator+list[f]);
			close();
		}
		File.delete(dir + list[f]);
	}
}

function renameRow(offset, RowOrCol, dir, x, y, imtype) {
	//rename images and return the images in order row-by-row
	list = getFileList(dir);
	index = 0;
	if(offset) { //for creating empty first row for stitching
		index = x;
	}
	incre = 1;
	if(RowOrCol) { //for transposing col-by-col
		incre = y;
	}
	//Rename
	for (i=0; i<incre; i++) {
		for (k=i; k<list.length; k+=incre) {
			index++;
			new_name = "tile_" + index + "." + imtype;
			File.rename(dir+list[k], dir+new_name);
		}
	}
}
