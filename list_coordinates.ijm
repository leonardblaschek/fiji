// create a line that is parallel to the cambium (orthogonal to the direction of growth)
macro "rotate to 0 [n7]" {
    run("Set Scale...", "distance=5.9 known=1 pixel=1 unit=µm");
    run("Set Measurements...", "area centroid center perimeter bounding fit shape feret's redirect=None decimal=3");
    run("Measure");
    offset_angle = getResult("Angle");
    run("Select All");
    run("Rotate... ", "angle=offset_angle grid=1 interpolation=Bilinear enlarge");
    run("Clear Results");
    close("Results");
    roiManager("Show All with labels");
}
//create a horizontal line ROI at the cambium, then create the vessel trace ROIs
macro "List XY Coordinates [n8]" {
    run("Set Scale...", "distance=5.9 known=1 pixel=1 unit=µm");
    run("Set Measurements...", "area perimeter bounding fit shape feret's redirect=None decimal=3");
    a=getTitle();
    roiManager("Save", "/home/leonard/Documents/Uni/PhD/IRX/RAMAN/rois/"+a+"_roi.zip");
    for (m = 0; m < roiManager("count"); m++){
        roiManager("Select", m);
        run("Measure");
        getSelectionCoordinates(x, y);
        for (i=0; i<x.length; i++){
            setResult("ROIx"+i, m, x[i]);
            setResult("ROIy"+i, m, y[i]);
        }
    }
}
