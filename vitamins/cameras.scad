//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Cameras
//

include <cameras_h.scad>;

$fs = 0.5;
$fa = 5;

ff = 0.05;	// fudge factor to prevent barfing on coincident faces

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


basic_camera(GoPro_HD_Hero2);
//GoPro_HD_Hero3_Black();
