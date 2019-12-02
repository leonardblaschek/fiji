//measure cell wall area in three concentric areas around the measurement centre
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
