/**************************************************
| Generic board definition
| 
**************************************************/
use <QP_OpenSCAD_lib/rounded_rects.scad>;

ff = 0.05;					// CSG fudge factor
$fn = 24;					// curve complexity

// main board dimensions
function new_pcb_dimensions(x_len, y_len, thick, below_h, above_h, corner_radius=0) =
	[x_len, y_len, thick, below_h, above_h, corner_radius];
function pcb_x_len(pcb_dimensions) = pcb_dimensions[0];			// x dimension
function pcb_y_len(pcb_dimensions) = pcb_dimensions[1];			// y dimension
function pcb_thick(pcb_dimensions) = pcb_dimensions[2];			// board thickness
function pcb_legs(pcb_dimensions) = pcb_dimensions[3];				// standoff height
function pcb_components(pcb_dimensions) = pcb_dimensions[4];		// minimum component height (used for case lids etc)
function pcb_corner_radius(pcb_dimensions) = pcb_dimensions[5];	// rounded corners?
function pcb_board_cube(pcb_dimensions) =
	[pcb_x_len(pcb_dimensions), pcb_y_len(pcb_dimensions), pcb_thick(pcb_dimensions)];


// corner holes
function new_pcb_hole(location, diameter) =
	[location, diameter];
function pcb_hole_location(pcb_hole) = pcb_hole[0];
function pcb_hole_diameter(pcb_hole) = pcb_hole[1];

// square component
function new_pcb_square_component(location, cube, colour = "DimGrey") =
	[location, cube, colour];
function pcb_square_component_location(pcb_square_component) = pcb_square_component[0];
function pcb_square_component_cube(pcb_square_component) = pcb_square_component[1];
function pcb_square_component_colour(pcb_square_component) = pcb_square_component[2];

// cylindrical component
function new_pcb_round_component(location, height, diameter, colour = "Silver") =
	[location, height, diameter, colour];
function pcb_round_component_location(pcb_round_component) = pcb_round_component[0];
function pcb_round_component_height(pcb_round_component) = pcb_round_component[1];
function pcb_round_component_diameter(pcb_round_component) = pcb_round_component[2];
function pcb_round_component_colour(pcb_round_component) = pcb_round_component[3];

/***** use these when defining cases & lids *****/

// connectors (separate from components because they always exit the case)
function new_pcb_square_connector(x, y, dx, dy) =
	[x, y, dx, dy];
function pcb_square_connector_x(pcb_square_connector) = pcb_square_connector[0];
function pcb_square_connector_y(pcb_square_connector) = pcb_square_connector[1];
function pcb_square_connector_dx(pcb_square_connector) = pcb_square_connector[2];
function pcb_square_connector_dy(pcb_square_connector) = pcb_square_connector[3];

// standoff (leg clearance)
function new_pcb_standoff(location, cube) =
	[location, cube];
function standoff_location(standoff) = standoff[0];
function standoff_cube(standoff) = standoff[1];

// lid support
function new_lid_support(location, cube) =
	[location, cube];
function lid_support_location(lid_support) = lid_support[0];
function lid_support_cube(lid_support) = lid_support[1];


// coordinate system
function new_location(x, y, z) = [x, y, z];
function location_x(location) = location[0];
function location_y(location) = location[1];
function location_z(location) = location[2];

// cube def
function new_cube(x, y, z) = [x, y, z];
function cube_x(cube) = cube[0];
function cube_y(cube) = cube[1];
function cube_z(cube) = cube[3];

// cylinder def
function new_cylinder(h, r) = [h, r];
function cylinder_h(cylinder) = cylinder(0);
function cylinder_r(cylinder) = cylinder(1);

// builder
function new_pcb(dimensions, holes, square_components, round_components, standoffs, lid_supports, square_connectors) =
	[dimensions, holes, square_components, round_components, standoffs, lid_supports, square_connectors];
function pcb_dimensions(pcb) = pcb[0];
function pcb_holes(pcb) = pcb[1];
function pcb_square_components(pcb) = pcb[2];
function pcb_round_components(pcb) = pcb[3];
function pcb_standoffs(pcb) = pcb[4];
function pcb_lid_supports(pcb) = pcb[5];
function pcb_square_connectors(pcb) = pcb[6];

// colours
function pcb_green() = "DarkGreen";

example();	// melzi board
module example()
{
	x = 210;
	y = 50;
	t = 2.0;
	corner_radius = 5;
	hole_edge_offset = corner_radius;

	pcb_dimensions = new_pcb_dimensions(x_len = x, y_len = y, thick = t, corner_radius = corner_radius);echo(pcb_dimensions);
	pcb_holes = [
		new_pcb_hole(new_location(hole_edge_offset, hole_edge_offset), 3),
		new_pcb_hole(new_location(hole_edge_offset, y-hole_edge_offset), 3),
		new_pcb_hole(new_location(x-hole_edge_offset, y-hole_edge_offset), 3),
		new_pcb_hole(new_location(x-hole_edge_offset, hole_edge_offset), 3)];
	pcb = new_pcb(dimensions = pcb_dimensions, holes = pcb_holes);
	Board(pcb = pcb, debug=true);
}

// board model for viewing purposes
module Board(pcb, debug=false)
{
	pcb_dimensions = pcb_dimensions(pcb);
	pcb_thick = pcb_thick(pcb_dimensions);
	pcb_corner_radius = pcb_corner_radius(pcb_dimensions);
	pcb_holes = pcb_holes(pcb);
	pcb_square_components = pcb_square_components(pcb);
	pcb_round_components = pcb_round_components(pcb);

	br = "<br>";

	if (debug)	echo(str("DEBUG INFO:", br,
		"pcb=", pcb, br,
		"pcb_dimensions= ", pcb_dimensions, br,
		"pcb_thick= ", pcb_thick, br,
		"pcb_corner_radius= ", pcb_corner_radius, br,
		"pcb_holes= ", pcb_holes, br,
		"pcb_square_components= ", pcb_square_components, br,
		"pcb_round_components= ", pcb_round_components, br
	));

	difference()
	{
		// main board
		color(pcb_green())
			Extruded_rounded_rectangle(pcb_board_cube(pcb_dimensions), pcb_corner_radius);

		// holes
		for(i = [0:len(pcb_holes(pcb))-1])
			translate([0, 0, -ff/2])
				translate(pcb_hole_location(pcb_holes[i]))
					cylinder( h = pcb_thick+ff, d = pcb_hole_diameter(pcb_holes[i]) );
	}

	// square components
	for (i = [0 : len(pcb_square_components)-1])
		translate([0, 0, pcb_thick-ff])
			Square_component(pcb_square_components[i]);

	// round components
	for (i = [0 : len(pcb_round_components)-1])
		translate([0, 0, pcb_thick-ff])
			Round_component(pcb_round_components[i]);


}

module Square_component(component)
{
	location = pcb_square_component_location(component);
	cube = pcb_square_component_cube(component);
	colour = pcb_square_component_colour(component);

	translate(location)
		color(colour) cube(cube);
}

module Round_component(component)
{
	location = pcb_round_component_location(component);
	height = pcb_round_component_height(component);
	diameter = pcb_round_component_diameter(component);
	colour = pcb_round_component_colour(component);

	translate(location)
		color(colour) cylinder(h = height, d = diameter);
}