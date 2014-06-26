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

default_base_width = 4.0;
default_base_height = 4.0;
default_baffle_height = 8.0;
default_distance = 1.0;

// ***** examples *****
//%cube(30);
//straight_baffle(length = 30, height = default_baffle_height);
//corner_baffle(length_x = 50, length_y = 30, height = default_baffle_height);

//%cylinder(h = 10, r = 15);
//half_circle_baffle(r = 15, length = 0, height = 8);
//rounded_end_baffle(r = 15, length = 30);
//quarter_circle_baffle(r = 15, length = 0, height = 8);

// at least two filaments
function baffle_thickness(extrusion_width) =
	max(2 * extrusion_width, 1);

module straight_baffle(length, height = default_baffle_height, base_width = default_base_width, ew = default_extrusion_width)
{
	bt = baffle_thickness(ew);
	dd = default_distance;

	position(
		mirror = [0, dd, 0],
		translate = [0, -dd, 0])
		union()
		{
			// base
			cube([length, base_width, default_base_height]);

			// baffle
			cube([length, bt, height]);
		}
}

module corner_baffle(length_x, length_y, height = default_baffle_height, base_width = default_base_width, ew = default_extrusion_width)
{
	bt = baffle_thickness(ew);
	dd = default_distance;

	difference()
	{
		// corner baffle
		union()
		{
			// base
			translate([-base_width - dd, - base_width - dd, 0])
				cube([length_x + base_width + dd, length_y + base_width + dd, default_base_height]);

			// baffle
			translate([-dd - bt, -dd - bt, 0])
				cube([length_x + dd + bt, length_y + dd + bt, height]);
		}

		// square clearance gap
		translate([-dd, -dd, -ff/2])
			cube([length_x+dd+ff, length_y+dd+ff, height+ff]);
	}
}

module half_circle_baffle(r, height = default_baffle_height, base_width = default_base_width, ew = default_extrusion_width)
{
	outer_r = r + default_distance + base_width;
	outer_dia = 2*outer_r;

	difference()
	{
		// circular baffle
		circle_baffle(r, height, base_width, ew);

		// mask
		translate([0, -outer_r - ff/2, -ff/2])
			cube([outer_r+ff, outer_dia+ff, height+ff]);
	}
}

module rounded_end_baffle(length, width, height = default_baffle_height, base_width = default_base_width, ew = default_extrusion_width)
{
	outer_r = r + default_distance + base_width;
	outer_dia = 2*outer_r;

	baffle_profile = 2*(r + default_distance + baffle_thickness(ew));

	difference()
	{
		union()
		{
			// circular baffle
			circle_baffle(r, height, base_width, ew);
		
			// base rect
			translate([-ff/2, -outer_r, 0])
				cube([length+ff, outer_dia, default_base_height]);
		
			// baffle rect
			translate([-ff/2, -baffle_profile/2, 0])
				cube([length+ff, baffle_profile, height]);
		}

		// clearance rect
		translate([-ff, -r-default_distance, -ff/2])
			cube([length+2*ff, 2*(r + default_distance), height + ff]);
	}
}

module circle_baffle(r, height = default_baffle_height, base_width = default_base_width, ew = default_extrusion_width)
{
	bt = baffle_thickness(ew);
	dd = default_distance;

	difference()
	{
		union()
		{
			// base
			cylinder(h = default_base_height, r = r + base_width + dd);

			// baffle
			cylinder (h = height, r = r + dd + bt);
		}

		// cylindrical clearance gap
		translate([0, 0, -ff/2])
			cylinder(h = height+ff, r = r + dd);
	}
}