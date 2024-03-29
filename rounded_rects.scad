/**************************************************
| Rounded corners are less prone to lifting than
| sharp corners. They also look nicer.
**************************************************/
use <QP_OpenSCAD_lib/shapes.scad>;
use <QP_OpenSCAD_lib/docSCAD.scad>;
use <QP_OpenSCAD_lib/common.scad>;

ff = 0.05;									// CSG fudge factor
$fs = 1.0;									// CSG segment size (mm)
$fa = 5;										// CSG minimum angle (degrees)

rounded_rects_help();
module rounded_rects_help()
{
	name = "rounded_rects.scad";
	description = str(
			"A library for drawing rounded primatives:\n",
			Bold("Stadium()"), " - 2D pill\n",
			Bold("ExtrudedStadium()"), " - extruded 2D pill\n",
			Bold("Capsule()"), " - 3D pill\n",
			Bold("RoundedRectangle()"), " - 2D rectangle with rounded corners\n",
			Bold("ExtrudedRoundedRectangle()"), " - extruded 2D rectangle with rounded corners\n",
			Bold("RoundedCube()"), " - 3D cube with rounded corners"
		);

	// new simple help defs
	members = [
		new_member(
			name="Stadium",
			parameters="rect, teardrop=false, center=false",
			description=[
				"Draws a stadium (2D pill).",
				Indent( List("x, y", "rect", "dimensions of smallest constraining rectangle") ),
				Indent( Boolean("teardrop", "for printability") ),
				Indent( Boolean("center", "position the first circle on the origin") )
			]
		),
		new_member(
			name="ExtrudedStadium",
			parameters="cube, tearDrop=false, center=false",
			description=[
				"Draws an extruded stadium.",
				Indent( List("x, y z", "cube", "dimensions of smallest constraining cuboid") ),
				Indent( Boolean("teardrop", "for printability") ),
				Indent( Boolean("center", "position the first cylinder on the origin") )
			]
		),
		new_member(
			name="Capsule",
			parameters="rect, teardrop = false",
			description=[
				"Draws a capsule (3D pill).",
				Indent( List("x, y", "rect", "dimensions of smallest constraining rectangle") ),
				Indent( Boolean("teardrop", "for printability") )
			]
		),
		new_member(
			name="RoundedRect",
			parameters="rect, cornerRadius, teardrop=false",
			description=[
				"Draws a 2D rectangle with rounded corners.",
				Indent( List("x, y", "rect", "dimensions of smallest constraining rectangle") ),
				Indent( Number("cornerRadius", "of 2D rectangle") ),
				Indent( Boolean("teardrop", "for printability") )
			]
		),
		new_member(
			name="ExtrudedRoundedRect",
			parameters="cube, cornerRadius, teardrop=false",
			description=[
				"Draws an extruded rounded rectangle.",
				Indent( List("x, y z", "cube", "dimensions of smallest constraining cuboid") ),
				Indent( Number("cornerRadius", "of 2D rectangle") ),
				Indent( Boolean("teardrop", "for printability") )
			]
		),
		new_member(
			name="RoundedCube",
			parameters="cube, cornerRadius, teardrop=false",
			description=[
				"Draws a rounded cuboid.",
				Indent( List("x, y, z", "cube", "dimensions of smallest constraining cuboid") ),
				Indent( Boolean("teardrop", "for printability") )
			]
		)
	];

	formatHelp_simple(
		libraryName=name,
		description=description,
		members=members
	);
}

//function rect_width(rect) =
//	min(rect[0], rect[1]);

//function corner_centres(length, width, radius) =
//	[[radius, radius], [radius, width-radius], [length-radius, width-radius], [length-radius, radius]];

function minimum_corner_radius(edge_clearance) =			// square peg/round hole problem
	edge_clearance / (sqrt(2)-1) + edge_clearance;

//Stadium([100, 20], true);
//!Stadium(center=true);
module Stadium(rect=[10, 30], teardrop = false, center=false)
{
	x = rect[0];
	y = rect[1];
	r = min(x, y)/2;

	hull()
	{
		translate(center ? [0, 0] : [r, r])
			if (teardrop)
				_teardrop_2D(r);
			else
				circle(r = r);
		if (x != y)
			translate(center ? [x-2*r, y-2*r] : [x-r, y-r])
			if (teardrop)
				_teardrop_2D(r);
			else
				circle(r = r);
	}
}

//Rounded_rectangle([30, 20], 5, true);
module RoundedRectangle(rect, cornerRadius, teardrop = false)
	Rounded_rectangle(rect=rect, corner_radius = cornerRadius, teardrop=teardrop);
module Rounded_rectangle(rect, corner_radius, teardrop = false)
{
	x = rect[0];
	y = rect[1];
	r = min(min(x, y)/2, corner_radius);
	d = 2*r;

	hull()
	{
		Stadium([d, y], teardrop);

		if (x > d)
			translate([x-d, 0])
				Stadium([d, y], teardrop);
	}
}

//!Extruded_stadium([30, 20, 8], true);
module ExtrudedStadium(cube, teardrop = false, center=false)
	Extruded_stadium(cube, teardrop, center);
module Extruded_stadium(cube, teardrop = false, center=false)
{
	x = cube[0];
	y = cube[1];
	z = cube[2];

	linear_extrude(height = z)
		Stadium([x, y], teardrop, center);
}

//Extruded_rounded_rectangle([20, 30, 10], 5, true);
module ExtrudedRoundedRect(cube, cornerRadius, teardrop = false)
	Extruded_rounded_rectangle(cube, cornerRadius, teardrop);
module Extruded_rounded_rectangle(cube, corner_radius, teardrop = false)
{
	x = cube[0];
	y = cube[1];
	z = cube[2];

	linear_extrude(height = z)
		Rounded_rectangle([x, y], corner_radius, teardrop);
}

//Capsule([10, 20], true);
module Capsule(rect, teardrop = false)
{
	x = rect[0];
	y = rect[1];
	r = min(x,y)/2;

	hull()
	{
		translate([r, r, r])
			if (teardrop)
				_teardrop(r = r, invert = true);
			else
				sphere(r = r);

		if (x != y)
			translate([x-r, y-r, r])
				if (teardrop)
					_teardrop(r = r, invert = true);
				else
					sphere(r = r);
	}
}

//_teardrop_2D(10);
module _teardrop_2D(r)
{
	intersection()
	{
		rotate(225)
			union()
			{
				circle(r = r);
					square(r);
			}
		square(2*r, center = true);
	}
}

//_teardrop(10, true);
module _teardrop(r, invert = false)
{
	mirror([0, 0, invert ? 1 : 0])
		intersection()
		{
			union()
			{
				sphere(r = r);
				translate([0, 0, r / sqrt(2)])
					cylinder(h = r/sqrt(2), r1 = r/sqrt(2), r2 = 0);
			}
			cube(2*r, center = true);
		} 
}

//Rounded_cube([10, 30, 35], 5, true);
module RoundedCube(cube, cornerRadius, teardrop = false)
	Rounded_cube(cube, cornerRadius, teardrop);
module Rounded_cube(cube, corner_radius, teardrop = false)
{
	x = cube[0];
	y = cube[1];
	z = cube[2];
	r = min(min(x, y, z)/2, corner_radius);
	d = 2*r;

	hull()
	{
		Capsule([d, y], teardrop);

		if (x > d)	// lower corners
			translate([x-d, 0, 0])
				Capsule([d, y], teardrop);

		if (z > d)	// upper corners
			translate([0, 0, z-d])
			{
				Capsule([d, y], teardrop);

				if (x > d)
					translate([x-d, 0, 0])
						Capsule([d, y], teardrop);
			}
	}
}

// version that uses toroids to allow different radii on horizontal and vertical axes
//!RoundedCube2(teardrop=true);
module RoundedCube2(cube=[100, 75, 50], hradius=5, vradius=1.5, teardrop=false)
{
	x = cube[0];
	y = cube[1];
	z = cube[2];
	hOffset = hradius+vradius;
	vOffset = vradius;
	
	hull()
		for (x=[hOffset, x-hOffset], y=[hOffset, y-hOffset], z=[vOffset, z-vOffset])
			translate([x, y, z])
					mirror([0, 0, 1]) Torus(R=hradius, r=vradius, teardrop=teardrop);
}


//**************

//rounded_pill(30, 10, 5);
module rounded_pill(length, width, height = ff)
{
	echo("<b>rounded_pill()</b> is deprecated; use <b>Extruded_stadium()</b>");
	
	l = length;
	w = width;
	h = height;

	r = w/2;

	translate([-l/2, -w/2, 0])
		Extruded_rounded_rectangle([l, w, h], r);
}

//rounded_rect(10, 20, 3);
module rounded_rect(length, width, corner_radius, height = ff)
{
	echo("<b>rounded_rect()</b> is deprecated; use <b>Extruded_rounded_rectangle()</b> instead");

	Extruded_rounded_rectangle([length, width, height], corner_radius);
}

//rounded_cube2([30, 20, 5], 5);
module rounded_cube2(cuboid, corner_radius = 0.01)
{
	echo("<b>rounded_cube2()</b> is deprecated; use <b>Extruded_rounded_rectangle()</b> instead");

	l = cuboid[0];
	w = cuboid[1];
	h = cuboid[2];
	r = corner_radius;

	Extruded_rounded_rectangle([l, w, h], r);
}

//rounded_cube([40, 30, 20], 5, true);
module rounded_cube(cuboid, corner_radius, teardrop = false)
// always draws a cube with minimum height = 2*corner_radius
{
	echo("<b>rounded_cube()</b> is deprecated; use <b>Rounded_cube()</b> instead");

	l = cuboid[0];
	w = cuboid[1];
	h = cuboid[2];
	r = corner_radius;

	Rounded_cube([l, w, h], r, teardrop);
}