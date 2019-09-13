//measure the average intensity of outline pixels
macro "Measure outline pixel value [n9]" {
    run("Set Scale...", "distance=5.9 known=1 pixel=1 unit=µm");
    run("Set Measurements...", "mean centroid area perimeter bounding fit shape feret's redirect=None decimal=3");
    roiManager("Remove Slice Info");
    a=getTitle();
    str = split(a, ".");
    str = str[0]+"_roi-";
    n = roiManager("count");
    roiManager("Show All");
    for ( i=0; i<n; i++ ) { 
	roiManager("select", i);
	outline2results(str+(i+1));
    }
    //roiManager("Measure");
    //saveAs("tiff", "/home/leonard/Documents/Uni/PhD/IRX/Poplar/rotated_heatmaps/"+a+"_rotated_heatmap.tiff");
    //roiManager("Save", "/home/leonard/Documents/Uni/PhD/IRX/Poplar/rois/"+a+"_rotated_roi.zip");
    //
    function outline2results(lbl) {
	Roi.getCoordinates(x, y);
	n = x.length;
	sum = 0;
	for (i=0; i<n; i++) sum += getValue(x[i], y[i]);
	setResult("Mean", nResults, sum/n );
    }
}
