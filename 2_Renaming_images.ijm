
//input: images in different channel folders 
// Change folder_list & dirName
// Directory hierarchy: dirNamemain>folder_name>Ch_name
// use '\\' instead of '\'
//dirNameMain = "D:\\users\\Jordon\\Topo Chip EZ live";
dirNameMain = getDirectory("Choose a Directory that has five folders,each repersenting one channel"); //open a dialogue to choose directory
folder_list = newArray("Batch 16 Day 2 (Final) [11-1-2017]");
// Do change the name here also, can do multiple batches of images at the same time; if they are same naming format
Ch_list = newArray("w01\\","w02\\","w03\\","w04\\");
imtypeIn = "TIF";
//imtypeOut = "PNG";

setBatchMode(true); //hide images during batch mode; 20X faster
for (i=0; i<folder_list.length; i++){
	
folder_name = "\\" + folder_list[i];
Ch_list = getFileList(dirNameMain+folder_name);

for (a=0; a<Ch_list.length; a++){ //loop through all the channels

folder_name = "\\" + folder_list[i];
Ch_name = Ch_list[a];

dirName = dirNameMain + folder_name + "\\" + Ch_name;

list=getFileList(dirName);

maxlen=lengthOf(list[0]);

for (j=0; j<list.length; j++){
	open(dirName + list[j]);
	
	if (lengthOf(list[j])==maxlen-2) {
	index=substring(list[j],lengthOf(list[j])-10+2,lengthOf(list[j])-7);
	new_name="tile 00"+index+"."+imtypeIn;}
	else if (lengthOf(list[j])==maxlen-1){
	index=substring(list[j],lengthOf(list[j])-10+1,lengthOf(list[j])-7);
	new_name="tile 0"+index+"."+imtypeIn;}
	else {
	index=substring(list[j],lengthOf(list[j])-10,lengthOf(list[j])-7);
	new_name="tile "+index+"."+imtypeIn;}
	File.rename(dirName+list[j], dirName+new_name);
	//saveAs(imtypeOut,dirName+new_name);
	close();
	//File.delete(dirName+list[j]);
}
//saveName=split(list[0],".");
//dirOutput = dirNameMain + folder_name + "\\output" + Ch_name;
//print(dirOutput);
//print(dirName);
//File.makeDirectory(dirOutput);
//if (File.exists(dirOutput)){
//print(dirOutput + saveName[0]);
//run("Convert...", "input=[" + dirName + "] output=[" + dirOutput + "] output_format=" + imtypeOut + " interpolation=Bilinear scale=1 save=[" + dirOutput + saveName[0] + "." + imtypeOut + "]");
//print("Done conversion!");
//}
//else {
//	print("OH NO!");}
}
}
print("Renaming Done!");
