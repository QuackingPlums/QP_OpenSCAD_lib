/**************************************************
| Rounded corners are less prone to lifting than
| sharp corners. They also look nicer.
**************************************************/
use <common.scad>;

ff = 0.05;

// ***** examples *****

// 2-dimensional rounded rect
//rounded_rect(length = 30, width = 20, corner_radius = 5);

// rounded rect with height
//rounded_rect(length = 30, width = 20, corner_radius = 5, height = 5);
//rounded_cube2([30, 20, 5], 5);

// regular cuboid with chamfered edges
//rounded_cube([20, 30, 10], corner_radius = 3);

// regular cuboid with chamfered edges and teardrop base
//rounded_cube([20, 30, 10], corner_radius = 3, teardrop = true);

// 2-dimensional rounded pill
//rounded_pill(length = 30, width = 10);

// rounded pill with height
//rounded_pill(length = 30, width = 10, height = 5);

function format_help(command_type, command, description = "") = 
	str("<p>", command_type, " <b>", command, "</b><br><i>", description, "</i>");
function format_module(command, description) =
	format_help("module", command, description);
function format_function(command, description) =
	format_help("function", command, description);

module _help(name, description, examples, deprecated)
{
	echo(str( "<h3>", name, "</h3><br>", description ));
	echo("<h3>Examples</h3>");
	for (i = [0:len(examples)-1])
		echo(examples[i]);
	echo("<h3>Deprecated</h3>");
	for (i = [0:len(deprecated)-1])
		echo(deprecated[i]);
}

rounded_rects_help();
module rounded_rects_help()
{
	name = "rounded_rects.scad";
	description = "A library for creating rounded rectangles and cuboids.";
	examples = [
		format_module("Stadium([rect])", "2D pill shape"),
		format_module("Rounded_rectangle([rect], corner_radius)", "2D rectangle with rounded corners"),
		format_module("Extruded_rounded_rectangle([cube], corner_radius)", "Extruded 2D rectangle with rounded corners"),
		format_module("Capsule([rect], teardrop = false)", "3D pill shape"),
		format_module("Rounded_cube([cube], corner_radius, teardrop)", "3D cuboid with rounded corners and optional teardrop lower edge profile")];
	deprecated = [format_module("rounded_pill()", "blah")];

	_help(
		name,
		description,
		examples,
		deprecated
	);

*	echo(str(	
		"<p><h2>Name</h2>",
		"<p><b>rounded_rects.scad</b> - create rounded primitives",
		"<p><h2>Examples</h2>",
		format_help("Rounded_rectangle()", "blah"),
		"<p>Extruded_rounded_rectangle()",
		"<p>Rounded_cube()",
		"<p><h2>Deprecated</h2>",
	"</p>"));
}

function rect_width(rect) =
	min(rect[0], rect[1]);

function corner_centres(length, width, radius) =
	[[radius, radius], [radius, width-radius], [length-radius, width-radius], [length-radius, radius]];

function minimum_corner_radius(edge_clearance) =			// square peg/round hole problem
	edge_clearance / (sqrt(2)-1) + edge_clearance;

//Stadium([100, 20]);
module Stadium(rect)
{
	x = rect[0];
	y = rect[1];
	r = min(x, y)/2;

	hull()
	{
		translate([r, r])
			circle(r = r);
		if (x != y)
			translate([x-r, y-r])
				circle(r = r);
	}
}

//Rounded_rectangle([20, 10], 4);
module Rounded_rectangle(rect, corner_radius)
{
	x = rect[0];
	y = rect[1];
	r = min(min(x, y)/2, corner_radius);
	d = 2*r;

	hull()
	{
		Stadium([d, y]);

		if (x > d)
			translate([x-d, 0])
				Stadium([d, y]);
	}
}

//Extruded_rounded_rectangle([20, 30, 10], 5);
module Extruded_rounded_rectangle(cube, corner_radius)
{
	x = cube[0];
	y = cube[1];
	z = cube[2];

	linear_extrude(height = z)
		Rounded_rectangle([x, y], corner_radius);
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




//**************

rounded_pill(30, 10, 5);
module rounded_pill(length, width, height = ff)
{
	echo("<b>rounded_pill()</b> is deprecated; use <b>Rounded_rectangle()</b>");
	
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
	echo("<b>rounded_rect()</b> is deprecated; use <b>Rounded_rectangle()</b> instead");

	Extruded_rounded_rectangle([length, width, height], corner_radius);
}

//rounded_cube2([30, 20, 5], 5);
module rounded_cube2(cuboid, corner_radius = 0.01)
{
	echo("<b>rounded_cube2()</b> is deprecated; use <b>Rounded_rectangle()</b> instead");

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