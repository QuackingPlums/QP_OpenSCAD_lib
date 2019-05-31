//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Useful tools and utilities
//

use <QP_OpenSCAD_lib/docSCAD.scad>; //docSCAD_help();

//polygons_help();
module polygons_help()
{
	name = "polygons.scad";
	description = "A library for creating 2D polygons.";
	properties = [
	];
	functions = [
	];
	modules = [
		new_help_item(
			"Regular_convex_polygon(r, n)",
			[	new_help_item_parameter("r", "number", "Radius of circumcircle"),
				new_help_item_parameter("n", "number", "Number of vertices")],
			"Draw a regular convex polygon with radius r (similar to circle with $fn=n)."),
		new_help_item(
			"Regular_concave_polygon(r1, r2, n)",
			[	new_help_item_parameter("r1", "number", "Radius of inner circumcircle"),
				new_help_item_parameter("r2", "number", "Radius of vertex circumcircle"),
				new_help_item_parameter("n", "number", "Number of points")],
			"Draw a regular concave n-point star-shaped polygon with inner radius r1, outer radius r2.")
	];

	format_help(
		name,
		description,
		properties,
		functions,
		modules
	);
}

//Regular_convex_polygon(50, 8);
module Regular_convex_polygon(r, n)
{
	Polygonize(point_cloud = convex_vertices(r = r, v = n));
}

//Regular_concave_polygon(5, 10, 12);
module Regular_concave_polygon(r1, r2, n)
{
	Polygonize(point_cloud = concave_vertices(r1 = r1, r2 = r2, v = n));
}

module Polygonize(point_cloud)
{
	paths = [[for (i = [0:len(point_cloud)-1])i]];		// echo(paths);
	polygon(points = point_cloud, paths = paths);
}

function convex_vertices(r = 5, v = 8) =
	[for (i = [0:v-1])
        [r*cos(360*i/v), r*sin(360*i/v)]
    ];

function concave_vertices(r1 = 5, r2 = 10, v = 16) =
	[for(i = [0:(2*v-1)])
		(i%2 == 0) ?
		[r1*cos(180*i/v),r1*sin(180*i/v)] :
		[r2*cos(180*i/v),r2*sin(180*i/v)]
	];
