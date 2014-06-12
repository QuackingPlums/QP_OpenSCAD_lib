/**************************************************
| Baffles can reduce the lifting at sharp corners
| and edges, especially when printing near the edge
| of the heated bed where colder air can reduce
| adhesion.
**************************************************/
use <common.scad>;
ff = 0.05;
$fn = 24;

default_extrusion_width = 0.5;
default_layer_height = 0.2;

default_base_width = 5.0;

// ***** examples *****
%cube(30);
//straight_baffle(length = 30, height = 8);
corner_baffle(length_x = 30, length_y = 30, height = 8);

module straight_baffle(length, height, base_width = default_base_width, ew = default_extrusion_width, lh = default_layer_height)
{
	position(
		mirror = [0, 1, 0],
		translate = [0, -1, 0])
		union()
		{
			// base
			cube([length, base_width, 5]);

			// baffle
			cube([length, 2*ew, height]);
		}
}

module corner_baffle(length_x, length_y, height, base_width = default_base_width, ew = default_extrusion_width, lh = default_layer_height)
{
	difference()
	{
		// corner baffle
		union()
		{
			// base
			translate([-base_width - 1, - base_width - 1, 0])
				cube([length_x + base_width + 1, length_y + base_width + 1, 5]);

			// baffle
			translate([-2, -2, 0])
				cube([length_x + 2, length_y + 2, height]);
		}

		// square object
		translate([-1, -1, -ff/2])
			cube([length_x+1+ff, length_y+1+ff, height+ff]);
	}
}