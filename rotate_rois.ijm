//this macro is a utility script to rotate already creates ROIs together with the image
macro "rotate to 0 [n7]" {
    run("Set Scale...", "distance=5.9 known=1 pixel=1 unit=µm");
    run("Set Measurements...", "area centroid center perimeter bounding fit shape feret's redirect=None decimal=3");
    run("Measure");
    offset_angle = getResult("Angle");
    roiManager("Select", 0);
    run("Rotate...", "rotate angle=offset_angle");
    roiManager("Add");
    roiManager("Select", 0);
    roiManager("Delete");
    run("Select All");
    run("Rotate... ", "angle=offset_angle grid=1 interpolation=Bilinear");
    run("Clear Results");
    close("Results");
    roiManager("Show All with labels");
}

macro "List XY Coordinates [n8]" {
    run("Set Scale...", "distance=5.9 known=1 pixel=1 unit=µm");
    run("Set Measurements...", "centroid area perimeter bounding fit shape feret's redirect=None decimal=3");
    roiManager("Select", 0);
    roiManager("Add");
    roiManager("Select", 0);
    roiManager("Delete");
    a=getTitle();
    roiManager("Save", "/home/leonard/Documents/Uni/PhD/IRX/RAMAN/rois/"+a+"rotated_roi.zip");
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
