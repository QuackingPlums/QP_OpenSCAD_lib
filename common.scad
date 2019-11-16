//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Useful tools and utilities
//

use <QP_OpenSCAD_lib/docSCAD.scad>; 					 docSCAD_help();

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

// DEPRECATE!
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

// DEPRECATE!
function rms(a, b) = 
	sqrt(pow(a, 2) + pow(b, 2));

function RootSumOfSquares(a, b) = 
	sqrt(pow(a, 2) + pow(b, 2));

function RootDifferenceOfSquares(a, b) =
	sqrt(pow(a, 2) - pow(b, 2));

module debug()
{
	#children();
}

common_help();
module common_help()
{
	name = "common.scad";
	description = "A library of commonly used modules and functions";
	types=[];
	accessors=[
		new_help_item(
			signature="circle_x(circle)",
			description="Returns x-coordinate of circle"),
		new_help_item(
			signature="circle_y(circle)",
			description="Returns y-coordinate of circle"),
		new_help_item(
			signature="circle_diameter(circle)",
			description="Returns diameter of circle"),
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
			"Returns length of cube along z-axis")
	];
	properties = [];
	functions = [
		new_help_item(
			"new_circle(x, y, diameter)",
			[	new_help_item_parameter("x", "number", "x-coordinate of circle centre"),
				new_help_item_parameter("y", "number", "y-coordinate of circle centre"),
				new_help_item_parameter("diameter", "number", "diameter of circle")],
			"Returns a new circle type = [x, y, diameter]"),
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
			"new_cube(x, y, z, dx, dy, dz)",
			[	new_help_item_parameter("x", "number", "x-coordinate of cuboid"),
				new_help_item_parameter("y", "number", "y-coordinate of cuboid"),
				new_help_item_parameter("z", "number", "z-coordinate of cuboid"),
				new_help_item_parameter("dx", "number", "length of cuboid along x-axis"),
				new_help_item_parameter("dy", "number", "length of cuboid along y-axis"),
				new_help_item_parameter("dz", "number", "length of cuboid along z-axis")],
			"Returns a new cuboid type = [x, y, z, dx, dy, dz]"),
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

//	format_help(
//		name=name,
//		description=description,
//		types=types,
//		accessors=accessors,
//		properties=properties,
//		functions=functions,
//		modules=modules);

	formatHelp_simple(
		libraryName=name,
		description=description,
		members=
		[
			new_member(
				name="new_circle",
				description=["Returns a new circle type = [x, y, diameter]",
					Number("x", "x-coordinate of circle centre"),
					Number("y", "y-coordinate of circle centre"),
					Number("diameter", "diameter of circle")
				],
				parameters="x, y, diameter",
				returnValue="circle type"
			),
			new_member(
				name="circle_x",
				parameters="circle",
				description=["Returns x-coordinate of circle centre",
					List("x, y, diameter", "circle", "circle type")
				],
				returnValue="x"
			),
			new_member(
				name="circle_y",
				parameters="circle",
				description=["Returns y-coordinate of circle centre",
					List("x, y, diameter", "circle", "circle type")
				],
				returnValue="y"
			),
			new_member(
				name="circle_diameter",
				parameters="circle",
				description=["Returns diameter of circle",
					List("x, y, diameter", "circle", "circle type")
				],
				returnValue="diameter"
			),
			new_member(
				name="new_cyl",
				description=["Returns a new cyl type = [x, y, height, diameter]",
					Number("x", "x-coordinate of cyl centre"),
					Number("y", "y-coordinate of cyl centre"),
					Number("height", "height of cyl"),
					Number("diameter", "diameter of cyl")
				],
				parameters="x, y, height, diameter",
				returnValue="cyl type"
			),
			new_member(
				name="cyl_x",
				parameters="cyl",
				description=["Returns x-coordinate of cyl centre",
					List("x, y, height, diameter", "cyl", "cyl type")
				],
				returnValue="x"
			),
			new_member(
				name="cyl_y",
				parameters="cyl",
				description=["Returns y-coordinate of cyl centre",
					List("x, y, height, diameter", "cyl", "cyl type")
				],
				returnValue="y"
			),
			new_member(
				name="cyl_height",
				parameters="cyl",
				description=["Returns height of cyl",
					List("x, y, height, diameter", "cyl", "cyl type")
				],
				returnValue="height"
			),
			new_member(
				name="cyl_diameter",
				parameters="cyl",
				description=["Returns diameter of cyl",
					List("x, y, height, diameter", "cyl", "cyl type")
				],
				returnValue="diameter"
			),
			new_member(
				name="new_rect",
				description=["Returns a new rect type = [x, y, dx, dy]",
					Number("x", "x-coordinate of rect origin"),
					Number("y", "y-coordinate of rec origin"),
					Number("dx", "x-dimension of rect"),
					Number("dy", "y-dimension of rect")
				],
				parameters="x, y, dx, dy",
				returnValue="rect type"
			),
			new_member(
				name="rect_x",
				parameters="rect",
				description=["Returns x-coordinate of rect origin",
					List("x, y, dx, dy", "rect", "rect type")
				],
				returnValue="x"
			),
			new_member(
				name="rect_y",
				parameters="rect",
				description=["Returns y-coordinate of rect origin",
					List("x, y, dx, dy", "rect", "rect type")
				],
				returnValue="y"
			),
			new_member(
				name="rect_dx",
				parameters="rect",
				description=["Returns x-dimension of rect",
					List("x, y, dx, dy", "rect", "rect type")
				],
				returnValue="dx"
			),
			new_member(
				name="rect_dy",
				parameters="rect",
				description=["Returns y-dimension of rect",
					List("x, y, dx, dy", "rect", "rect type")
				],
				returnValue="dy"
			),
			new_member(
				name="new_cube",
				description=["Returns a new cube type = [x, y, z, dx, dy, dz]",
					Number("x", "x-coordinate of cube origin"),
					Number("y", "y-coordinate of cube origin"),
					Number("z", "z-coordinate of cube origin"),
					Number("dx", "x-dimension of cube"),
					Number("dy", "y-dimension of cube"),
					Number("dz", "z-dimension of cube")
				],
				parameters="x, y, z, dx, dy, dz",
				returnValue="cube type"
			),
			new_member(
				name="cube_x",
				parameters="cube",
				description=["Returns x-coordinate of cube origin",
					List("x, y, z, dx, dy, dz", "cube", "cube type")
				],
				returnValue="x"
			),
			new_member(
				name="cube_y",
				parameters="cube",
				description=["Returns y-coordinate of cube origin",
					List("x, y, z, dx, dy, dz", "cube", "cube type")
				],
				returnValue="y"
			),
			new_member(
				name="cube_z",
				parameters="cube",
				description=["Returns z-coordinate of cube origin",
					List("x, y, z, dx, dy, dz", "cube", "cube type")
				],
				returnValue="z"
			),
			new_member(
				name="cube_dx",
				parameters="cube",
				description=["Returns x-dimension of cube",
					List("x, y, z, dx, dy, dz", "cube", "cube type")
				],
				returnValue="dx"
			),
			new_member(
				name="cube_dy",
				parameters="cube",
				description=["Returns y-dimension of cube",
					List("x, y, z, dx, dy, dz", "cube", "cube type")
				],
				returnValue="dy"
			),
			new_member(
				name="cube_dz",
				parameters="cube",
				description=["Returns z-dimension of cube",
					List("x, y, z, dx, dy, dz", "cube", "cube type")
				],
				returnValue="dz"
			),
			new_member(
				name="position",
				parameters="translate=[], rotate=[], mirror=[0, 0, 0], colour",
				description=["Applies a combination of colour, mirror, rotate and translate, in that order, to all children",
					List("x, y, z", "translate", "3-axis translation vector"),
					List("°x, °y, °z", "rotate", "Angles of rotation along each axis"),
					List("x, y, z", "mirror", "Normal vector of a plane intersecting the origin through which to mirror"),
					String("colour", "W3C CSS3 colour name or hex value")
				]
			),
			new_member(
				name="is_in",
				parameters="match_string, search_set",
				description=["Returns true if match_string found in search_set, false otherwise",
					String("match_string", "string to search for - e.g.: &quot;one&quot;"),
					List("strings", "search_set", "list of strings to search - e.g.: [[&quot;one&quot;],[&quot;two&quot;], [&quot;three&quot;]]")
				]
			),
			new_member(
				name="RootSumOfSquares",
				parameters="a, b",
				description=["Returns &radic;(a&sup2; + b&sup2;) (e.g.: Pythagoras)",
					Number("a", ""),
					Number("b", "")
				]
			),
			new_member(
				name="RootDifferenceOfSquares",
				parameters="a, b",
				description=["Returns &radic;(a&sup2; - b&sup2;) (e.g.: Pythagoras)",
					Number("a", ""),
					Number("b", "")
				]
			),
			new_member(
				name="debug",
				description=["Apply debug modifier (#) to all children"
				]
			)
		]
	);
}