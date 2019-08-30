// Automated Flatfield Correction Macro

// Post-hoc flatfield correction for fluorescence microscopy images. 
// Effectively a lowpass filter. Blurs image with a large gaussian kernel,
// 		subtracts blurred image from starting image, adding back the mean 
// 		of the blurred image to re-establish baseline/bkgd fluorescence. 

// Intended to be applied to static images, timeseries images, and z-stacks. 
// 		Not intented for application to multiple color channels. 
//		run("Subtract Background...") works better for that. 

// Generates new image/stack based on most recent selected image/stack.

// Copy and paste .ijm file into your 'Macros' folder in your FIJI/ImJ
// 		install folder. Open in the macro editor and run, or just load
// 		macro and run from the plugins menu. 

// Written by Wilson Adams, Vanderbilt Biophotonics Center, July 2019

start = getTitle()
getDimensions(width, height, channels, slices, frames); //print(height); print(width)
getVoxelSize(vwidth, vheight, vdepth, vunit)
blur= floor(width*0.08);

Dialog.create("Set Blur Kernel")
Dialog.addMessage("Enter Blur Kernel Size")
Dialog.addNumber("Blur Kernel (px) = ", blur)
Dialog.show()
blur = Dialog.getNumber()

if (frames>1) {		// For time series where the flat field is relatively stable
	run("Z Project...", "stop=5 projection=[Average Intensity]");
	avgBkgd = getTitle();
	run("Gaussian Blur...", "sigma=&blur");
	getStatistics(area, mean, min, max, std, histogram);
	mean = floor(mean);
	run("Calculator Plus","i1=&start i2=&avgBkgd operation=[Subtract: i2 = (i1-i2) x k1 + k2] k1=1 k2=&mean create");
	rename(start+"_bkgdSub");
	stk_bkgd = getTitle();
}
if (slices>1) {		// for z stacks where each image may have a different Flat field
	run("Duplicate...", "duplicate");
	avgBkgd = getTitle();
	run("Gaussian Blur...", "sigma=&blur stack");
	getStatistics(area, mean, min, max, std, histogram);
	mean = floor(mean);
	run("Calculator Plus","i1=&start i2=&avgBkgd operation=[Subtract: i2 = (i1-i2) x k1 + k2] k1=1 k2=&mean create");
	rename(start+"_bkgdSub");
	stk_bkgd = getTitle();
}
else {			// Single images
	run("Duplicate...", start+"_bkgdsub");
	avgBkgd = getTitle();
	run("Gaussian Blur...", "sigma=&blur");
	getStatistics(area, mean, min, max, std, histogram);
	mean = floor(mean);
	run("Calculator Plus","i1=&start i2=&avgBkgd operation=[Subtract: i2 = (i1-i2) x k1 + k2] k1=1 k2=&mean create");
	rename(start+"_bkgdSub");
	stk_bkgd = getTitle();
}
close(avgBkgd);
selectWindow(stk_bkgd);
setVoxelSize(vwidth, vheight, vdepth, vunit);
