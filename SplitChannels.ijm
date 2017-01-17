//Created by Yu Yang
//Used for preprocess in prior to Toposphero analysis
//Date Dec 2016

//For channel 1
//Specify the input folder and output folder name
input = getDirectory("Choose a folder for the input folder");
output= getDirectory("Choose a folder for the ouput folder");//
ch=5;//change from 1 to 5
setBatchMode(true);

File.makeDirectory(output);

//Load the parameters
list = getFileList(input);
for (i = 0; i < list.length; i++)
        action(input, output, list[i]);


function action(input, output, filename) {
        	open(input + filename);
	index=i+1;
	selectWindow(filename);
	run("Duplicate...", "title=[filename] duplicate channels=ch slices=1-24");
	// run("Z Project...", "projection=[Max Intensity]");
	new_name="processed"+index+filename;
	saveAs("Tiff", output + new_name);
	close();
	close();
	close();
}




