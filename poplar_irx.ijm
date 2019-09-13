//measure shape descriptors of traced vessel cell walls
macro "Measure poplar IRX [n8]" {
    run("Set Scale...", "distance=5.9 known=1 pixel=1 unit=µm");
    run("Set Measurements...", "mean centroid area perimeter bounding fit shape feret's redirect=None decimal=3");
    roiManager("Remove Slice Info");
    roiManager("Measure");
    a=getTitle();
    saveAs("tiff", "/home/leonard/Documents/Uni/PhD/IRX/Poplar/rotated_heatmaps/"+a+"_rotated_heatmap.tiff");
    roiManager("Save", "/home/leonard/Documents/Uni/PhD/IRX/Poplar/rois/"+a+"_rotated_roi.zip");
}
