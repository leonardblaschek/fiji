//open stained and unstained image
macro "warped heatmap [n3]" {
    //store image metadata
    a=getTitle();
    b=getDirectory("image");
    //make a first, "rigid" alignment 
    run("Images to Stack", "name=Stack title=[] use");
    run("Linear Stack Alignment with SIFT", "initial_gaussian_blur=1.60 steps_per_scale_octave=3 minimum_image_size=64 maximum_image_size=1024 feature_descriptor_size=4 feature_descriptor_orientation_bins=8 closest/next_closest_ratio=0.92 maximal_alignment_error=25 inlier_ratio=0.05 expected_transformation=Rigid interpolate");
    selectWindow("Stack");
    close();
    //select the area of interest. Avoid black background resulting from the first alignment, rotate the image if necessary
    waitForUser("Cropping", "Select rectangular area of interest.");
    run("Crop");
    run("Stack to Images");
    //extract SIFT features; parameters tweaked to a) detect more features and b) allow less initial alignment error to restrict the warping to small adjustments < 10 pixels
    run("Extract SIFT Correspondences", "source_image=Aligned-0002 target_image=Aligned-0001 initial_gaussian_blur=1.40 steps_per_scale_octave=5 minimum_image_size=32 maximum_image_size=1024 feature_descriptor_size=8 feature_descriptor_orientation_bins=8 closest/next_closest_ratio=0.92 filter maximal_alignment_error=10 minimal_inlier_ratio=0.05 minimal_number_of_inliers=7 expected_transformation=Similarity");
    //close superfluous images
    run("bUnwarpJ", "source_image=Aligned-0002 target_image=Aligned-0001 registration=Accurate image_subsample_factor=0 initial_deformation=[Very Coarse] final_deformation=[Fine] divergence_weight=0 curl_weight=0 landmark_weight=0 image_weight=1 consistency_weight=10 stop_threshold=0.01");
    selectWindow("Aligned-0001");
    close();
    selectWindow("Aligned-0002");
    close();
    selectWindow("Registered Source Image");
    close();
    selectWindow("Registered Target Image");
    run("Stack to Images");
    selectWindow("Warped Source Mask");
    close();
    //duplicate warping results for later and create heatmap from the originals
    selectWindow("Target Image");
    run("Duplicate...", "title=warped_1");
    selectWindow("Target Image");
    run("8-bit");
    run("Macro...", "  code=[v = 255*((log(255/v))/log(10))]");
    selectWindow("Registered Target Image");
    run("Duplicate...", "title=warped_2");
    selectWindow("Registered Target Image");
    run("8-bit");
    run("Macro...", "  code=[v = 255*((log(255/v))/log(10))]");
    imageCalculator("Subtract create", "Registered Target Image","Target Image");
    selectWindow("Registered Target Image");
    close();
    selectWindow("Target Image");
    close();
    selectWindow("Result of Registered Target Image");
    //apply custom LUT
    run("fire_lut_0-150");
    run("Images to Stack", "name=Stack title=[] use");
    rename(a);
    roiManager("Show All with labels");
    //save result
    saveAs("tiff", "/home/leonard/Documents/Uni/Phloroglucinol/19-05-31_warped_images/"+a+"_warped.tiff");
    //run("Close All");
}
