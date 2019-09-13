// the used LUT is available from https://github.com/leonardblaschek 
// open stained and unstained image
macro "make heatmap [n3]" {
    a=getTitle();
    b=getDirectory("image");
    run("Images to Stack", "name=Stack title=[] use");
    run("Linear Stack Alignment with SIFT", "initial_gaussian_blur=1.60 steps_per_scale_octave=3 minimum_image_size=64 maximum_image_size=1024 feature_descriptor_size=4 feature_descriptor_orientation_bins=8 closest/next_closest_ratio=0.92 maximal_alignment_error=25 inlier_ratio=0.05 expected_transformation=Rigid interpolate");
    selectWindow("Stack");
    close();
    run("8-bit");
    run("Stack to Images");
    selectWindow("Aligned-0001");
    run("Macro...", "  code=[v = 255*((log(255/v))/log(10))]");
    selectWindow("Aligned-0002");
    run("Macro...", "  code=[v = 255*((log(255/v))/log(10))]");
    imageCalculator("Subtract create", "Aligned-0001","Aligned-0002");
    selectWindow("Result of Aligned-0001");
    run("fire_lut_0-150");
}
