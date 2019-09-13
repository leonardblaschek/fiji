///////////////////////
// open stained and unstained image
///////////////////////
macro "OD_hue_part1 [n0]" {
    run("Images to Stack", "name=Stack title=[] use");
    run("Linear Stack Alignment with SIFT", "initial_gaussian_blur=1.60 steps_per_scale_octave=3 minimum_image_size=64 maximum_image_size=1024 feature_descriptor_size=4 feature_descriptor_orientation_bins=8 closest/next_closest_ratio=0.92 maximal_alignment_error=25 inlier_ratio=0.05 expected_transformation=Rigid interpolate");
    rename("Aligned_OD");
    roiManager("Show All with labels")
}
///////////////////////
// before starting the second part of the macro, create the ROIs you want to measure
// if measuring poplar, make the first ROI a reference line along the cambium, and set 'Analyze -> Set Measurements...' to include centroid
///////////////////////
macro "OD_hue_part2 [n1]" {
    run("Select None");
    selectWindow("Aligned_OD");
    run("Duplicate...", "duplicate");
    rename("Aligned_hue");
    //selectWindow("Stack");
    //close();
    selectWindow("Aligned_OD");
    run("8-bit");
    run("Calibrate...", "function=[Uncalibrated OD] unit=[Gray Value] text1= text2=");
    roiManager("multi-measure measure_all");
    //selectWindow("Aligned_OD");
    //close();
    selectWindow("Aligned_hue");
    run("HSB Stack");
    selectWindow("Aligned_hue");
    run("Reduce Dimensionality...", "slices");
    selectWindow("Aligned_hue");
    run("Macro...", "  code=[if (v<128) {v=v+128;} else {v=v-128;}] stack");
    selectWindow("Aligned_hue");
    roiManager("multi-measure measure_all append");
    //selectWindow("Aligned_hue");
    //close();
    run("Close All");
}
