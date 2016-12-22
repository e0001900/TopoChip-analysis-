//Used for cropping from L1 to L3 (each layer 33*33 images are saved)
//Modified by Yang
//Date 05 May 2016
//Used for SunM 66*66 chips
//Will have to run the code 4 times to complete the full analysis, each
//test will generate a folder containing the cropped images

//Define the initial area at the left upper corner
x1=4765;//upper left
y1=1440;//upper left
x2=34470;//upper right
y2=1440;//upper right
x3=4765;//lower left
y3=31145;//lower left
Length=600; //length of the cropping square (length=600 at least)
imtype="png"; //png, tif, etc
//setBatchMode(true); //Comment out this line if speed is not needed (20x faster without displaying images)
dir = getDirectory("Choose a folder for the output folder");
output = dir + "Cropped" + File.separator;
File.makeDirectory(output);



//How to find the right coordinates?
//Also need to find the left lower and right upper corner
//makeRectangle(4773, 1446, 455, 450);upper left
//makeRectangle(34543, 1446, 460, 457);upper right
//makeRectangle(4708, 31151, 460, 460);lower left
//Defind the horizontal and vertical distance between adjacent well
//delta1 is horizontal distance
//delta2 is vertical distance
deltax1=(x2-x1)/65; //upper right - upper left
deltax2=(x3-x1)/65;   //lower left - upper left
deltay1=(y2-y1)/65; //upper right - upper left
deltay2=(y3-y1)/65; //lower left - upper left

//Num1 is used to be converted into alphabet
//Num2 is used as counter
Num1=0;
Num2=1;


for (i=0;i<66;i++)
	{
		m=x1+(i*deltax1);
		n=y1+(i*deltay1);
		Num2=1;
		Num1=Num1+1;
        if (Num1<10)
        {
			c='0'+Num1;
        }
			else
		{
			c=toString(Num1);
        }
		for (j=0;j<66;j++)
		{
            //define the image
			selectWindow("1."+imtype);
            //define the length by visualization
			makeRectangle(m, n, Length, Length);
            //makeRectangle(x, y, width, height)
            //Creates a rectangular selection. The x and y arguments are
            //the coordinates (in pixels) of the upper left corner of the
            //selection. The origin (0,0) of the coordinate system is the
            //upper left corner of the image.
			roiManager("Add");
            //Define number as 01 02 03...10 11 12...
			if (Num2<10)
			{
				Figname1='0'+Num2+c;
			}
			else 
			{	
				Figname1=toString(Num2)+c;	
			}
			//Figname1="c1";
			//run("Duplicate...",  "title="+Figname1+".imtype duplicate channels=1-5 slices=1-16");
			run("Duplicate...","title="+Figname1+"."+imtype);
            //define the saving path
            
            //run("Save", saveAs=in_folder+"/"+Figname1+".png");
			in_folder=output+"\\";
			mydir=in_folder+Figname1;
			//File.makeDirectory(mydir);
			selectWindow(Figname1+"."+imtype);
			saveAs(imtype, in_folder+Figname1);
			close();

			//selectWindow(Figname1+".png");
			//run("Stack to Images");
            //run("Set Measurements...", "integrated redirect=None decimal=3");

            //defind the channel and threshold
			//selectWindow(Figname1+"-0001");
			//rename("Nucleus");
			//setThreshold(20, 445650.5234);
			//run("Analyze Particles...", "size=200-Infinity circularity=0.00-1.00 show=Nothing include summarize");

			//selectWindow(Figname1+"-0002");
			//rename("Albumin");
			//setThreshold(0, 445650.5234);
			//run("Analyze Particles...", "size=200-Infinity circularity=0.00-1.00 show=Nothing include summarize");
			//selectWindow(Figname1+"-0003");
			//rename("CK19");
			//setThreshold(20, 445650.5234);
			//run("Analyze Particles...", "size=200-Infinity circularity=0.00-1.00 show=Nothing include summarize");

			//selectWindow(Figname1+"-0004");
			//rename("CYP3A4");
            //setThreshold(20, 445650.5234);
           // run("Analyze Particles...", "size=200-Infinity circularity=0.00-1.00 show=Nothing include summarize");

           // selectWindow(Figname1+"-0005");
           // rename("PH");

			//selectWindow("Nucleus");
			//saveAs("Tiff", in_folder+"/"+Figname1+"/Nucleus.tif");
			//selectWindow("Albumin");
			//saveAs("Tiff", in_folder+"/"+Figname1+"/Albumin.tif");
			//selectWindow("CK19");
            //saveAs("Tiff", in_folder+"/"+Figname1+"/CK19.tif");
           // selectWindow("CYP3A4");
            //saveAs("Tiff", in_folder+"/"+Figname1+"/CYP3A4.tif");
			//selectWindow("PH");
			//saveAs("Tiff", in_folder+"/"+Figname1+"/PH.tif");
			//close("PH.tif");
          //  close("CYP3A4.tif");
			//close("CK19.tif");
			//close("Albumin.tif");
			//close("Nucleus.tif");

			m=m+deltax2;
			n=n+deltay2;
			Num2++;
			print(Figname1);
		}	
	}
