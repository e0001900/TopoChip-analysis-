//Modified Dec 2016 by SunM + Chan Way
//Outcome: Images from one run of imaging (chs) will be stitched and stored in the output folder
//Optimized for Topochip A1R images

//Variables to change
imtype = "TIF"; //png, tif, etc
x = 17; //number of images along x
y = 17; //number of images along y
z = 1; //number of images along z
EmptyFirstRow = 0; //0:don't create top padding images; 1:create top padding images
RowOrCol = 0; //0:row by row; 1:column by column
setBatchMode(true); //Comment out this line if speed is not needed (20x faster without displaying images)

if (RowOrCol) {
	type = "[Grid: column-by-column]";
	order = "[Down & Right                ]";
}
else {
	type = "[Grid: row-by-row]";
	order = "[Right & Down                ]";
}

input_dirMain = getDirectory("Choose the folder that contains all the images for processing");
sep = File.separator; //the file name separator character ("/" or "\")
output_dir = input_dirMain + "Fused" + sep;
folder_list = getFileList(input_dirMain);
File.makeDirectory(output_dir); //create output folder 

//Stitch the first image
firstToProcess = 0;
ref = ""; // dir of TileConfiguration.registered.txt
folder_name = substring(folder_list[firstToProcess], 0, lengthOf(folder_list[firstToProcess])-1);
input_dirName = input_dirMain + folder_name + sep;
output_file = output_dir + folder_name + "." + imtype;

if (EmptyFirstRow) {
	createFirstRow(input_dirName, x, imtype);
	y++;
}
ref = stitch(1, type, order, x, y, input_dirName, imtype, output_file, ref);
if (EmptyFirstRow) { //remove the lines for the first row
	txtFile = ref + "TileConfiguration.registered.txt";
	rmLines(txtFile, 5, x+4); //the fifth line is for tile_1
}

//Stitch all the images using the same template from the first image
for (i=1; i<folder_list.length; i++) {
	folder_name = substring(folder_list[i], 0, lengthOf(folder_list[i])-1);
	input_dirName = input_dirMain + folder_list[i];
	output_file = output_dir + folder_name + "." + imtype;
	ref = stitch(0, type, order, x, y, input_dirName, imtype, output_file, ref);
}

//Create a stack using all the stitched images
run("Images to Stack", "name=Stack title=[] use");
saveAs(imtype, output_dir+"Stack");

run("Close All");
//hyperstack(output_dir, folder_list.length, 1, 1, imtype); //t=1
print("Stitching Done!");



function createFirstRow(dir, xMax, imtype) {
	//Create top padding images of the same size as the rest of the images in the folder
	files = getFileList(dir);
	open(dir + files[0]);
	w = getWidth();
	h = getHeight();
	close();
	newImage("Untitled", "16-bit black", w, h, 1);
	for (x=0; x<xMax; x++) { //creating a row a images
		filename = dir + "tile_" + (x+1);
		saveAs(imtype, filename);
	}
}

function rmLines(file, start, end) {
	//Remove a block of lines (from start to end) from a text file from
	txt = File.openAsString(file);
	lines = split(txt, "\n");
	l1 = Array.slice(lines, 0, start-1);
	l2 = Array.slice(lines, end);
	lines = Array.concat(l1, l2);
	f = File.open(file);
	for (i=0; i<lines.length; i++) {
		print(f, lines[i]);
	}
	File.close(f);
}

function stitch(firstIm, type, order, x, y, input_dirName, imtype, output_file, ref) {
	//Stitch the images in input_dirName and return input_dirName as reference
	if (firstIm) { //serve as a template for the subsequent stitching
		run("Grid/Collection stitching", "type="+type+" order="+order+" grid_size_x="+x+" grid_size_y="+y+" tile_overlap=10 first_file_index_i=1 directory=["+input_dirName+"] file_names=[tile {iii}." + imtype + "] output_textfile_name=TileConfiguration.txt fusion_method=[Linear Blending] regression_threshold=0.30 max/avg_displacement_threshold=2.50 absolute_displacement_threshold=3.50 compute_overlap subpixel_accuracy computation_parameters=[Save memory (but be slower)] image_output=[Fuse and display]");
		saveAs(imtype, output_file);
	}
	else { //stitch according to the template
		txt = File.separator + "TileConfiguration.registered.txt";
		File.copy(ref+txt, input_dirName+txt);
		run("Grid/Collection stitching", "type=[Positions from file] order=[Defined by TileConfiguration] directory=["+input_dirName+"] layout_file=TileConfiguration.registered.txt fusion_method=[Linear Blending] regression_threshold=0.30 max/avg_displacement_threshold=2.50 absolute_displacement_threshold=3.50 subpixel_accuracy computation_parameters=[Save memory (but be slower)] image_output=[Fuse and display]");
		saveAs(imtype, output_file);
	}
	return input_dirName;
}

function hyperstack(dir, c, z, t, imtype) {
	//Group all the images from a folder into a hyperstack and save the hyperstack in the same folder
	files = getFileList(dir);
	for (i=0; i<files.length; i++) {
		open(dir + files[i]);
	}
	run("Images to Stack", "name=Stack title=[] use");
	run("Stack to Hyperstack...", "order=xyczt(default) channels="+c+" slices="+z+" frames="+t+" display=Color");
	saveAs(imtype, dir+"Hyperstack");
	close();
}
