
/*
 * Macro realizada por: Manuela Vega Sánchez 
 * Servicio Central de Informática (UMA)
 * 
 * Para medir intensidad HSB en semillas
 * 
 */

input = getDirectory("Carpeta imagenes");
output = getDirectory("Carpeta binarias");
output2 = getDirectory("Carpeta color HSB");
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
		run("Smooth");
		run("HSB Stack");
		run("Stack to Images");
		selectWindow("Hue");
		rename("H" + file);
		selectWindow("Saturation");
		rename("S" + file);
		selectWindow("Brightness");
		rename("B" + file);

		open(output + file);

		run("Make Binary");

		run("Set Scale...", "distance=189.6002 known=1 pixel=1 unit=mm global");
		
		run("Set Measurements...", "area mean standard min display redirect=[H" + file + "] decimal=3");
		run("Analyze Particles...", "Size=2000-Infinity", "display exclude");

		run("Set Measurements...", "area mean standard min display redirect=[S" + file + "] decimal=3");
		run("Analyze Particles...", "Size=2000-Infinity", "display exclude");

		run("Set Measurements...", "area mean standard min display redirect=[B" + file + "] decimal=3");
		run("Analyze Particles...", "Size=2000-Infinity", "display exclude");
		
		run("Close All");
}

saveAs("Results", output2 + "ResultadosHSB.txt");

