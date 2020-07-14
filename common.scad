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

// ##### simple array mapping #####
// simple cube - assumes cube=[x,y,z]
function newCube(x, y, z) =
	[x, y, z];
function cubeX(cube) = cube[0];
function cubeY(cube) = cube[1];
function cubeZ(cube) = cube[2];

// simple rect; assumes rect=[x,y]
function newRect(x, y) =
	[x, y];
function rectX(rect) = rect[0];
function rectY(rect) = rect[1];

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
	formatHelp_simple(
		libraryName="common.scad",
		description="A library of commonly used modules and functions",
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
				name="newCube",
				description=["Returns a simple array type = [x, y, z]",
					Number("x", "x-dimension of cube"),
					Number("y", "y-dimension of cube"),
					Number("z", "z-dimension of cube")
				],
				parameters="x, y, z",
				returnValue="[x, y, z]"
			),
			new_member(
				name="cubeX",
				parameters="cube",
				description=["Returns x-dimension of cube",
					List("x, y, z", "cube", "array")
				],
				returnValue="x"
			),
			new_member(
				name="cubeY",
				parameters="cube",
				description=["Returns y-dimension of cube",
					List("x, y, z", "cube", "array")
				],
				returnValue="y"
			),
			new_member(
				name="cubeZ",
				parameters="cube",
				description=["Returns z-dimension of cube",
					List("x, y, z", "cube", "array")
				],
				returnValue="z"
			),
			new_member(
				name="newRect",
				description=["Returns a simple array type = [x, y]",
					Number("x", "x-dimension of rect"),
					Number("y", "y-dimension of rect")
				],
				parameters="x, y",
				returnValue="[x, y]"
			),
			new_member(
				name="rectX",
				parameters="rect",
				description=["Returns x-dimension of rect",
					List("x, y", "rect", "array")
				],
				returnValue="x"
			),
			new_member(
				name="rectY",
				parameters="rect",
				description=["Returns y-dimension of rect",
					List("x, y", "rect", "array")
				],
				returnValue="y"
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