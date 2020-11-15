// "IRX measurements with pixel by pixel Wiesnber absorbance"
macro "rotate to 0 [n7]" {
//     run("Set Scale...", "distance=5.9 known=1 pixel=1 unit=µm");
  a = getTitle();
  run("Set Measurements...", "area centroid center perimeter bounding fit shape feret's redirect=None decimal=3");
  run("Measure");
  offset_angle = getResult("Angle");
  //close(a);
  //rename(a);
  //selectWindow(a);
  run("Rotate... ", "angle=offset_angle grid=1 interpolation=Bilinear enlarge stack");
  run("Clear Results");
  close("Results");
  roiManager("Show All with labels");
}

macro "List XY Coordinates [n8]" {
    //run("Set Measurements...", "area perimeter bounding fit shape feret's redirect=None decimal=3");
    firstTE = getNumber("Enter number of the first measured TE", 1) - 1;
    missingTE = getNumber("Enter number of any missing measurements", 999) - firstTE;
    a = getTitle();
    saveAs("tiff", "/home/leonard/Documents/"+a+"_rotated.tiff");
    roiManager("Save", "/home/leonard/Documents/"+a+"_roi.zip");
    run("8-bit");
    run("Calibrate...", "function=[Uncalibrated OD] unit=[Gray Value] text1= text2=");
    run("Set Scale...", "distance=5.9 known=1 pixel=1 unit=µm");
    for (m = 0; m < roiManager("count"); m++){
        if (m == missingTE) { // skip the missing TE in the numbering
          firstTE = firstTE + 1;
        }
        roiManager("Select", m);
        area = getValue("Area");
        X = getValue("X");
        Y = getValue("Y");
        perim = getValue("Perim.");
        width = getValue("Width");
        height = getValue("Height");
        major = getValue("Major");
        minor = getValue("Minor");
        angle = getValue("Angle");
        circ = getValue("Circ.");
        roundness = getValue("Round");
        solidity = getValue("Solidity");
        length = getValue("Length");
        getSelectionCoordinates(x, y);
        for (i=0; i<x.length; i++){
          nrow = nResults;
          setResult("Area", nrow, area);
          setResult("X", nrow, X);
          setResult("Y", nrow, Y);
          setResult("Perim.", nrow, perim);
          setResult("Width", nrow, width);
          setResult("Height", nrow, height);
          setResult("Major", nrow, major);
          setResult("Minor", nrow, minor);
          setResult("Angle", nrow, angle);
          setResult("Circ.", nrow, circ);
          setResult("Round", nrow, roundness);
          setResult("Solidity", nrow, solidity);
          setResult("Length", nrow, length);
          setResult("image", nrow, a);
          if (m == 0) { // the first ROI is always 0 to identify the cambium reference line
            setResult("ROI", nrow, m);
          } else {
            setResult("ROI", nrow, m + firstTE);
          }
          setResult("point", nrow, i);
          setResult("x", nrow, x[i]);
          setResult("y", nrow, y[i]);
          setSlice(1);
          setResult("value_stained", nrow, getPixel(x[i], y[i]));
          setSlice(2);
          setResult("value_unstained", nrow, getPixel(x[i], y[i]));
          updateResults();
        }
    }
}
