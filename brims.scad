/**************************************************
| Brims can reduce the lifting at sharp corners and
| edges, especially when printing near the edge of
| the heated bed where colder air can reduce
| adhesion.
**************************************************/
use <docSCAD.scad>;	docSCAD_help();
use <common.scad>;

ff = 0.05;					// CSG fudge factor
$fs = 1.0;					// CSG segment size (mm)
$fa = 5;						// CSG minimum angle (degrees)

default_layer_height = 0.2;
default_brim_radius = 10.0;

brim_quarter_turns = [0, 90, 180, 270];

function brim_quadrant(quadrant) = 
	quadrant >= 0 ? brim_quarter_turns[quadrant-1] : 0;

function brim_edge(edge="N") =
	edge=="N" ? brim_quarter_turns[0] :
		edge=="W" ? brim_quarter_turns[1]  :
			edge=="S" ? brim_quarter_turns[2]  :
				edge=="E" ? brim_quarter_turns[3] : 0;

//Corner_brim(radius=50, quadrant=2);
module Corner_brim(radius=default_brim_radius, quadrant=1, height=default_layer_height)
{
	h = height;
	r = radius;
	q = brim_quadrant(quadrant);

	rotate([0, 0, q])
		difference()
		{
			cylinder(h=h, r=r);
			translate([-r-ff, -r-ff, -ff/2])
				cube([r, r, h+ff]);
		}
}

//Edge_brim(radius=50, edge="W");
module Edge_brim(radius=default_brim_radius, edge="N", height=default_layer_height)
{
	h = 0.2;
	r = radius;
	e = brim_edge(edge);

	rotate([0, 0, e])
		difference()
		{
			cylinder(h=h, r=r);
			translate([-r-ff/2, -r-ff, -ff/2])
				cube([2*r+ff, r, h+ff]);
		}
}

brims_help();
module brims_help()
{
	format_help(
		name="brims.scad",
		description="A library for creating brims that can help prevent lifting",
		modules=[
			new_help_item(
				signature="Corner_brim(radius=default_brim_radius, quadrant=1, height=default_layer_height)",
				parameters=[
					new_help_item_parameter(name="radius", type="number", description="Brim radius"),
					new_help_item_parameter(name="quadrant", type="number", description="Quadrant identifier"),
					new_help_item_parameter(name="height", type="number", description="Layer height")
				],
				description="Three-quarter circle brim, one layer high"
			),
			new_help_item(
				signature="Edge_brim(radius=default_brim_radius, edge=\"N\", height=default_layer_height)",
				parameters=[
					new_help_item_parameter(name="radius", type="number", description="Brim radius"),
					new_help_item_parameter(name="edge", type="string", description="Cardinal point identifier (\"N\", \"E\", \"S\" or \"W\")"),
					new_help_item_parameter(name="height", type="number", description="Layer height")
				],
				description="Semi-circle brim, one layer high"
			)
		]
	);
}