# Fluorescence-Flatfield-Correction
ImageJ/FIJI macro for automated flat-field correction for fluorescence microscopy images,
timeseries, and stacks. Effectively a high-pass spatial filter that works better for 
abnormal backgrounds shapes compared to something like a rolling ball filter. 

--------------------------
Automated Flatfield Correction Macro

Post-hoc flatfield correction for fluorescence microscopy images. 
Effectively a lowpass filter. Blurs image with a large gaussian kernel,
subtracts blurred image from starting image, adding back the mean 
of the blurred image to re-establish baseline/bkgd fluorescence. 

Intended to be applied to static images, timeseries images, and z-stacks. 
Not intented for application to multiple color channels. 
run("Subtract Background...") works better for that. 

Generates new image/stack based on most recent selected image/stack.

Copy and paste .ijm file into your 'Macros' folder in your FIJI/ImJ
install folder. Open in the macro editor and run, or just load
macro and run from the plugins menu. 

Written by Wilson Adams, Vanderbilt Biophotonics Center, July 2019
