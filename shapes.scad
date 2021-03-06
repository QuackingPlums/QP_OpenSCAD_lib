//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Non-primitive shapes
//

use <QP_OpenSCAD_lib/teardrops.scad>;				//teardrops_help();
use <QP_OpenSCAD_lib/docSCAD.scad>; 					docSCAD_help();
use <QP_OpenSCAD_lib/common.scad>;

module shapes_help()
	shapesHelp();

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

//!Torus(50, 15, true);
module Torus(R, r, teardrop=false, $fn=0)
{
	rotate_extrude()
		translate([R, 0, 0])
			if (teardrop)
				Teardrop(r, true);
			else
				circle(r);
}

//
!RoundedCylinder(h=30, r1=85, r2=85, r3=5, center=false);
module RoundedCylinder(h = 1, r1 = 1, r2 = 1, r3 = 1, center = false)
{
	hull()
	{
		// bottom torus
		position(
			mirror=[0,0,1],
			translate=[0,0,r3 - (center ? h/2 : 0)])
			Torus(R=max(r1-r3, r3), r=r3, teardrop=true);
		// top torus
		translate([0,0,(center ? h/2 : h) - r3])
			Torus(R=max(r2-r3, r3), r=r3);
	}
}
