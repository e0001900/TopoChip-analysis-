//Used for cropping from L1 to L3 (each layer 33*33 images are saved)
//Modified by Yang
//Date 05 May 2016
//Used for SunM 66*66 chips
//Need to manually rotate the images to make the blank to the upper right corner!!!!!!!!!!!!!
//Define the initial area at the left upper corner
x1=4515;//upper left
y1=1494;//upper left
x2=34267;//upper right
y2=1176;//upper right
x3=4780;//lower left
y3=31205;//lower left
Length=652; //length of the cropping square (length=600 at least)
Width=664;//width, can bedifferent as length
imtype="tif"; //png, tif, etc
setBatchMode(true); //Comment out this line if speed is not needed (20x faster without displaying images)
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
deltax1=round((x2-x1)/65); //upper right - upper left
deltax2=round((x3-x1)/65);   //lower left - upper left
deltay1=round((y2-y1)/65); //upper right - upper left
deltay2=round((y3-y1)/65); //lower left - upper left

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
			selectWindow("Stack."+imtype);
            //define the length by visualization
			makeOval(m, n, Length, Width);
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
			run("Duplicate...", "duplicate");
			//run("Duplicate...","title="+Figname1+"."+imtype);
            //define the saving path
            
            //run("Save", saveAs=in_folder+"/"+Figname1+".png");
			in_folder=output+"\\";
			mydir=in_folder+Figname1;
			//File.makeDirectory(mydir);
			//selectWindow(Figname1+"."+imtype);
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

rotH = atan(deltay1/deltax1)/PI*180;
print("rotH to return for CropFine " + round(rotH));