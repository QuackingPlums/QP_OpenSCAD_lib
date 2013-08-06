// Fillets and radii

ff = 0.05;						// fudge factor to prevent barfing on coincident faces

// add this into internal corners to strengthen the joint
module fillet(length = 100, radius = 5)
{
	difference()
	{
		translate([radius / 2, radius / 2, 0])
			cube([radius, radius, length], true);
		translate([radius, radius, 0])
			cylinder(h = length + ff, r = radius, center = true);
	}
}

// subtract a radius from a straight edge to form a curved edge (use minkowski for rounding ALL edges)
module radius(length = 100, radius = 5)
{
	difference()
	{
		translate([radius / 2, radius / 2, 0])
			cube([radius + ff, radius + ff, length], true);
		translate([radius, radius, 0])
			cylinder(h = length + ff, r = radius, center = true);
	}
}