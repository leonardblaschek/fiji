//extract profiles from line ROIs
macro "get line profile [n4]" {
  run("Clear Results");
  a=getTitle();
  roiManager("Save", "/home/leonard/Documents/Uni/Phloroglucinol/19-05_CML_measurements/rois/"+a+"_roi.zip");
  for (m = 0; m < roiManager("count"); m++){
        roiManager("Select", m);
        profile = 0;
        profile = getProfile();
        for (i = 0; i < profile.length; i++){
            setResult("Roi_"+m, i, profile[i]);
        }
  }
}
