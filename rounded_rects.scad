/**************************************************
| Rounded corners are less prone to lifting than
| sharp corners. They also look nicer.
**************************************************/
use <common.scad>;

$fn = 24;
ff = 0.05;

// ***** examples *****
//rounded_rect(length = 30, width = 20, corner_radius = 5);
//rounded_rect(length = 30, width = 20, corner_radius = 5, height = 5);
//rounded_cube([20, 30, 10], corner_radius = 3);
rounded_cube([20, 30, 10], corner_radius = 3, teardrop = true);

function corner_centres(length, width, radius) =
	[[radius, radius], [radius, width-radius], [length-radius, width-radius], [length-radius, radius]];

module rounded_rect(length, width, corner_radius, height = ff)
{
	l = length;
	w = width;
	r = corner_radius;

	corner_centres = corner_centres(l, w, r);

	hull()
		for (i = [0 : len(corner_centres)-1])
			translate(corner_centres[i])
				cylinder(h = height, r = r);
}

module rounded_cube(cube, corner_radius, teardrop = false)
// always draws a cube with minimum height = 2*corner_radius
{
	l = cube[0];
	w = cube[1];
	h = cube[2];
	r = corner_radius;

	corner_centres = [[r, r], [r, w-r], [l-r, w-r], [l-r, r]];

	hull()
	{
		// bottom
		translate([0, 0, r])	// offset for bottom corners
			for (i = [0 : len(corner_centres)-1])
				translate(corner_centres[i])
					if (teardrop)
						teardrop(r = r, truncate = true, invert = true);
					else
						sphere(r = r);

		// top
		if (h > 2*r)
			translate([0, 0, h-r])	// offset for top corners
				for (i = [0 : len(corner_centres)-1])
					translate(corner_centres[i])
							sphere(r = r);
	}

}

//teardrop(30, true, true);
module teardrop(r, truncate = false, invert = false)
{
	mirror([0, 0, invert ? 1 : 0])
		difference()
		{
			union()
			{
				sphere(r = r);
				translate([0, 0, r / sqrt(2)])
					cylinder(h = r/sqrt(2), r1 = r/sqrt(2), r2 = 0);
			}
			if (truncate)
				translate([0, 0, 2*r])
					cube(2*r, center = true);
		} 
}