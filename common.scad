//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Useful tools and utilities
//

use <docSCAD.scad>; //docSCAD_help();

/*
is_in("two", [["one"], ["two"], ["three"]])
Returns true if match_value is found in set, false otherwise

module position(translate = [], rotate = [], colour = -1)
Rotate, translate and colour an arbitrary list of objects. In that order
translate		coordinate vector
rotate    		axis angles
colour   		any valid w3/css3 colour name

module show_build_area(x = 196, y = 196, corner_radius = 18)
Draw (non-printing) build platform template
Useful for plating up objects.
Default to Mendel90 with IKEA SÖRLI mirror tile.
x				x dimension
y				y dimension
corner_radius	20mm for SÖRLI

module slot(length, width, depth)
Subtractive rounded-end slot shape to fit within given dimensions
length			length of slot including radii
width			width of slot
depth			depth of slot
*/

//common_help();
module common_help()
{
	name = "common.scad";
	description = "A library of commonly used modules and functions";
	properties = [];
	functions = [
		new_help_item(
			"new_circle(x, y, diameter)",
			[	new_help_item_parameter("x", "number", "x-coordinate of circle centre"),
				new_help_item_parameter("y", "number", "y-coordinate of circle centre"),
				new_help_item_parameter("diameter", "number", "diameter of circle")],
			"Returns a new circle type = [x, y, diameter]"),
		new_help_item(
			"circle_x(circle)",
			[],
			"Returns x-coordinate of circle"),
		new_help_item(
			"circle_y(circle)",
			[],
			"Returns y-coordinate of circle"),
		new_help_item(
			"circle_diameter(circle)",
			[],
			"Returns diameter of circle"),
		new_help_item(
			"new_cyl(x, y, height, diameter)",
			[	new_help_item_parameter("x", "number", "x-coordinate of cylinder centre"),
				new_help_item_parameter("y", "number", "y-coordinate of cylinder centre"),
				new_help_item_parameter("height", "number", "height of cylinder"),
				new_help_item_parameter("diameter", "number", "diameter of cylinder")],
			"Returns a new cylinder type = [x, y, height, diameter]"),
		new_help_item(
			"new_rect(x, y, dx, dy)",
			[	new_help_item_parameter("x", "number", "x-coordinate of rectangle"),
				new_help_item_parameter("y", "number", "y-coordinate of rectangle"),
				new_help_item_parameter("dx", "number", "length of rectangle along x-axis"),
				new_help_item_parameter("dy", "number", "length of rectangle along y-axis")],
			"Returns a new rectangle type = [x, y, dx, dy]"),
		new_help_item(
			"rect_x(rect)",
			[],
			"Returns x-coordinate of rectangle"),
		new_help_item(
			"rect_y(rect)",
			[],
			"Returns y-coordinate of rectangle"),
		new_help_item(
			"rect_dx(rect)",
			[],
			"Returns length of rectangle along x-axis"),
		new_help_item(
			"rect_dy(rect)",
			[],
			"Returns length of rectangle along y-axis"),
		new_help_item(
			"new_cube(x, y, z, dx, dy, dz)",
			[	new_help_item_parameter("x", "number", "x-coordinate of cuboid"),
				new_help_item_parameter("y", "number", "y-coordinate of cuboid"),
				new_help_item_parameter("z", "number", "z-coordinate of cuboid"),
				new_help_item_parameter("dx", "number", "length of cuboid along x-axis"),
				new_help_item_parameter("dy", "number", "length of cuboid along y-axis"),
				new_help_item_parameter("dz", "number", "length of cuboid along z-axis")],
			"Returns a new cuboid type = [x, y, z, dx, dy, dz]"),
		new_help_item(
			"cube_x(cube)",
			[],
			"Returns x-coordinate of cube"),
		new_help_item(
			"cube_y(cube)",
			[],
			"Returns y-coordinate of cube"),
		new_help_item(
			"cube_z(cube)",
			[],
			"Returns z-coordinate of cube"),
		new_help_item(
			"cube_dx(cube)",
			[],
			"Returns length of cube along x-axis"),
		new_help_item(
			"cube_dy(cube)",
			[],
			"Returns length of cube along y-axis"),
		new_help_item(
			"cube_dz(cube)",
			[],
			"Returns length of cube along z-axis"),
		new_help_item(
			"is_in(match_string, search_set)",
			[	new_help_item_parameter("match_string", "string", "string to search for - e.g. &quot;one&quot;"),
				new_help_item_parameter("search_set", "list of strings", "set of strings to search - e.g. [[&quot;one&quot;],[&quot;two&quot;],[&quot;three&quot;]]")],
			"Returns true if match_string found in search_set, false otherwise")
	];
	modules = [
		new_help_item(
			"position(translate, rotate, mirror, colour)",
			[	new_help_item_parameter("translate", "[x, y, z]", "3-axis translation vector"),
				new_help_item_parameter("rotate", "[x, y, z]", "simple angle of rotation along each axis"),
				new_help_item_parameter("mirror", "[x, y, z]", "normal vector of plane intersecting origin through which to mirror all children"),
				new_help_item_parameter("colour", "string", "Standard OpenSCAD colour name")],
			"Combination colour, mirror, rotate and translate transformation, in that order")
	];

	format_help(name, description, properties, functions, modules);
}

function new_circle(x, y, diameter) =
	[x, y, diameter];
function circle_x(circle) = circle[0];
function circle_y(circle) = circle[1];
function circle_diameter(circle) = circle[2];

function new_cyl(x, y, height, diameter) =
	[x, y, height, diameter];
function cyl_x(cyl) = cyl[0];
function cyl_y(cyl) = cyl[1];
function cyl_height(cyl) = cyl[2];
function cyl_diameter(cyl) = cyl[3];

function new_rect(x, y, dx, dy) =
	[x, y, dx, dy];
function rect_x(rect) = rect[0];
function rect_y(rect) = rect[1];
function rect_dx(rect) = rect[2];
function rect_dy(rect) = rect[3];

function new_cube(x, y, z, dx, dy, dz) =
	[x, y, z, dx, dy, dz];
function cube_x(cube) = cube[0];
function cube_y(cube) = cube[1];
function cube_z(cube) = cube[2];
function cube_dx(cube) = cube[3];
function cube_dy(cube) = cube[4];
function cube_dz(cube) = cube[5];

//echo(is_in("two", [["one"], ["two"], ["three"]]));
function is_in(match_string = "findme", search_set = [["string1"], ["string2"], ["string3"]]) =
	( search([match_string], search_set) == [[]] ) ? false : true;
 
module position(translate = [], rotate = [], mirror = [0, 0, 0], colour)
{
	for (i = [0 : $children-1])
		translate(translate)
			rotate(rotate)
				mirror(mirror)
					if (colour == undef)
						children(i);
					else
						color(colour)
							children(i);
}

module slot(length, width, depth)
{
	echo("DEPRECATED: use rounded_rects instead.");

	hull()
	{
		cylinder(h = depth, r = width/2);
		translate([length - width, 0, 0])
			cylinder(h = depth, r = width/2);
	}
}

// this is wrong!
function rms(a, b) = 
	sqrt(pow(a, 2) + pow(b, 2));

module debug()
{
	#children();
}