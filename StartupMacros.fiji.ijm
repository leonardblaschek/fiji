// "StartupMacros"
// The macros and macro tools in this file ("StartupMacros.txt") are
// automatically installed in the Plugins>Macros submenu and
//  in the tool bar when ImageJ starts up.

//  About the drawing tools.
//
//  This is a set of drawing tools similar to the pencil, paintbrush,
//  eraser and flood fill (paint bucket) tools in NIH Image. The
//  pencil and paintbrush draw in the current foreground color
//  and the eraser draws in the current background color. The
//  flood fill tool fills the selected area using the foreground color.
//  Hold down the alt key to have the pencil and paintbrush draw
//  using the background color or to have the flood fill tool fill
//  using the background color. Set the foreground and background
//  colors by double-clicking on the flood fill tool or on the eye
//  dropper tool.  Double-click on the pencil, paintbrush or eraser
//  tool  to set the drawing width for that tool.
//
// Icons contributed by Tony Collins.

// Global variables
var pencilWidth=1,  eraserWidth=10, leftClick=16, alt=8;
var brushWidth = 10; //call("ij.Prefs.get", "startup.brush", "10");
var floodType =  "8-connected"; //call("ij.Prefs.get", "startup.flood", "8-connected");

// The macro named "AutoRunAndHide" runs when ImageJ starts
// and the file containing it is not displayed when ImageJ opens it.

// macro "AutoRunAndHide" {}

function UseHEFT {
    requires("1.38f");
    state = call("ij.io.Opener.getOpenUsingPlugins");
    if (state=="false") {
        setOption("OpenUsingPlugins", true);
        showStatus("TRUE (images opened by HandleExtraFileTypes)");
    } else {
        setOption("OpenUsingPlugins", false);
        showStatus("FALSE (images opened by ImageJ)");
    }
}

UseHEFT();

// The macro named "AutoRun" runs when ImageJ starts.

macro "AutoRun" {
    // run all the .ijm scripts provided in macros/AutoRun/
    autoRunDirectory = getDirectory("imagej") + "/macros/AutoRun/";
    if (File.isDirectory(autoRunDirectory)) {
        list = getFileList(autoRunDirectory);
        // make sure startup order is consistent
        Array.sort(list);
        for (i = 0; i < list.length; i++) {
            if (endsWith(list[i], ".ijm")) {
                runMacro(autoRunDirectory + list[i]);
            }
        }
    }
}

var pmCmds = newMenu("Popup Menu",
                     newArray("Help...", "Rename...", "Duplicate...", "Original Scale",
                              "Paste Control...", "-", "Record...", "Capture Screen ", "Monitor Memory...",
                              "Find Commands...", "Control Panel...", "Startup Macros...", "Search..."));

macro "Popup Menu" {
    cmd = getArgument();
    if (cmd=="Help...")
        showMessage("About Popup Menu",
                    "To customize this menu, edit the line that starts with\n\"var pmCmds\" in ImageJ/macros/StartupMacros.txt.");
        else
            run(cmd);
}

macro "Abort Macro or Plugin (or press Esc key) Action Tool - CbooP51b1f5fbbf5f1b15510T5c10X" {
    setKeyDown("Esc");
}

var xx = requires138b(); // check version at install
function requires138b() {requires("1.38b"); return 0; }

var dCmds = newMenu("Developer Menu Tool",
                    newArray("ImageJ Website","News", "Documentation", "ImageJ Wiki", "Resources", "Macro Language", "Macros",
                             "Macro Functions", "Startup Macros...", "Plugins", "Source Code", "Mailing List Archives", "-", "Record...",
                             "Capture Screen ", "Monitor Memory...", "List Commands...", "Control Panel...", "Search...", "Debug Mode"));

macro "Developer Menu Tool - C037T0b11DT7b09eTcb09v" {
    cmd = getArgument();
    if (cmd=="ImageJ Website")
        run("URL...", "url=http://rsbweb.nih.gov/ij/");
    else if (cmd=="News")
        run("URL...", "url=http://rsbweb.nih.gov/ij/notes.html");
    else if (cmd=="Documentation")
        run("URL...", "url=http://rsbweb.nih.gov/ij/docs/");
    else if (cmd=="ImageJ Wiki")
        run("URL...", "url=http://imagejdocu.tudor.lu/imagej-documentation-wiki/");
    else if (cmd=="Resources")
        run("URL...", "url=http://rsbweb.nih.gov/ij/developer/");
    else if (cmd=="Macro Language")
        run("URL...", "url=http://rsbweb.nih.gov/ij/developer/macro/macros.html");
    else if (cmd=="Macros")
        run("URL...", "url=http://rsbweb.nih.gov/ij/macros/");
    else if (cmd=="Macro Functions")
        run("URL...", "url=http://rsbweb.nih.gov/ij/developer/macro/functions.html");
    else if (cmd=="Plugins")
        run("URL...", "url=http://rsbweb.nih.gov/ij/plugins/");
    else if (cmd=="Source Code")
        run("URL...", "url=http://rsbweb.nih.gov/ij/developer/source/");
    else if (cmd=="Mailing List Archives")
        run("URL...", "url=https://list.nih.gov/archives/imagej.html");
    else if (cmd=="Debug Mode")
        setOption("DebugMode", true);
    else if (cmd!="-")
        run(cmd);
}

var sCmds = newMenu("Stacks Menu Tool",
                    newArray("Add Slice", "Delete Slice", "Next Slice [>]", "Previous Slice [<]", "Set Slice...", "-",
                             "Convert Images to Stack", "Convert Stack to Images", "Make Montage...", "Reslice [/]...", "Z Project...",
                             "3D Project...", "Plot Z-axis Profile", "-", "Start Animation", "Stop Animation", "Animation Options...",
                             "-", "MRI Stack (528K)"));
macro "Stacks Menu Tool - C037T0b11ST8b09tTcb09k" {
    cmd = getArgument();
    if (cmd!="-") run(cmd);
}

var luts = getLutMenu();
var lCmds = newMenu("LUT Menu Tool", luts);
macro "LUT Menu Tool - C037T0b11LT6b09UTcb09T" {
    cmd = getArgument();
    if (cmd!="-") run(cmd);
}
function getLutMenu() {
    list = getLutList();
    menu = newArray(16+list.length);
    menu[0] = "Invert LUT"; menu[1] = "Apply LUT"; menu[2] = "-";
    menu[3] = "Fire"; menu[4] = "Grays"; menu[5] = "Ice";
    menu[6] = "Spectrum"; menu[7] = "3-3-2 RGB"; menu[8] = "Red";
    menu[9] = "Green"; menu[10] = "Blue"; menu[11] = "Cyan";
    menu[12] = "Magenta"; menu[13] = "Yellow"; menu[14] = "Red/Green";
    menu[15] = "-";
    for (i=0; i<list.length; i++)
        menu[i+16] = list[i];
    return menu;
}

function getLutList() {
    lutdir = getDirectory("luts");
    list = newArray("No LUTs in /ImageJ/luts");
    if (!File.exists(lutdir))
        return list;
    rawlist = getFileList(lutdir);
    if (rawlist.length==0)
        return list;
    count = 0;
    for (i=0; i< rawlist.length; i++)
        if (endsWith(rawlist[i], ".lut")) count++;
        if (count==0)
            return list;
        list = newArray(count);
    index = 0;
    for (i=0; i< rawlist.length; i++) {
        if (endsWith(rawlist[i], ".lut"))
            list[index++] = substring(rawlist[i], 0, lengthOf(rawlist[i])-4);
    }
    return list;
}

macro "Pencil Tool - C037L494fL4990L90b0Lc1c3L82a4Lb58bL7c4fDb4L5a5dL6b6cD7b" {
    getCursorLoc(x, y, z, flags);
    if (flags&alt!=0)
        setColorToBackgound();
    draw(pencilWidth);
}

macro "Paintbrush Tool - C037La077Ld098L6859L4a2fL2f4fL3f99L5e9bL9b98L6888L5e8dL888c" {
    getCursorLoc(x, y, z, flags);
    if (flags&alt!=0)
        setColorToBackgound();
    draw(brushWidth);
}

macro "Flood Fill Tool -C037B21P085373b75d0L4d1aL3135L4050L6166D57D77D68La5adLb6bcD09D94" {
    requires("1.34j");
    setupUndo();
    getCursorLoc(x, y, z, flags);
    if (flags&alt!=0) setColorToBackgound();
    floodFill(x, y, floodType);
}

function draw(width) {
    requires("1.32g");
    setupUndo();
    getCursorLoc(x, y, z, flags);
    setLineWidth(width);
    moveTo(x,y);
    x2=-1; y2=-1;
    while (true) {
        getCursorLoc(x, y, z, flags);
        if (flags&leftClick==0) exit();
        if (x!=x2 || y!=y2)
            lineTo(x,y);
        x2=x; y2 =y;
        wait(10);
    }
}

function setColorToBackgound() {
    savep = getPixel(0, 0);
    makeRectangle(0, 0, 1, 1);
    run("Clear");
    background = getPixel(0, 0);
    run("Select None");
    setPixel(0, 0, savep);
    setColor(background);
}

// Runs when the user double-clicks on the pencil tool icon
macro 'Pencil Tool Options...' {
    pencilWidth = getNumber("Pencil Width (pixels):", pencilWidth);
}

// Runs when the user double-clicks on the paint brush tool icon
macro 'Paintbrush Tool Options...' {
    brushWidth = getNumber("Brush Width (pixels):", brushWidth);
    call("ij.Prefs.set", "startup.brush", brushWidth);
}

// Runs when the user double-clicks on the flood fill tool icon
macro 'Flood Fill Tool Options...' {
    Dialog.create("Flood Fill Tool");
    Dialog.addChoice("Flood Type:", newArray("4-connected", "8-connected"), floodType);
    Dialog.show();
    floodType = Dialog.getChoice();
    call("ij.Prefs.set", "startup.flood", floodType);
}

macro "Set Drawing Color..."{
    run("Color Picker...");
}

macro "-" {} //menu divider

macro "About Startup Macros..." {
    title = "About Startup Macros";
    text = "Macros, such as this one, contained in a file named\n"
    + "'StartupMacros.txt', located in the 'macros' folder inside the\n"
    + "Fiji folder, are automatically installed in the Plugins>Macros\n"
    + "menu when Fiji starts.\n"
    + "\n"
    + "More information is available at:\n"
    + "<http://imagej.nih.gov/ij/developer/macro/macros.html>";
    dummy = call("fiji.FijiTools.openEditor", title, text);
}

macro "Save As JPEG..." {
    quality = call("ij.plugin.JpegWriter.getQuality");
    quality = getNumber("JPEG quality (0-100):", quality);
    run("Input/Output...", "jpeg="+quality);
    saveAs("Jpeg");
}

macro "Save Inverted FITS" {
    run("Flip Vertically");
    run("FITS...", "");
    run("Flip Vertically");
}

macro "measure poplar" {
    run("Set Scale...", "distance=5.9 known=1 pixel=1 unit=µm");
    run("Set Measurements...", "centroid mean redirect=None decimal=3");
        getSelectionCoordinates(x, y);
        for (i=0; i<x.length; i++){
            setResult("ROIx"+i, 0, x[i]);
            setResult("ROIy"+i, 0, y[i]);
        }
}

macro "OD_hue_part1" {
    run("Images to Stack", "name=Stack title=[] use");
    run("Linear Stack Alignment with SIFT", "initial_gaussian_blur=1.60 steps_per_scale_octave=3 minimum_image_size=64 maximum_image_size=1024 feature_descriptor_size=4 feature_descriptor_orientation_bins=8 closest/next_closest_ratio=0.92 maximal_alignment_error=25 inlier_ratio=0.05 expected_transformation=Rigid interpolate");
    rename("Aligned_OD");
    roiManager("Show All with labels")
}
macro "OD_hue_part2" {
    run("Set Measurements...", "centroid mean redirect=None decimal=3");
    run("Set Scale...", "distance=5.9 known=1 pixel=1 unit=µm");
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

macro "make heatmap" {
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
    rename(a);
    run("fire_lut_0-150");
    roiManager("Show All with labels");
    //saveAs("tiff", b+a+"_subtracted");
    //run("Close All");
}

macro "close all [n6]" {
        run("Close All");
        run("Clear Results");
        roiManager("Deselect");
        roiManager("Delete");
        
}

macro "hue_ratio" {
    run("Set Scale...", "distance=0 known=0 pixel=1 unit=pixel");
    run("Duplicate...", "title=duplicate.tif");
    run("Set Scale...", "distance=0 known=0 pixel=1 unit=pixel");
    run("Duplicate...", "title=duplicate2.tif");
    run("Set Scale...", "distance=0 known=0 pixel=1 unit=pixel");
    // Threshold Colour v1.12a------
    // Autogenerated macro, single images only!
    // G. Landini 27/Sep/2010.
    //
    min=newArray(3);
    max=newArray(3);
    filter=newArray(3);
    a=getTitle();
    run("HSB Stack");
    run("Stack to Images");
    selectWindow("Hue");
    rename("0");
    selectWindow("Saturation");
    rename("1");
    selectWindow("Brightness");
    rename("2");
    min[0]=10;
    max[0]=140;
    filter[0]="pass";
    min[1]=40;
    max[1]=255;
    filter[1]="pass";
    min[2]=50;
    max[2]=255;
    filter[2]="pass";
    for (i=0;i<3;i++){
        selectWindow(""+i);
        setThreshold(min[i], max[i]);
        run("Convert to Mask");
        if (filter[i]=="stop")  run("Invert");
    }
    imageCalculator("AND create", "0","1");
    imageCalculator("AND create", "Result of 0","2");
    for (i=0;i<3;i++){
        selectWindow(""+i);
        close();
    }
    selectWindow("Result of 0");
    close();
    selectWindow("Result of Result of 0");
    rename(a);
    // Threshold Colour ------------
    run("Create Selection"); 
    run("Measure");
    selectWindow("duplicate.tif");
    run("Set Scale...", "distance=0 known=0 pixel=1 unit=pixel");
    // Threshold Colour v1.12a------
    // Autogenerated macro, single images only!
    // G. Landini 27/Sep/2010.
    //
    min=newArray(3);
    max=newArray(3);
    filter=newArray(3);
    a=getTitle();
    run("HSB Stack");
    run("Convert Stack to Images");
    selectWindow("Hue");
    rename("0");
    selectWindow("Saturation");
    rename("1");
    selectWindow("Brightness");
    rename("2");
    min[0]=200;
    max[0]=226;
    filter[0]="pass";
    min[1]=40;
    max[1]=255;
    filter[1]="pass";
    min[2]=0;
    max[2]=255;
    filter[2]="pass";
    for (i=0;i<3;i++){
        selectWindow(""+i);
        setThreshold(min[i], max[i]);
        run("Convert to Mask");
        if (filter[i]=="stop")  run("Invert");
    }
    imageCalculator("AND create", "0","1");
    imageCalculator("AND create", "Result of 0","2");
    for (i=0;i<3;i++){
        selectWindow(""+i);
        close();
    }
    selectWindow("Result of 0");
    close();
    selectWindow("Result of Result of 0");
    rename(a);
    // Threshold Colour ------------
    run("Create Selection"); 
    run("Measure");
}

macro "pheno [q]" {
    // ---- Scale variable ----
    scale = 0.12;
    
    // ---- Loop to iterate function through a directory ----  
    dir1 = getDirectory("Choose Source Directory "); 
    dir2 = getDirectory("Choose Output Directory ");
    File.makeDirectory(dir2); 
    list = getFileList(dir1); 
    setBatchMode(false); 
    for (k = 0; k<list.length; k++) { 
        showProgress(k+1, list.length); 
        open(dir1+list[k]);
        
        // ---- Store image name ----    
        imgName=getTitle(); 
        
        // ---- Duplicate image, set original aside for later ----
        run("Enhance Contrast...", "saturated=0.1");
        run("Duplicate...", "title=x");
        selectWindow("x");
        rename(imgName+"_2");
        duplicate=getTitle();
        selectWindow(duplicate);
        
        // ---- Gaussian blur to smooth out outliers ----
        run("Gaussian Blur...", "sigma=3");
        
        // ---- Threshold colours to select plant from background ----
        min=newArray(3); 
        max=newArray(3); 
        filter=newArray(3); 
        run("HSB Stack"); 
        selectWindow(duplicate);
        run("Convert Stack to Images"); 
        selectWindow("Hue"); 
        rename("0"); 
        selectWindow("Saturation"); 
        rename("1"); 
        selectWindow("Brightness"); 
        rename("2"); 
        //Hue
        min[0]=25; 
        max[0]=140; 
        filter[0]="pass";
        //Saturation
        min[1]=0; 
        max[1]=255; 
        filter[1]="pass";
        //Brightness
        min[2]=25; 
        max[2]=255; 
        filter[2]="pass"; 
        for (i=0;i<3;i++){ 
            selectWindow(""+i); 
            setThreshold(min[i], max[i]); 
            run("Convert to Mask"); 
            if (filter[i]=="stop")  run("Invert"); 
        } 
        imageCalculator("AND create", "0","1"); 
        imageCalculator("AND create", "Result of 0","2"); 
        for (i=0;i<3;i++){ 
            selectWindow(""+i); 
            close(); 
        } 
        selectWindow("Result of 0"); 
        close(); 
        selectWindow("Result of Result of 0"); 
        rename(duplicate); 
        
        // ---- Remove outliers & transpose selection on original ----
        run("8-bit");
//         run("Remove Outliers...", "radius=1 threshold=50 which=Dark");
        run("Create Selection"); 
        selectWindow(imgName); 
        run("Restore Selection"); 
        
        // ---- Save cropped mask ----
        selectWindow(duplicate); 
        run("Crop");
        saveAs("jpg", dir2+duplicate);
        // selectWindow(duplicate+".jpg");
        selectWindow(duplicate);
        run("Convert to Mask");
        //         run("Skeletonize (2D/3D)");
        //         selectWindow(duplicate);
        eval("script",
             "importPackage(Packages.ij);"+
             "importPackage(Packages.sc.fiji.analyzeSkeleton);"+
             
             // Takes a binary image as input
             "var imp = IJ.getImage();"+// get current open image
             
             // Skeletonize the image
             "IJ.run(imp, \"Skeletonize (2D/3D)\", \"\");"+
             
             // Initialize AnalyzeSkeleton_
             "var skel = new AnalyzeSkeleton_();"+
             "skel.calculateShortestPath = true;"+
             "skel.prune = [shortest branch];"+
             "skel.setup(\"\", imp);"+
             
             // Perform analysis in silent mode
             // (work on a copy of the ImagePlus if you don't want it displayed)
             // run(int pruneIndex, boolean pruneEnds, boolean shortPath, ImagePlus origIP, boolean silent, boolean verbose)
             "var skelResult = skel.run(AnalyzeSkeleton_.NONE, false, true, null, true, false);"+
             
             // Read the results
             "var shortestPaths = skelResult.getShortestPathList();"+
             "var max = Math.max.apply(null, shortestPaths);"+
             
             
             // Use the readout within the script
//              "IJ.log(imp);"+
             "IJ.log((max*0.12));"
             );
             //         run("Analyze Skeleton (2D/3D)", "prune=none calculate");
             saveAs("jpg", dir2+duplicate+"_skeleton");
             // selectWindow(duplicate+"_skeleton.jpg");
   selectWindow(duplicate);
             close();
             //         selectWindow(duplicate);
             //         close();
             //         selectWindow("Tagged skeleton");
             //         close();
             
             
             // ---- Measure plant area ----
             selectWindow(imgName);
             run("Duplicate...", "title=x");
             selectWindow("x");
             rename(imgName+"_2");
             duplicate=getTitle();
             selectWindow(duplicate);        
             row = nResults;
             setResult("Image", row, duplicate);
             selectWindow(duplicate); 
             run("HSB Stack");
             selectWindow(duplicate);
             setSlice(2);
             getStatistics(area, mean);
             setResult("Saturation", row, mean);
             setSlice(1);
             getStatistics(area, mean, min[1], max[1], std, histogram);
             setResult("Hue", row, (mean/255*360));
             setResult("St. Dev.", row, (std/255*360));
             setResult("Area mm²", row, (area*scale));
             getSelectionBounds(x, y, width, height);
             setResult("Height mm", row, (height*scale));
             for (i=0; i<256; i++){
                 setResult("Image", row, duplicate);
                 setResult("Count"+i/255*360, row, histogram[i]);
             }
             updateResults();
             run("Close All");
    }
    
    
    
    //         //---- Flower Count ----
    // 
    //         selectWindow(imgName);
    //         run("Select All");
    //         run("RGB Color");
    //         makeRectangle(3564, 3148, 1540, 868);
    //         setForegroundColor(0, 0, 0);
    //         run("Fill", "slice");
    //         selectWindow(imgName);
    //         run("Select All");
    //         run("Gaussian Blur...", "sigma=2");
    //         run("Maximum...", "radius=2");
    //         
    //         // ---- Threshold colours to select only flowers ----
    //         min=newArray(3); 
    //         max=newArray(3); 
    //         filter=newArray(3);  
    //         run("HSB Stack"); 
    //         selectWindow(imgName);
    //         run("Convert Stack to Images"); 
    //         selectWindow("Hue"); 
    //         rename("0"); 
    //         selectWindow("Saturation"); 
    //         rename("1"); 
    //         selectWindow("Brightness"); 
    //         rename("2"); 
    //         //Hue
    //         min[0]=0; 
    //         max[0]=255; 
    //         filter[0]="pass";
    //         //Saturation
    //         min[1]=0; 
    //         max[1]=25; 
    //         filter[1]="pass";
    //         //Brightness
    //         min[2]=230; 
    //         max[2]=255; 
    //         filter[2]="pass"; 
    //         for (i=0;i<3;i++){ 
    //             selectWindow(""+i); 
    //             setThreshold(min[i], max[i]); 
    //             run("Convert to Mask"); 
    //             if (filter[i]=="stop")  run("Invert"); 
    //         } 
    //         imageCalculator("AND create", "0","1"); 
    //         imageCalculator("AND create", "Result of 0","2"); 
    //         for (i=0;i<3;i++){ 
    //             selectWindow(""+i); 
    //             close(); 
    //         } 
    //         selectWindow("Result of 0"); 
    //         close(); 
    //         selectWindow("Result of Result of 0"); 
    //         rename(imgName); 
    //         selectWindow(imgName); 
    //         run("Restore Selection"); 
    //         
    //         // ---- Measure selection ----
    //         selectWindow(imgName); 
    //         setOption("BlackBackground", false);
    //         run("Make Binary");
    // //         run("Watershed");
    //         run("Analyze Particles...", "  circularity=0.75-1.00 show=Nothing summarize");
    //         
    //         // ---- Save flower mask ----
    //         selectWindow(imgName); 
    //         saveAs("jpg", dir2+imgName+"_flowers");
    // 
    //         run("Close All");
    //     }
}

macro "flower count" {
    
    // ---- Store image name ----    
    imgName=getTitle(); 
    dir = getDirectory("image");
    makeRectangle(3652, 3300, 1420, 712);
    setForegroundColor(0, 0, 0);
    run("Fill", "slice");
    selectWindow(imgName);
    run("Select All");
    
    run("Gaussian Blur...", "sigma=2");
    run("Maximum...", "radius=1");
    
    
    
    // ---- Threshold colours to select only plant parts ----
    min=newArray(3); 
    max=newArray(3); 
    filter=newArray(3); 
    duplicate=getTitle(); 
    run("HSB Stack"); 
    selectWindow(imgName);
    run("Convert Stack to Images"); 
    selectWindow("Hue"); 
    rename("0"); 
    selectWindow("Saturation"); 
    rename("1"); 
    selectWindow("Brightness"); 
    rename("2"); 
    //Hue
    min[0]=0; 
    max[0]=255; 
    filter[0]="pass";
    //Saturation
    min[1]=0; 
    max[1]=25; 
    filter[1]="pass";
    //Brightness
    min[2]=100; 
    max[2]=255; 
    filter[2]="pass"; 
    for (i=0;i<3;i++){ 
        selectWindow(""+i); 
        setThreshold(min[i], max[i]); 
        run("Convert to Mask"); 
        if (filter[i]=="stop")  run("Invert"); 
    } 
    imageCalculator("AND create", "0","1"); 
    imageCalculator("AND create", "Result of 0","2"); 
    for (i=0;i<3;i++){ 
        selectWindow(""+i); 
        close(); 
    } 
    selectWindow("Result of 0"); 
    close(); 
    selectWindow("Result of Result of 0"); 
    rename(imgName); 
    // ---- Remove outliers & transpose selection on original ----
    selectWindow(imgName); 
    run("Restore Selection"); 
    
    // ---- Measure selection ----
    selectWindow(imgName); 
    setOption("BlackBackground", false);
    run("Make Binary");
    //         run("Watershed");
    run("Analyze Particles...", "size=0-200 circularity=0.75-1.00 show=Nothing clear summarize");
    saveAs("jpg", dir+imgName+"_flowers");
    run("Close All");
}
}

macro "save all" {
    dir1 = getDirectory("Choose Source Directory "); 
    // get image IDs of all open images
    ids=newArray(nImages);
    for (i=0;i<nImages;i++) {
        selectImage(i+1);
        ids[i]=getImageID;
        
        saveAs("Jpeg", dir1+ids[i]+".jpg");
    } 
}

// "IRX measurements with pixel by pixel Wiesner absorbance"
macro "rotate to 0" {
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
  saveAs("tiff", "/data/PhD/IRX/Poplar/2020-08_soil_poplar/Wiesner/2020-10-22_poplar/registered/rotated_stacks/"+a+"_rotated.tiff");
  roiManager("Save", "/data/PhD/IRX/Poplar/2020-08_soil_poplar/Wiesner/2020-10-22_poplar/registered/rois/"+a+"_roi.zip");
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

macro "Measure concavity" {
    run("Set Scale...", "distance=5.9 known=1 pixel=1 unit=µm");
    run("Set Measurements...", "area perimeter redirect=None decimal=3");
    n = roiManager("count");
    for ( i=1; i<n; i++ ) { 
  roiManager("select", i);
  run("Convex Hull");
  roiManager("Add");
    }
    roiManager("Select", newArray(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15));
    roiManager("Delete");
    roiManager("Remove Slice Info");
    roiManager("Measure");
}

macro "Measure concavity At" {
    run("Set Scale...", "distance=5.9 known=1 pixel=1 unit=µm");
    run("Set Measurements...", "area perimeter redirect=None decimal=3");
    dir1 = getDirectory("Choose a ROI Directory ");
    list = getFileList(dir1); 
    for (i=0; i<list.length; i++) {

  if(endsWith(list[i],"rotated_roi.zip")){
                path = dir1+list[i]; 
      roiManager("Open", path);
      roiManager("Select", 1);
      run("Convex Hull");
      roiManager("Add");
      roiManager("Select", newArray(0,1));
      roiManager("Delete");
      roiManager("Select", 0);
      getStatistics(area);
      setResult("File", nResults, list[i]);
      setResult("ConvexArea", nResults-1, area);
      roiManager("Select", 0);
      roiManager("Delete");
  }
    }
}

macro "stitch subfolders" {
    setBatchMode(true);
    dir1 = getDirectory("Choose Source Directory ");
    subFolderList = getFileList(dir1);

    for(i=0;i<subFolderList.length;i++){
        folder = dir1 + subFolderList[i];
        run("Grid/Collection stitching", "type=[Unknown position] order=[All files in directory] directory=" + folder + " output_textfile_name=TileConfiguration.txt fusion_method=[Linear Blending] regression_threshold=0.50 max/avg_displacement_threshold=2.50 absolute_displacement_threshold=3.50 computation_parameters=[Save computation time (but use more RAM)] image_output=[Fuse and display]");
        run("RGB Color");
        saveAs("Tif", dir1 + subFolderList[i] + "stitched.jpg");
        run("Close All");
    }
}

macro "get line profile [n4]" {
  dir1=getDirectory("Select directory for output");
  run("Clear Results");
  a=getTitle();
  roiManager("Save", dir1+a+"_roi.zip");
  saveAs("tiff", dir1+a);
  roiManager("Remove Slice Info");
  setSlice(3);
  for (m = 0; m < roiManager("count"); m++){
        roiManager("Select", m);
        profile = 0;
        profile = getProfile();
        for (i = 0; i < profile.length; i++){
          setResult("Roi_"+m, i, profile[i]);
        }
  }
  run("Input/Output...", "jpeg=85 gif=-1 file=.csv use_file copy_row save_column");
  saveAs("Results", dir1+a+".csv");
}

macro "warped heatmap [n1]" {
    a=getTitle();
    b=getDirectory("image");
//     run("Images to Stack", "name=Stack title=[] use");
//     run("Linear Stack Alignment with SIFT", "initial_gaussian_blur=1.60 steps_per_scale_octave=3 minimum_image_size=64 maximum_image_size=1024 feature_descriptor_size=4 feature_descriptor_orientation_bins=8 closest/next_closest_ratio=0.92 maximal_alignment_error=25 inlier_ratio=0.05 expected_transformation=Rigid interpolate");
//     selectWindow("Stack");
//     close();
//     waitForUser("Cropping", "Select rectangular area of interest.");
//     run("Crop");
//     setSlice(1);
//     stained=getInfo("slice.label");
//     setSlice(2);
//     unstained=getInfo("slice.label");
//     run("Stack to Images");
//     selectWindow(unstained);
//     rename("Aligned-0002");
//     selectWindow(stained);
//     rename("Aligned-0001");
//     run("Extract SIFT Correspondences", "source_image=Aligned-0002 target_image=Aligned-0001 initial_gaussian_blur=1.40 steps_per_scale_octave=5 minimum_image_size=32 maximum_image_size=1024 feature_descriptor_size=8 feature_descriptor_orientation_bins=8 closest/next_closest_ratio=0.92 filter maximal_alignment_error=10 minimal_inlier_ratio=0.05 minimal_number_of_inliers=7 expected_transformation=Similarity");
//     run("bUnwarpJ", "source_image=Aligned-0002 target_image=Aligned-0001 registration=Accurate image_subsample_factor=0 initial_deformation=[Very Coarse] final_deformation=[Fine] divergence_weight=0 curl_weight=0 landmark_weight=0 image_weight=1 consistency_weight=10 stop_threshold=0.01");
//     selectWindow("Aligned-0001");
//     close();
//     selectWindow("Aligned-0002");
//     close();
//     selectWindow("Registered Source Image");
//     close();
//     selectWindow("Registered Target Image");
    run("Stack to Images");
//     selectWindow("Warped Source Mask");
//     close();
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
//     run("fire_lut_0-150");
    run("  morgenstemning ");
    run("Images to Stack", "name=Stack title=[] use");
    rename(a);
    roiManager("Show All with labels")
    //run("Close All");
}

macro "IF_area [n3]" {
  a = getTitle();
  getCursorLoc(x, y, z, modifiers);
  makeOval(x-40, y-40, 80, 80);
  roiManager("Add");
  makeOval(x-20, y-20, 40, 40);
  roiManager("Add");
  makeOval(x-10, y-10, 20, 20);
  roiManager("Add");
  roiManager("Show All with labels");
  waitForUser("Measuring overlap", "Add ROIs for the lumen area.");
  roiManager("Save", "/home/leonard/Documents/Uni/PhD/Raman/IF_areas/"+a+".zip");
  for (m = 3; m < roiManager("count"); m++){
    roiManager("Select", newArray(0,m));
    roiManager("AND");
    sel = selectionType();
    if (sel == -1){
      setResult("Area_80", m-3, "0");
    }
    else {
      getStatistics(area);
      setResult("Area_80", m-3, area);
    }
  }
  for (m = 3; m < roiManager("count"); m++){
    roiManager("Select", newArray(1,m));
    roiManager("AND");
    sel = selectionType();
    if (sel == -1){
      setResult("Area_40", m-3, "0");
    }
    else {
      getStatistics(area);
      setResult("Area_40", m-3, area);
    }
  }
  for (m = 3; m < roiManager("count"); m++){
    roiManager("Select", newArray(2,m));
    roiManager("AND");
    sel = selectionType();
    if (sel == -1){
      setResult("Area_20", m-3, "0");
    }
    else {
      getStatistics(area);
      setResult("Area_20", m-3, area);
    }
  }
}
  
// macro "OD_hue_activity [n5]" {
//     rename("Aligned_OD");
//     run("Duplicate...", "duplicate");
//     rename("Aligned_hue");
//     //selectWindow("Stack");
//     //close();
//     selectWindow("Aligned_OD");
//     run("8-bit");
//     run("Calibrate...", "function=[Uncalibrated OD] unit=[Gray Value] text1= text2=");
//     run("Set Measurements...", "mean nan redirect=None decimal=3");
//     roiManager("multi-measure measure_all");
//     //selectWindow("Aligned_OD");
//     //close();
//     selectWindow("Aligned_hue");
//     run("HSB Stack");
//     selectWindow("Aligned_hue");
//     run("Reduce Dimensionality...", "slices");
//     selectWindow("Aligned_hue");
//     run("Set Measurements...", "median nan redirect=None decimal=3");
//     roiManager("multi-measure measure_all append");
//     //selectWindow("Aligned_hue");
//     //close();
//     run("Close All");
// }

macro "OD_hue_activity [n5]" {
  dir = getDirectory("Select directory for saved ROIs");
  interval = getNumber("Time between images [min]", 15);
  a = getTitle();
  if (roiManager("count") != 160) Dialog.create("Unexpected number of ROIs!");
  else {
    roiManager("Save", dir+a+".zip");
    setBatchMode(true);
    roiManager("Deselect");
    roiManager("Remove Channel Info");
    roiManager("Remove Slice Info");
    roiManager("Remove Frame Info");
    rename("Aligned_OD");
    run("Duplicate...", "duplicate");
    rename("Aligned_hue");
    selectWindow("Aligned_OD");
    run("8-bit");
    run("Calibrate...", "function=[Uncalibrated OD] unit=[Gray Value] text1= text2=");
    for (n = 1; n <= nSlices; n++) {
      setSlice(n);
      for (m = 0; m < 160; m++){
        roiManager("Select", m);
        mean = getValue("Mean");
        setResult("image", m + ((n - 1) * 160), a);
        setResult("slice", m + ((n - 1) * 160), n);
        if (m < 20) setResult("cell_type", m + ((n - 1) * 160), "IF");
        else if (m < 40) setResult("cell_type", m + ((n - 1) * 160), "CML");
        else if (m < 60) setResult("cell_type", m + ((n - 1) * 160), "LP");
        else if (m < 80) setResult("cell_type", m + ((n - 1) * 160), "MX");
        else if (m < 100) setResult("cell_type", m + ((n - 1) * 160), "PX");
        else if (m < 120) setResult("cell_type", m + ((n - 1) * 160), "XF");
        else if (m < 140) setResult("cell_type", m + ((n - 1) * 160), "PH");
        else setResult("cell_type", m + ((n - 1) * 160), "BG");
        setResult("mean_absorbance", m + ((n - 1) * 160), mean);
      }
    }
    selectWindow("Aligned_hue");
    run("HSB Stack");
    selectWindow("Aligned_hue");
    run("Reduce Dimensionality...", "slices");
    selectWindow("Aligned_hue");
    for (n = 1; n <= nSlices; n++) {
      setSlice(n);
      for (m = 0; m < 160; m++){
        roiManager("Select", m);
        median = getValue("Median");
        setResult("median_hue", m + ((n - 1) * 160), median);
        setResult("interval", m + ((n - 1) * 160), interval);
      }
    }
    close("*");
    run("Input/Output...", "jpeg=85 gif=-1 file=.csv use_file copy_row save_column");
    // save measurements
    saveAs("Results", dir + "Measurements/" + a + ".csv");
    setBatchMode(false);
  }
}

// macro "OD_hue_activity [n5]" { // modified version to re-measure the IF and CML of DAF pH 5
//   dir = getDirectory("Select directory for saved ROIs");
//   interval = getNumber("Time between images [min]", 15);
//   a = getTitle();
//   if (roiManager("count") != 40) Dialog.create("Unexpected number of ROIs!");
//   else {
//     roiManager("Save", dir+a+".zip");
//     setBatchMode(true);
//     roiManager("Deselect");
//     roiManager("Remove Channel Info");
//     roiManager("Remove Slice Info");
//     roiManager("Remove Frame Info");
//     rename("Aligned_OD");
//     run("Duplicate...", "duplicate");
//     rename("Aligned_hue");
//     selectWindow("Aligned_OD");
//     run("8-bit");
//     run("Calibrate...", "function=[Uncalibrated OD] unit=[Gray Value] text1= text2=");
//     for (n = 1; n <= nSlices; n++) {
//       setSlice(n);
//       for (m = 0; m < 40; m++){
//         roiManager("Select", m);
//         mean = getValue("Mean");
//         setResult("image", m + ((n - 1) * 40), a);
//         setResult("slice", m + ((n - 1) * 40), n);
//         if (m < 20) setResult("cell_type", m + ((n - 1) * 40), "IF");
//         else if (m < 40) setResult("cell_type", m + ((n - 1) * 40), "CML");
//         setResult("mean_absorbance", m + ((n - 1) * 40), mean);
//       }
//     }
//     selectWindow("Aligned_hue");
//     run("HSB Stack");
//     selectWindow("Aligned_hue");
//     run("Reduce Dimensionality...", "slices");
//     selectWindow("Aligned_hue");
//     for (n = 1; n <= nSlices; n++) {
//       setSlice(n);
//       for (m = 0; m < 40; m++){
//         roiManager("Select", m);
//         median = getValue("Median");
//         setResult("median_hue", m + ((n - 1) * 40), median);
//         setResult("interval", m + ((n - 1) * 40), interval);
//       }
//     }
//     close("*");
//     run("Input/Output...", "jpeg=85 gif=-1 file=.csv use_file copy_row save_column");
//     // save measurements
//     saveAs("Results", dir + "Measurements/" + a + ".csv");
//     setBatchMode(false);
//   }
// }

macro "add_raman_crosshairs" {
//visualise the center of the individual images in the stitched mosaic
dir = getDirectory("Select directory containing raw .tif images");
outDir = getDirectory("Select output directory");
path = File.openDialog("Select stitched image")

list = getFileList(dir); 
for (i=0; i<list.length; i++) {
  open(dir+list[i]);
  run("Select All");
  setBackgroundColor(0, 0, 0);
  run("Clear", "slice");
  img = getTitle();
  getDimensions(width, height, channels, slices, frames);
  x1 = (width / 2) - 10;
  x2 = (width / 2) - 25;
  x3 = (width / 2) + 10;
  x4 = (width / 2) + 25;
  y1 = (height / 2) - 10;
  y2 = (height / 2) - 25;
  y3 = (height / 2) + 10;
  y4 = (height / 2) + 25;
  setColor("#e8c245");
  setLineWidth(7);
  drawLine(x1, height / 2, x2, height / 2);
  drawLine(x3, height / 2, x4, height / 2);
  drawLine(width / 2, y1, width / 2, y2);
  drawLine(width / 2, y3, width / 2, y4);
  
  setFont("Monospaced", 20);
  drawString(img, x4, y1);
  
  saveAs("tiff",outDir+img);
  close();
}

  run("Grid/Collection stitching", "type=[Positions from file] order=[Defined by TileConfiguration] directory="+outDir+" layout_file=TileConfiguration.registered.txt fusion_method=[Max. Intensity] regression_threshold=0.30 max/avg_displacement_threshold=2.50 absolute_displacement_threshold=3.50 computation_parameters=[Save memory (but be slower)] image_output=[Fuse and display]");
  run("RGB Color");
  rename("Overlay");
  open(path);
  run("Add Image...", "image=Overlay x=0 y=0 opacity=100 zero");
  saveAs("tiff",outDir+"stitched_overlay.tiff");
  close("*")
}

macro "5cm_scale [n7]" {
  len = getValue("Length raw")
  run("Set Scale...", "distance="+len+" known=5 unit=cm");
}

macro "measure_drought" {
  setBatchMode(true);
  title = getTitle();
  setForegroundColor(0, 0, 0);
  run("Fill");
  run("Select All");
  run("Duplicate...", "title=Mask");
  selectWindow("Mask");
  run("Color Threshold...");
  // Color Thresholder 2.1.0/1.53c
  // Autogenerated macro, single images only!
  min=newArray(3);
  max=newArray(3);
  filter=newArray(3);
  a=getTitle();
  call("ij.plugin.frame.ColorThresholder.RGBtoLab");
  run("RGB Stack");
  run("Convert Stack to Images");
  selectWindow("Red");
  rename("0");
  selectWindow("Green");
  rename("1");
  selectWindow("Blue");
  rename("2"); 
  min[0]=50;
  max[0]=255;
  filter[0]="pass";
  min[1]=0;
  max[1]=130;
  filter[1]="pass";
  min[2]=140;
  max[2]=255;
  filter[2]="pass";
  for (i=0;i<3;i++){
    selectWindow(""+i);
    setThreshold(min[i], max[i]);
    run("Convert to Mask");
    if (filter[i]=="stop")  run("Invert");
  }
  imageCalculator("AND create", "0","1");
  imageCalculator("AND create", "Result of 0","2");
  for (i=0;i<3;i++){
    selectWindow(""+i);
    close();
  }
  selectWindow("Result of 0");
  close();
  selectWindow("Result of Result of 0");
  rename(a);
  // Colour Thresholding-------------
  setOption("BlackBackground", true);
  run("Convert to Mask");
  run("Remove Outliers...", "radius=25 threshold=50 which=Bright");
  run("Create Selection");
  saveAs("jpg", "/home/leonard/Documents/Uni/PhD/IRX/Drought/top/masks/"+title);
  close();
  selectWindow(title);
  run("Restore Selection");
  run("Set Measurements...", "area mean redirect=None decimal=3");
  mean = getValue("Mean");
  area = getValue("Area");
  nrow = nResults
  setResult("image", nrow, title);
  setResult("area", nrow, area);
  setResult("mean_hue", nrow, mean);
  updateResults();
  selectWindow("Threshold Color");
  close();
  close("*")
  setBatchMode(false);
}

macro "save_cropped_rosettes" {
  setBatchMode(true);
  imgs = getDirectory("Select image directory");
  masks = getDirectory("Select mask directory");
  out = getDirectory("Select output directory");
  list = getFileList(imgs); 
  for (i=0; i<list.length; i++) {
    open(masks+list[i]);
    run("Convert to Mask");
    run("Create Selection");
    open(imgs+list[i]);
    run("Restore Selection");
    run("Crop");
    setBackgroundColor(0, 0, 0);
    run("Clear Outside");
    saveAs("jpg", out+list[i]);
    close("*");
  }
  setBatchMode(false);
}

macro "align and save.czi" {
  setBatchMode(true);
  imgs = getDirectory("Select image directory");
  list = getFileList(imgs); 
  for (i=0; i<list.length; i++) {
    run("Bio-Formats Importer", "open=" + imgs + list[i] + " color_mode=Default view=Hyperstack");
    run("RGB Color", "frames");
    run("Linear Stack Alignment with SIFT", "initial_gaussian_blur=1.60 steps_per_scale_octave=3 minimum_image_size=64 maximum_image_size=1024 feature_descriptor_size=4 feature_descriptor_orientation_bins=8 closest/next_closest_ratio=0.92 maximal_alignment_error=25 inlier_ratio=0.05 expected_transformation=Rigid interpolate");
    selectWindow("Aligned 50 of 50");
    saveAs("tiff", imgs+File.nameWithoutExtension+"_registered.tiff");
    close("*");
  }
  setBatchMode(false);
}

macro "merge RGB stacks" {
  setBatchMode(true);
  imgs = getDirectory("Select image directory");
  out = getDirectory("Select output directory");
  list = getFileList(imgs); 
  for (i=0; i<list.length; i++) {
    open(imgs+list[i]);
    run("RGB Color");
    saveAs("jpg", out+list[i]+".jpg");
    close("*");
  }
  setBatchMode(false);
}

macro "stitch Wiesner" {
  setBatchMode(true);
  dir1 = getDirectory("Choose Source Directory ");
  dir2 = getDirectory("Choose Output Directory ");
  subFolderList = getFileList(dir1);
  
  for(i=0;i<subFolderList.length;i++){
    folder = dir1 + subFolderList[i];
    folderList = getFileList(folder);
    if (folderList.length == 80) {
      rows = 10;
      cols = 8;
    } else if (folderList.length == 63) {
      rows = 9;
      cols = 7;
    } else if (folderList.length == 99) {
      rows = 11;
      cols = 9;
    } else if (folderList.length == 48) {
      rows = 8;
      cols = 6;
    }
    run("Grid/Collection stitching", "type=[Grid: snake by rows] order=[Left & Up] grid_size_x=" + cols + " grid_size_y=" + rows + " tile_overlap=20 first_file_index_i=1 directory=[" + folder + "] file_names=[" + substring(folderList[i], 0, lengthOf(folderList[i]) - 8) + "_m{ii}.jpg] output_textfile_name=TileConfiguration.txt fusion_method=[Linear Blending] regression_threshold=0.25 max/avg_displacement_threshold=2.50 absolute_displacement_threshold=3.50 compute_overlap ignore_z_stage subpixel_accuracy computation_parameters=[Save computation time (but use more RAM)] image_output=[Fuse and display]");
    run("RGB Color");
    saveAs("Jpeg", dir2 + substring(subFolderList[i], 0, lengthOf(subFolderList[i]) - 17) + ".jpg");
    run("Scale...", "x=0.25 y=0.25 width=5041 height=4958 interpolation=Bilinear average create title=small");
    saveAs("Jpeg", dir2 + substring(subFolderList[i], 0, lengthOf(subFolderList[i]) - 17) + "_small.jpg");
    run("Close All");
  }
  setBatchMode(false);
}

macro "stitch Axiovert with BG correction" {
  setBatchMode(true);
  
  Dialog.create("Stitch tiled images from the Axiovert 200M");
  Dialog.addDirectory("Select input folder containing subfolders with exported images", "");
  Dialog.addDirectory("Select output folder", "");
  Dialog.addFile("Select image containing only background for shading correction", "");
  Dialog.addChoice("Choose file format for output", newArray("jpg", "png", "tif"), "jpg");
  Dialog.addSlider("Regression threshold for stitching*", 0, 1, 0.75);
  Dialog.addMessage("*Increase if tiles are matched incorrectly, decrease if stitched images have 'holes'", 10);
  Dialog.addHelp("<html> This macro uses the 'Grid/Collection Stitching' plugin by Stephan Preibisch, see <a href = 'https://imagej.net'>https://imagej.net</a> for more info.")
  Dialog.show();
  
  dir1 = Dialog.getString();
  dir2 = Dialog.getString();
  bg = Dialog.getString();
  type = Dialog.getChoice();
  threshold = Dialog.getNumber();
  
  File.makeDirectory(dir2 + "background_corrected/");
  open(bg);
  rename("background");
  w = getWidth();
  h = getHeight();
  newImage("white", "RGB white", w, h, 1);
  imageCalculator("Subtract create", "white","background");
  run("RGB Color");
  saveAs(type, dir2 + "shading_correction");
  run("Close All");
  subFolderList = getFileList(dir1);
  
  for(i=0;i<subFolderList.length;i++){
    folder = dir1 + subFolderList[i];
    fileList = getFileList(folder);
    intermediateFolder = dir2 + "background_corrected/" + subFolderList[i];
    File.makeDirectory(intermediateFolder);
    
    for(j=0;j<fileList.length;j++){
      open(folder+fileList[j]);
      open(dir2 + "shading_correction." + type);
      imageCalculator("Add", fileList[j], "shading_correction." + type);
      saveAs(type, intermediateFolder + fileList[j]);
      run("Close All");
    }
    
    if (fileList.length == 80) {
      rows = 10;
      cols = 8;
      numbering = "m{ii}.";
    } else if (fileList.length == 63) {
      rows = 9;
      cols = 7;
      numbering = "m{ii}.";
    } else if (fileList.length == 99) {
      rows = 11;
      cols = 9;
      numbering = "m{ii}.";
    } else if (fileList.length == 120) {
      rows = 12;
      cols = 10;
      numbering = "{iii}.";
    } else if (fileList.length == 130) {
      rows = 13;
      cols = 10;
      numbering = "{iii}.";
    } else if (fileList.length == 48) {
      rows = 8;
      cols = 6;
      numbering = "m{ii}.";
    } else if (fileList.length == 30) {
      rows = 6;
      cols = 5;
      numbering = "m{ii}.";
    } else if (fileList.length == 16) {
      rows = 4;
      cols = 4;
      numbering = "m{ii}.";
    } else if (fileList.length == 9) {
      rows = 3;
      cols = 3;
      numbering = "_m{i}.";
    }
    
    run("Grid/Collection stitching", "type=[Grid: snake by rows] order=[Left & Up] grid_size_x=" + cols + " grid_size_y=" + rows + " tile_overlap=20 first_file_index_i=1 directory=[" + intermediateFolder + "] file_names=[" + substring(fileList[i], 0, lengthOf(fileList[i]) - 7) + numbering + type + "] output_textfile_name=TileConfiguration.txt fusion_method=[Linear Blending] regression_threshold=" + threshold + " max/avg_displacement_threshold=1.50 absolute_displacement_threshold=2.50 compute_overlap ignore_z_stage subpixel_accuracy computation_parameters=[Save computation time (but use more RAM)] image_output=[Fuse and display]");
    run("RGB Color");
    saveAs(type, dir2 + substring(subFolderList[i], 0, lengthOf(subFolderList[i]) - 17));
    run("Scale...", "x=0.25 y=0.25 interpolation=Bilinear average create title=small");
    saveAs("jpg", dir2 + substring(subFolderList[i], 0, lengthOf(subFolderList[i]) - 17) + "_small");
    run("Close All");
  }
  setBatchMode(false);
}

macro "scale down" {
  setBatchMode(true);
  dir1 = getDirectory("Choose Source Directory ");
  list = getFileList(dir1); 
  for (i=0; i<list.length; i++) {
    open(dir1+list[i]);
    run("Enhance Contrast...", "saturated=10");
    run("Scale...", "x=0.25 y=0.25 interpolation=Bilinear average create title=021-04-29_Q_4_stained.png");
    saveAs("Jpeg", dir1 + substring(list[i], 0, lengthOf(list[i]) - 4) + "_small.jpg");
    close("*");
  }
  setBatchMode(false);
}

macro "Wiesner Axiovert [n0]" {
    // rough alignment of whole sections
    a = File.getNameWithoutExtension(getTitle());
    b = getDir("image");
    run("Images to Stack", "name=Stack title=[] use");
    run("Linear Stack Alignment with SIFT", "initial_gaussian_blur=1.60 steps_per_scale_octave=3 minimum_image_size=64 maximum_image_size=1024 feature_descriptor_size=4 feature_descriptor_orientation_bins=8 closest/next_closest_ratio=0.92 maximal_alignment_error=25 inlier_ratio=0.05 expected_transformation=Rigid interpolate");
    selectWindow("Stack");
    close();
    // select bundle and make a fine alignment
    waitForUser("Cropping", "Select rectangular area of interest.");
    run("Crop");
    run("Stack to Images");
    run("Extract SIFT Correspondences", "source_image=Aligned-0002 target_image=Aligned-0001 initial_gaussian_blur=1.40 steps_per_scale_octave=5 minimum_image_size=32 maximum_image_size=1024 feature_descriptor_size=8 feature_descriptor_orientation_bins=8 closest/next_closest_ratio=0.92 filter maximal_alignment_error=10 minimal_inlier_ratio=0.05 minimal_number_of_inliers=7 expected_transformation=Similarity");
    run("bUnwarpJ", "source_image=Aligned-0002 target_image=Aligned-0001 registration=Accurate image_subsample_factor=0 initial_deformation=[Very Coarse] final_deformation=[Fine] divergence_weight=0 curl_weight=0 landmark_weight=0 image_weight=1 consistency_weight=10 stop_threshold=0.01");
    selectWindow("Aligned-0001");
    close();
    selectWindow("Aligned-0002");
    close();
    selectWindow("Registered Source Image");
    close();
    selectWindow("Registered Target Image");
    rename(a);
    roiManager("Show All with labels")
    // manually create ROIs to be measured (in order)
    waitForUser("Create ROIs", "Create 20 ROIs for\nPX, MX, XF, XF-CML, IF, IF-CML, LP, PH and BG");
    setBatchMode(true);
    setSlice(3);
    run("Delete Slice");
    setSlice(1);
    // save fine alignment
    saveAs("tiff", b + "Alignments/" + a + "_aligned.tiff");
    // save ROIs
    roiManager("Save", b + "ROIs/" + a + "_aligned.zip");
    run("Set Measurements...", "centroid mean redirect=None decimal=3");
    run("Set Scale...", "distance=8.8106 known=1 pixel=1 unit=µm");
    run("Select None");
    selectWindow(a + "_aligned.tiff");
    run("Duplicate...", "duplicate");
    rename(a + "_hue");
    selectWindow(a + "_aligned.tiff");
    // transform one copy of the alignment to absorbance values
    run("8-bit");
    run("Calibrate...", "function=[Uncalibrated OD] unit=[Gray Value] text1= text2=");
    selectWindow(a + "_hue");
    // transform the other copy to HSV for hue measurements
    run("HSB Stack");
    selectWindow(a + "_hue");
    run("Reduce Dimensionality...", "slices");
    selectWindow(a + "_hue");
    // shift the "break" of the circular hue scale to get meaningful medians in the red
    run("Macro...", "  code=[if (v<128) {v=v+128;} else {v=v-128;}] stack");
    // measure absorbance and hue
    selectWindow(a + "_aligned.tiff");
    for (m = 0; m < 180; m++) {
        roiManager("Select", m);
        setSlice(1);
        mean = getValue("Mean");
        setResult("stained_absorbance", m, mean);
    }
    selectWindow(a + "_aligned.tiff");
    for (m = 0; m < 180; m++) {
        roiManager("Select", m);
        setSlice(2);
        mean = getValue("Mean");
        setResult("unstained_absorbance", m, mean);
    }
    selectWindow(a + "_hue");
    for (m = 0; m < 180; m++) {
        roiManager("Select", m);
        setSlice(1);
        mean = getValue("Median");
        setResult("stained_hue", m, mean);
    }
    selectWindow(a + "_hue");
    for (m = 0; m < 180; m++) {
        roiManager("Select", m);
        setSlice(2);
        mean = getValue("Median");
        setResult("unstained_hue", m, mean);
    }
    // define cell type by ROI number
    for (m = 0; m < 180; m++) {
        if (m < 20) {
            setResult("image", m, a);
            setResult("cell_type", m, "PX");
        } else if (m < 40) {
            setResult("image", m, a);
            setResult("cell_type", m, "MX");
        } else if (m < 60) {
            setResult("image", m, a);
            setResult("cell_type", m, "XF");
        } else if (m < 80) {
            setResult("image", m, a);
            setResult("cell_type", m, "XF-CML");
        } else if (m < 100) {
            setResult("image", m, a);
            setResult("cell_type", m, "IF");
        } else if (m < 120) {
            setResult("image", m, a);
            setResult("cell_type", m, "IF-CML");
        } else if (m < 140) {
            setResult("image", m, a);
            setResult("cell_type", m, "LP");
        } else if (m < 160) {
            setResult("image", m, a);
            setResult("cell_type", m, "PH");
        } else if (m < 180) {
            setResult("image", m, a);
            setResult("cell_type", m, "BG");
        }
    }
    run("Input/Output...", "jpeg=85 gif=-1 file=.csv use_file copy_row save_column");
    // save measurements
    saveAs("Results", b + "Measurements/" + a + "_aligned.csv");
    run("Close All");
    setBatchMode(false);
}

macro "Better Wand Tool - C000T0f10BT7f10WTff10T" {
   if (!isOpen("ROI Manager")) run("ROI Manager...");
   smoothness= call('ij.Prefs.get','bwt.selectSmoothness',3);
   getCursorLoc(x, y, z, flags);
   id=getImageID;
   setBatchMode(1);
   run("Select None");
   run("Duplicate...","title=a");
   run("Gaussian Blur...", "radius="+smoothness);
   id2=getImageID;
   while (flags&16!=0) {
    selectImage(id);
    getCursorLoc(x1, y1, z, flags);
    selectImage(id2);
    doWand(x, y, 0.5*sqrt((x1-x)*(x1-x)+(y1-y)*(y1-y)), "8-connected");
    getSelectionCoordinates(xpoints, ypoints);
    selectImage(id);
    Overlay.clear;
    makeSelection("freehand", xpoints, ypoints);
    Overlay.addSelection("green")
    Overlay.show;
    wait(20);
  }
  roiManager('add');
  roiManager("show all with labels");
  roiManager('select',roiManager('count')-1);
}

macro "Better Wand Tool Options" {
   smoothness = call('ij.Prefs.get','bwt.selectSmoothness',3);
   Dialog.create("Options");
   Dialog.addNumber("Smoothness factor", smoothness);
   Dialog.show();
   smoothness= Dialog.getNumber();
   call('ij.Prefs.set','bwt.selectSmoothness',smoothness);
}

macro "Trace shape" {
    a = File.getNameWithoutExtension(getTitle());
    b = getDirectory("Choose directory for saved output.");
    roiManager("Save", b + "ROIs/" + a + ".zip");
    run("Set Scale...", "distance=8.8106 known=1 pixel=1 unit=µm");
    for (m = 0; m < roiManager("count"); m++){
        roiManager("Select", m);
        if (m < 20) 
            cell_type = "PX";
        else 
            cell_type = "MX";
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
            setResult("cell_type", nrow, cell_type);
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
            setResult("point", nrow, i);
            setResult("x", nrow, x[i]);
            setResult("y", nrow, y[i]);
            updateResults();
        }
    }
    run("Input/Output...", "jpeg=85 gif=-1 file=.csv use_file copy_row save_column");
    saveAs("Results", b + "Measurements/" + a + ".csv");
    run("Close All");
    run("Clear Results");
    roiManager("Deselect");
    roiManager("Delete");
}

macro "Cell wall swelling [n2]" {
  // rough alignment of whole sections
  a = File.getNameWithoutExtension(getTitle());
  b = getDirectory("Choose directory for saved output.");
  run("Images to Stack", "name=Stack title=[] use");
  run("Linear Stack Alignment with SIFT", "initial_gaussian_blur=1.60 steps_per_scale_octave=3 minimum_image_size=64 maximum_image_size=1024 feature_descriptor_size=4 feature_descriptor_orientation_bins=8 closest/next_closest_ratio=0.92 maximal_alignment_error=25 inlier_ratio=0.05 expected_transformation=Rigid interpolate");
  selectWindow("Stack");
  close();
  // select bundle and make a fine alignment
  waitForUser("Cropping", "Select rectangular area of interest.");
  run("Crop");
  run("Linear Stack Alignment with SIFT", "initial_gaussian_blur=1.60 steps_per_scale_octave=3 minimum_image_size=64 maximum_image_size=1024 feature_descriptor_size=4 feature_descriptor_orientation_bins=8 closest/next_closest_ratio=0.92 maximal_alignment_error=25 inlier_ratio=0.05 expected_transformation=Rigid interpolate");
  rename(a);
  roiManager("Show All with labels")
  // manually create ROIs to be measured (in order)
  waitForUser("Create ROIs", "Create line ROIs for each state of 10 IF and 10 MX\n (1 fresh -> 1 dry -> 1 rehydrated -> 2 fresh etc.)");
  // save fine alignment
  saveAs("tif", b + "Aligned/" + a + "_aligned.tif");
  // save ROIs
  roiManager("Save", b + "ROIs/" + a + "_aligned.zip");
  run("Set Measurements...", "redirect=None decimal=3");
  run("Set Scale...", "distance=8.8106 known=1 pixel=1 unit=µm");
  run("Select None");
  selectWindow(a + "_aligned.tif");
  roiManager("Measure");
  // define cell type by ROI number
  for (m = 0; m < 60; m++) {
    if (m < 30) {
      setResult("image", m, a);
      setResult("cell_type", m, "IF");
    } else {
      setResult("image", m, a);
      setResult("cell_type", m, "MX");
    }
    if (m == 0||m == 3||m == 6||m == 9||m == 12||m == 15||m == 18||m == 21||m == 24||m == 27||m == 30||m == 33||m == 36||m == 39||m == 42||m == 45||m == 48||m == 51||m == 54||m == 57) {
      setResult("state", m, "fresh");
    } else if (m == 1||m == 4||m == 7||m == 10||m == 13||m == 16||m == 19||m == 22||m == 25||m == 28||m == 31||m == 34||m == 37||m == 40||m == 43||m == 46||m == 49||m == 52||m == 55||m == 58) {
      setResult("state", m, "dry");
    } else {
      setResult("state", m, "rehydrated");
  }
  run("Input/Output...", "jpeg=85 gif=-1 file=.csv use_file copy_row save_column");
  // save measurements
  saveAs("Results", b + "Measurements/" + a + "_aligned.csv");
  run("Close All");
}

macro "split czi" {
  setBatchMode(true);
  dir = getDirectory("Choose source directory")
  fileList = getFileList(dir);
  
  for(j=0;j<fileList.length;j++){
    name = File.getNameWithoutExtension(dir+fileList[j]);
    out = dir + name + "/";
    File.makeDirectory(out);
    
    call("ij.Prefs.set", "bioformats.zeissczi.allow.autostitch", "false");
    run("Bio-Formats Macro Extensions");
    Ext.setId(dir+fileList[j]);
    Ext.getSeriesCount(seriesCount);
    for (s=0; s<=seriesCount; s++) {
      run("Bio-Formats Importer", "open="+dir+fileList[j]+" autoscale color_mode=Default view=Hyperstack stack_order=XYCZT series_" + s);
      title = getTitle();
      print(title);
      saveAs("tiff", out + title);
      close();
    }
  }
  setBatchMode(false);
}

macro "Import Results Table" {
  requires("1.35r");
  lineseparator = "\n";
  cellseparator = ",\t";
  
  // copies the whole RT to an array of lines
  lines=split(File.openAsString(""), lineseparator);
  
  // recreates the columns headers
  labels=split(lines[0], cellseparator);
  if (labels[0]==" ")
    k=1; // it is an ImageJ Results table, skip first column
    else
      k=0; // it is not a Results table, load all columns
      for (j=k; j<labels.length; j++)
        setResult(labels[j],0,0);
      
      // dispatches the data into the new RT
      run("Clear Results");
    for (i=1; i<lines.length; i++) {
      items=split(lines[i], cellseparator);
      for (j=k; j<items.length; j++)
        setResult(labels[j],i-1,items[j]);
    }
    updateResults();
}

macro "BG correct seedlings" {
  setBatchMode(true);
  dir = getDirectory("Choose folder containing subfolders to be stitched");
  lineseparator = "\n";
  cellseparator = ",\t";
  
  // copies the whole RT to an array of lines
  lines=split(File.openAsString("/data/PhD/IRX/Casparian_strip/grid_dimensions.csv"), lineseparator);
  
  // recreates the columns headers
  labels=split(lines[0], cellseparator);
  if (labels[0]==" ")
    k=1; // it is an ImageJ Results table, skip first column
    else
      k=0; // it is not a Results table, load all columns
      for (j=k; j<labels.length; j++)
        setResult(labels[j],0,0);
      
      // dispatches the data into the new RT
      run("Clear Results");
    for (i=1; i<lines.length; i++) {
      items=split(lines[i], cellseparator);
      for (j=k; j<items.length; j++)
        setResult(labels[j],i-1,items[j]);
    }
    updateResults();
  
  for(n = 0; n < nResults; n++){
    file = getResultString("file", n);
    folder = dir + file + "/";
    fileList = getFileList(folder);
    File.makeDirectory(folder + "background_corrected/");
    for(j=0;j<fileList.length;j++){
      if (endsWith(fileList[j], ".tif")) {
        open(folder+fileList[j]);
        open("/data/PhD/IRX/Casparian_strip/correction_stack.tif");
        imageCalculator("Add stack", fileList[j], "correction_stack.tif");
        saveAs("tif", folder + "background_corrected/" + fileList[j]);
        run("Close All");
      }
    }
  }
  setBatchMode(false);
}

macro "stitch seedlings" {
  setBatchMode(true);
  dir = getDirectory("Choose folder containing subfolders to be stitched");
  dir2 = getDirectory("Choose output folder");
  lineseparator = "\n";
  cellseparator = ",\t";
  
  // copies the whole RT to an array of lines
  lines=split(File.openAsString("/data/PhD/IRX/Casparian_strip/grid_dimensions.csv"), lineseparator);
  
  // recreates the columns headers
  labels=split(lines[0], cellseparator);
  if (labels[0]==" ")
    k=1; // it is an ImageJ Results table, skip first column
    else
      k=0; // it is not a Results table, load all columns
      for (j=k; j<labels.length; j++)
        setResult(labels[j],0,0);
      
      // dispatches the data into the new RT
      run("Clear Results");
    for (i=1; i<lines.length; i++) {
      items=split(lines[i], cellseparator);
      for (j=k; j<items.length; j++)
        setResult(labels[j],i-1,items[j]);
    }
    updateResults();
    
    for(n = 0; n < nResults; n++){
      file = getResultString("file", n);
      folder = dir + file + "/";
      fileList = getFileList(folder);
      rows = getResult("rows", n);
      cols = getResult("columns", n);
      run("Grid/Collection stitching", "type=[Unknown position] order=[All files in directory] directory=[" + folder + "background_corrected/] output_textfile_name=TileConfiguration.txt fusion_method=[Linear Blending] regression_threshold=0.50 max/avg_displacement_threshold=1.50 absolute_displacement_threshold=1.50 subpixel_accuracy computation_parameters=[Save computation time (but use more RAM)] image_output=[Fuse and display]");
      saveAs("tif", dir2 + file + "_stitched");
    }
  setBatchMode(false);
}
