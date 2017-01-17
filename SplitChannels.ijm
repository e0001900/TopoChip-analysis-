//Created by Yu Yang
//Used for preprocess in prior to Toposphero analysis
//Date Dec 2016

//For channel 1
//Specify the input folder and output folder name
input = getDirectory("Choose a folder for the input folder");
output= getDirectory("Choose a folder for the ouput folder");//
ch=1;//change from 1 to 5
setBatchMode(true);
imtype = "TIF"; //png, tif, etc


File.makeDirectory(output);

//Load the parameters
list = getFileList(input);
for (i=0; i<list.length; i++){
    //action(input, output, list[i]);
    //function action(input, output, filename) {
    file_name = list[i];
    print(file_name);
    //open(input+file_name);
    open(input + list[i]);
	//index=i+1;
	//selectWindow(file_name);
	run("Stack to Images");
    run("Duplicate...", " ");
	//run("Duplicate...", "title=[filename] duplicate channels=ch slices=1-24");
	// run("Z Project...", "projection=[Max Intensity]");
	//new_name="processed"+index+file_name;
	saveAs("Tiff", output + file_name);
	close();
	close();
	close();
	close();
	print("Split image"+file_name);
}
    print("Done!");



