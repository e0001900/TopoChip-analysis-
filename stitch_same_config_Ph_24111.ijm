
// Change folder_list & input_dirName & output_dirName

// Ph
imtype = "png";
x = 17;
y = 17;

folder_list = newArray("28-11-2016 (Batch 11) processed");

for (i=0; i<folder_list.length; i++){

   folder_name=folder_list[i];	     
   
   // Use '\\' instead of '\'
   input_dirName = "[D:\\users\\Jordon\\Topo Chip EZ live" + "\\" + folder_name + "\\Ph]";
   output_dirName = "D:\\users\\Jordon\\Topo Chip EZ live\\28-11-2016 (Batch 11) processed" + "\\FusedPh\\FusedPh" + folder_name + "." + imtype; // Create folder "FusedPh" first

if (i==0){
//run("Grid/Collection stitching", "type=[Grid: row-by-row] order=[Right & Down             ] grid_size_x=2 grid_size_y=3 tile_overlap=10 first_file_index_i=1 directory=" + input_dirName + "file_names=[tile {iii}.png] output_textfile_name=TileConfiguration.txt fusion_method=[Linear Blending] regression_threshold=0.30 max/avg_displacement_threshold=2.50 absolute_displacement_threshold=3.50 compute_overlap subpixel_accuracy computation_parameters=[Save memory (but be slower)] image_output=[Fuse and display]");
run("Grid/Collection stitching", "type=[Grid: row-by-row] order=[Right & Down                ] grid_size_x=" + x + " grid_size_y=" + y + " tile_overlap=10 first_file_index_i=1 directory=" + input_dirName + "file_names=[tile {iii}." + imtype + "] output_textfile_name=TileConfiguration.txt fusion_method=[Linear Blending] regression_threshold=0.30 max/avg_displacement_threshold=2.50 absolute_displacement_threshold=3.50 compute_overlap subpixel_accuracy computation_parameters=[Save memory (but be slower)] image_output=[Fuse and display]");
saveAs(imtype, output_dirName);
text_from = substring(input_dirName,1,indexOf(input_dirName, "]"));
}
else{ 
text_to = substring(input_dirName,1,indexOf(input_dirName, "]"));
File.copy(text_from + "\\TileConfiguration.registered.txt", text_to + "\\TileConfiguration.registered.txt");
run("Grid/Collection stitching", "type=[Positions from file] order=[Defined by TileConfiguration] directory=" + input_dirName + "layout_file=TileConfiguration.registered.txt fusion_method=[Max. Intensity] regression_threshold=0.30 max/avg_displacement_threshold=2.50 absolute_displacement_threshold=3.50 subpixel_accuracy computation_parameters=[Save memory (but be slower)] image_output=[Fuse and display]");
saveAs(imtype, output_dirName);
}
}

