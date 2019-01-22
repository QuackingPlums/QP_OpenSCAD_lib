//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Non-primitive shapes
//

use <docSCAD.scad>; 					docSCAD_help();

shapesHelp();
module shapesHelp()
{
	name = "shapes.scad";
	description = "A library for creating non-primative shapes.";
	properties = [
	];
	functions = [
	];
	modules = [
		new_help_item(
			"Torus(R, r)",
			[	new_help_item_parameter("R", "number", "Major radius"),
				new_help_item_parameter("r", "number", "Minor radius"),
				new_help_item_parameter("$fn", "number", "arc facets (default: 0)")],
			"Draw a regular solid torus with major radius R and minor radius r.")
	];

	*formatHelp(
		name,
		description,
		properties,
		functions,
		modules
	);

	formatHelp_simple(
		libraryName = name,
		description = description,
		members = [
			new_member(
				name="Torus",
				parameters="R, r, $fn=0",
				description=[
					Number("R", "Major radius"),
					Number("r", "Minor radius"),
					Number("$fn", "Number of arc facets")
				]
			)
		]
	);
}

//Torus(50, 15);
module Torus(R, r, $fn=0)
{
	rotate_extrude()
		translate([R, 0, 0])
			circle(r);
}