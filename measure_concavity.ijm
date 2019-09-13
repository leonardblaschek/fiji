// measure concavity of 15 ROIs from the poplar pipleine
macro "Measure concavity [n5]" {
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
