//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Common ABS colours
//
use <QP_OpenSCAD_lib/docSCAD.scad>;				//docSCAD_help();

CDW_ABS_Black = "DimGrey";
CDW_ABS_Fl_Yellow = "Yellow";
CDW_ABS_Lt_Green = "SpringGreen";
CDW_ABS_Grey = "Silver";
CDW_ABS_Red = "IndianRed";
CDW_ABS_White = "White";
CDW_ABS_Yellow = "Gold";

BF66_ABS_Black = "DimGrey";
BF66_ABS_Blue = "DodgerBlue";//?
BF66_ABS_White = "White";

ES_ABS_Clear = "GhostWhite";//?
ES_ABS_Green = "Lime";//?
ES_ABS_Orange = "Orange";//?
ES_ABS_Purple = "Purple";//?
ES_ABS_Yellow = "Yellow";//?

CDW_PLA_Blue = "Blue";
CDW_PLA_Orange = "DarkOrange";

FDY_PLA_Cl_Black = "DimGrey";
FDY_PLA_Pr_Purple = "Indigo";
FDY_PLA_Vl_Green = "Green";

//filaments_help();
module filaments_help()
	formatHelp_simple(
	libraryName="filaments_h.scad",
	description=str(
		"Constants for common filament colours:",
		"<p>",
		"CDW_ABS_Black<br>",
		"CDW_ABS_Fl_Yellow<br>",
		"CDW_ABS_Lt_Green<br>",
		"CDW_ABS_Grey<br>",
		"CDW_ABS_Red<br>",
		"CDW_ABS_White<br>",
		"CDW_ABS_Yellow<br>",
		"<br>",
		"BF66_ABS_Black<br>",
		"BF66_ABS_Blue<br>",
		"BF66_ABS_White<br>",
		"<br>",
		"ES_ABS_Clear<br>",
		"ES_ABS_Green<br>",
		"ES_ABS_Orange<br>",
		"ES_ABS_Purple<br>",
		"ES_ABS_Yellow<br>",
		"<br>",
		"CDW_PLA_Blue<br>",
		"CDW_PLA_Orange<br>",
		"<br>",
		"FDY_PLA_Cl_Black<br>",
		"FDY_PLA_Pr_Purple<br>",
		"FDY_PLA_Vl_Green<br>")
  );
