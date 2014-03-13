//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Cameras
//

include <cameras_h.scad>;

$fn = 30;

ff = 0.05;	// fudge factor to prevent barfing on coincident faces

module camera(camera_type)
{
	if (exists(camera_type[0], [GoPro_HD_Hero3_Black, Panasonic_GF3]))
	{
		if (camera_type == GoPro_HD_Hero3_Black)
			GoPro_HD_Hero3_Black();

		if (camera_type == Panasonic_GF3)
			Panasonic_GF3();
	}
	else
		basic_camera(camera_type = camera_type);
}

function exists(match, search) =
	len(search([match], search, 0)[0]) > 0 ? true : false;

module basic_camera(camera_type = GoPro_HD_Hero3_Black)
{
	translate([0, 0, camera_height(camera_type) / 2])
		union()
		{
			color("lightgrey")
				cube([camera_width(camera_type), camera_depth(camera_type), camera_height(camera_type)], center = true);
			color("black")
				translate([camera_lens_dx(camera_type), -camera_depth(camera_type) / 2, camera_lens_dz(camera_type)])
					rotate([90, 0, 0])
						cylinder(h = camera_lens_dy(camera_type), r = camera_lens_diameter(camera_type) / 2);
		}
}

module FoV_frustum(FoV_angle = 114, lens_radius = camera_lens_diameter(GoPro_HD_Hero3_Black) / 2, depth = 3, debug = false)
{
	r1 = lens_radius;
	r2 = r1 + depth * tan(FoV_angle / 2);

	if (debug) echo(str("FoV frustum = ", r2 * 2));

	cylinder(h = depth, r1 = r1, r2 = r2);
}

module GoPro_HD_Hero3_Black()
{
	ct = GoPro_HD_Hero3_Black;

	union()
	{
		// main body
		color("black")
			linear_extrude(height = camera_height(ct))
				translate([0, 1, 0])
					square([camera_width(ct), camera_depth(ct) - 2], center = true);

		// fascia
		color("lightgrey")
			linear_extrude(height = camera_height(ct))
				translate([0, -camera_depth(ct) / 2 + 1, 0])
					square([camera_width(ct), 2], center = true);

		// lens
		translate([camera_lens_dx(ct), -camera_depth(ct) / 2, camera_lens_dz(ct) + camera_height(ct) / 2])
			rotate([90, 0, 0])
			{
				color("black")
					cylinder(h = camera_lens_dy(ct), r = camera_lens_diameter(ct) / 2);
				color("DarkSlateGray")
					cylinder(h = camera_lens_dy(ct) + 1, r = camera_lens_diameter(ct) / 2 - 4);
			}

		// shutter button
		translate([-camera_width(ct) / 2 + 13, 0, camera_height(ct)])
		{
			color("dimgray")
				cylinder(h = ff, r = 6);
			color("Red")
				cylinder(h = ff*2, r = 2.25);		
		}

		// top activity LED
		translate([-camera_width(ct) / 2 + 6, -camera_depth(ct) / 2 + 5, camera_height(ct)])
			color("DimGray")
				cylinder(h = ff, r = 1.5);

		// mode/power button
		translate([- camera_width(ct) / 2 + 13, -camera_depth(ct) / 2, 10.5])
			rotate([90, 0, 0])
				color("dimgray")
					cylinder(h = ff, r = 6.25);

		// display
		translate([-camera_width(ct) / 2 + 13, -camera_depth(ct) / 2, 16.2 / 2 + 20])
			color("DarkSlateGray")
				cube([12.5, ff, 16.2], center = true);

		// front indicators
		translate([-camera_width(ct) / 2 + 23.5, -camera_depth(ct) / 2, 14])
			rotate([90, 0, 0])
				color("WhiteSmoke")
					cylinder(h = ff, r = 2.6);
		translate([-camera_width(ct) / 2 + 23.5, -camera_depth(ct) / 2, 7])
			rotate([90, 0, 0])
				color("WhiteSmoke")
					cylinder(h = ff, r = 2.6);

		// wifi button
	}
}

// splined GoPro-specific mount
module GoPro_mount()
{
}

module Panasonic_GF3()
{
	c = Panasonic_GF3;

	width = camera_width(c);
	depth = camera_depth(c) - 6;
	height = camera_height(c);
	lens = camera_lens_dy(c);
	lens_d = camera_lens_diameter(c);
	lens_bulge = lens_d + 10;

	minkowski_sphere = 12.0;
	minkowski_radius = minkowski_sphere/2;

	union()
	{
		// main body
		color("dimgrey")
		minkowski()
		{
			
			union()
			{
				// cuboidal main chassis
				translate([-(width - minkowski_sphere)/2, -(depth - minkowski_sphere)/2, minkowski_radius])
					cube([width-minkowski_sphere, depth - minkowski_sphere, height - 12 - minkowski_sphere]);
		
				// lens bulge
				translate([camera_lens_dx(c), (depth - minkowski_sphere)/2, height/2 + camera_lens_dz(c)])
					rotate([90, 0, 0])
						difference()
						{
							cylinder(h = depth - minkowski_sphere, r = (lens_bulge - minkowski_sphere)/2);
							translate([-lens_bulge/2, -lens_bulge, -ff/2])
								cube([lens_bulge + ff, lens_bulge + ff, depth + ff]);
						}
			}

			sphere(minkowski_radius, $fn = 8);
		}

		// lens
		translate([camera_lens_dx(c), -depth/2, height/2 + camera_lens_dz(c)])
			rotate([90, 0, 0])
			{
				color("dimgrey")
				difference()
				{
					cylinder(h = lens, r = lens_d/2);
					translate([0, 0, camera_lens_dy(c) - 4])
					cylinder(h = lens, r = lens_d/2 - 2);
				}
				color("lightblue")
					cylinder(h = lens -3, r = lens_d/4);
			}

		// shutter button
		color("silver")
		translate([-30, 0, height - 12])
			cylinder(h = 3, r = 6);
	}
}

//basic_camera(GoPro_HD_Hero2);
//GoPro_HD_Hero3_Black();
//FoV_frustum();
//Panasonic_GF3();
camera(Panasonic_GF3);