//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Motors
//

include <motors_h.scad>;
include <fasteners_h.scad>;

use <fasteners.scad>;

$fs = 0.5;
$fa = 5;

ff = 0.05;	// fudge factor to prevent barfing on coincident faces

module motor(motor_type = iPower_GBM2208)
{
	union()
	{
		// base
		color("silver")
			cylinder(	r1 = motor_base_r1(motor_type),
						r2 = motor_base_r2(motor_type),
						h = motor_base_h(motor_type));

		// base ring
		color("silver")
			translate([0, 0, motor_base_h(motor_type)])
				cylinder(	r = motor_base_ring_r(motor_type),
							h = motor_base_ring_h(motor_type));

		// bell
		color("black")
			translate([0, 0, motor_base_h(motor_type) + motor_base_ring_h(motor_type)])
				cylinder(	r = motor_bell_r(motor_type),
							h = motor_bell_h(motor_type));

		// stator
		color("DarkGoldenrod")
			translate([0, 0, motor_base_h(motor_type) + motor_base_ring_h(motor_type) - ff])
				cylinder(	r = motor_stator_r(motor_type),
							h = motor_stator_h(motor_type),
							$fn = 14);

		// bell cap
		color("silver")
			translate([0, 0, motor_base_h(motor_type) + motor_base_ring_h(motor_type) + motor_bell_h(motor_type)])
				cylinder(	r1 = motor_bell_r(motor_type),
							r2 = motor_cap_r(motor_type),
							h = motor_cap_h(motor_type));

		// shaft collar
		color("silver")
			translate([0, 0, motor_base_h(motor_type) + motor_base_ring_h(motor_type) + motor_bell_h(motor_type) + motor_cap_h(motor_type)])
				cylinder(	r = motor_shaft_collar_r(motor_type),
							h = motor_shaft_collar_h(motor_type));

		// shaft
		color("grey")
			translate([0, 0, motor_shaft_offset(motor_type) - ff])
				cylinder(	r = motor_shaft_r(motor_type),
							h = motor_base_h(motor_type) + motor_base_ring_h(motor_type) + motor_bell_h(motor_type) + motor_cap_h(motor_type) + motor_shaft_collar_h(motor_type) + abs(motor_shaft_h(motor_type)) + ff * 2);
	}
}

//Motor_mount(motor_type = Turnigy_AeroDrive_C2024, bumper = 4);
module Motor_mount(motor_type = iPower_GBM2208, thick = 2, bumper = 0, correct_for_wires = true)
{
	pad_radius = motor_mount_diameter(motor_type)/2;
	
	difference()
	{
		union()
		{
			// motor pad
			cylinder(h = thick, r = pad_radius + bumper);

			// extensions (if any)
		}

		// holes
		translate([0, 0, thick+ff/2])
			motor_base_mount(motor_type, depth = thick+ff, correct_for_wires = correct_for_wires);
	}
}

//motor_base_mount();
module motor_base_mount(motor_type = iPower_GBM2208, depth = 3, hole_pattern, hole_radius, correct_for_wires = false)
{
	if (hole_pattern != undef) echo("** DEPRECATED PARAMETER IN motor_base_mount() ** hole_pattern is now calculated from motor definition");

	h_pat = motor_mount_hole_pattern(motor_type);
	h_min = motor_mount_holes_1(motor_type);	// slot min
	h_max = motor_mount_holes_2(motor_type);	// slot max

	// allow hole radius to be overridden (for screw heads, etc)
	h_radius = (hole_radius == undef) ? metric_clearance_radius(motor_base_mount_hole_size(motor_type)) : hole_radius;

	motor_mount_holes(h_pat, h_min, h_max, depth, h_radius, correct_for_wires);
}

//motor_top_mount();
module motor_top_mount(motor_type = iPower_GBM2208, depth = 3)
{
	h_pat = motor_top_mount_hole_pattern(motor_type);						// motor-specific mount hole pattern
	h_radius = metric_clearance_radius(motor_top_mount_hole_size(motor_type));	// motor-specific mount hole size
	h_circ = motor_top_mount_holes(motor_type);							// motor-specific mount hole separation

	motor_mount_holes(h_pat, h_circ, h_circ, depth, h_radius);
}

//motor_mount_holes(hole_pattern = 4, hole_size_min = 16, hole_size_max = 19, hole_depth = 4, hole_radius = 3, correct_for_wires = true);
module motor_mount_holes(hole_pattern, hole_size_min, hole_size_max, hole_depth, hole_radius, correct_for_wires)
{
	distribute(pattern = hole_pattern, correct_for_wires = correct_for_wires)
		hull()
		{
			translate([hole_size_min / 2, 0, -hole_depth])
				cylinder(h = hole_depth, r = hole_radius);
			translate([hole_size_max / 2, 0, -hole_depth])
				cylinder(h = hole_depth, r = hole_radius);
		}
}

module distribute(pattern = 4, correct_for_wires = false)
{
	cfw = correct_for_wires ? 180/pattern : 0;

	for (i = [0 : $children - 1])
		for (j = [0 : pattern - 1])
			rotate([0, 0, j * 360 / pattern + cfw])
				children(i);
}

module motor_mount_slots(motor_type = iPower_GBM2208) // ** DEPRECATE ** - use motor_base_mount() instead
{
	echo("** DEPRECATED ** motor_mount_slots() - use motor_base_mount() instead");
//
//	s_min = motor_mount_holes_1(motor_type);
//
//	// mounting slots
//	rotate([0, 0, 45])
//		translate([s_min / 2, 0, 0])
//			motor_mount_slot(motor_type);
//	rotate([0, 0, 135])
//		translate([s_min / 2, 0, 0])
//			motor_mount_slot(motor_type);
//	rotate([0, 0, 225])
//		translate([s_min / 2, 0, 0])
//			motor_mount_slot(motor_type);
//	rotate([0, 0, 315])
//		translate([s_min / 2, 0, 0])
//			motor_mount_slot(motor_type);
}

module motor_mount_slot(motor_type = iPower_GBM2208)	// ** DEPRECATE **
{
	echo("** DEPRECATED ** motor_mount_slot()");
//
//	s_min = motor_mount_holes_1(motor_type);
//	s_max = motor_mount_holes_2(motor_type);
//	s_rad = screw_clearance_radius(M3_cap_screw);
//
//	hull()
//	{
//		circle(r = s_rad);
//		translate([(s_max - s_min) / 2, 0, 0])
//			circle(r = s_rad);
//	}
}

module motor_top_mount_holes(motor_type = iPower_GBM2208, hole_size = screw_clearance_diameter(M3_cap_screw))	// ** DEPRECATE ** - use motor_top_mount() instead
{
	echo("** DEPRECATED ** motor_top_mount_holes() - use motor_top_mount() instead");
//
//	h_pos = motor_top_mount_holes(motor_type);
//	h_pat = motor_top_mount_hole_pattern(motor_type);
//	h_rad = hole_size / 2;
//
//	for (i = [0 : h_pat - 1] )
//	{
//		rotate([0, 0, i * 360 / h_pat + 360 / 2 / h_pat])
//			translate([h_pos / 2, 0, 0])
//				circle(r = h_rad);
//	}
}

module motor_screws(screw_type = M3_cap_screw, length = 12, diameter = 16, pattern = 4, washer = false, exploded = 0)
{
	for (i = [0 : pattern - 1])
	{
		rotate([0, 0, i * 360 / pattern + 360 / 2 / pattern])
			translate([diameter / 2, 0, 0])
				screw(screw_type = screw_type, length = length, washer = washer, exploded = exploded);
	}
}

//motor(Turnigy_AeroDrive_C2024);
