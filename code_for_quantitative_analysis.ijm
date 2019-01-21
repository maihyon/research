//Get time-ID
getDateAndTime(year, month, dayOfWeek, dayOfMonth, hour, minute, second, msec);
timeID = ""+year+""+month+1+""+dayOfMonth+""+IJ.pad(hour,2)+IJ.pad(minute,2)+IJ.pad(second,2);

//Select folder
showMessage("Select Open Folder");
openDir = getDirectory("Choose a Directory");
showMessage("Select Save Folder");
saveDir = getDirectory("Choose a Directory");
showMessage("Select Save Folder For Substracted Image");
savesubDir = getDirectory("Choose a Directory");
showMessage("Select Save Folder For CSV Files");
savecsvDir = getDirectory("Choose a Directory");
list = getFileList(openDir);

for (i=0; i<list.length;i++){
	operation();
};
print("Macro Finished");

//Define operations
function operation(){

	open(openDir+list[i]);
	
	name = getTitle;
	dotIndex = indexOf(name, ".");
	title = substring(name, 0, dotIndex);
	
	run("Split Channels");
	selectWindow(name+" (green)");
	close();
	imageCalculator("Subtract create", name+" (blue)", name+" (red)");
	//selectWindow("Result of L M1 1-1-1.tif (blue)");

	newsubname = title+"sub"+".tiff";
	rename(newsubname);
	saveAs("Tiff", saveDir+newsubname);
	
	selectWindow(name+" (blue)");
	close();
	selectWindow(name+" (red)");
	close();

	selectWindow(newsubname);

	setThreshold(25, 255);
	run("Set Measurements...", "area redirect=None decimal=3");
	run("Measure");
	run("Set Measurements...", "area limit redirect=None decimal=3");
	run("Measure");
	newcsvname = title+"out"+".csv";
	//Table.rename("Results", newcsvname);
	saveAs("Results", savecsvDir+newcsvname);
	run("Clear Results");

	setThreshold(25, 255);
	run("Threshold...");
	run("Convert to Mask");
	newthrename = title+"thre"+".tiff";
	rename(newthrename);
	saveAs("Tiff", saveDir+newthrename);
	close();

	}

	