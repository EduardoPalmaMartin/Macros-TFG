
/*
 * Macro realizada por: Manuela Vega Sánchez 
 * Servicio Central de Informática (UMA)
 * 
 * Para medir semillas en imágenes color
 * 
 */

input = getDirectory("Carpeta imagenes");
output = getDirectory("Carpeta forma");
output2 = getDirectory("Carpeta binarias");
suffix = ".jpg";

processFolder(input);
	
function processFolder(input) {
	list = getFileList(input);
	for (i = 0; i < list.length; i++) {
		if(File.isDirectory(input + list[i]))
			processFolder("" + input + list[i]);
		if(endsWith(list[i], suffix))
			processFile(input, output, list[i]);
	}
}

function processFile(input, output, file) {

		open(input + file);
		run("Duplicate..." , "title=original");
		selectWindow(file);


		run("8-bit");
		run("Smooth");
		run("Enhance Contrast...", "saturated=0.3 normalize");

		setThreshold(0, 150);
		run("Convert to Mask");
		run("Options...", "iterations=4 count=1 black do=Open");
		run("Fill Holes");
		

		/*waitForUser("Borre lo necesario");*/

		run("Set Scale...", "distance=189.6002 known=1 pixel=1 unit=mm global");
		run("Set Measurements...", "area perimeter shape feret's display redirect=None decimal=3");
		run("Analyze Particles...", "Size=2000-Infinity", "display exclude");

		saveAs("Jpeg", output2 + file);

		selectWindow(file);
		run("Create Selection");
		selectWindow("original");
		run("Restore Selection");
		run("Flatten");
		saveAs("Jpeg", output + file);
		
		run("Close All");
}

saveAs("Results", output + "ResultadosForma.txt");

