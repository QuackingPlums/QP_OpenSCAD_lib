//
// QuackingPlums
//
// Bearings
//

$fs = 0.5;
$fa = 5;

ff = 0.05;	// fudge factor to prevent barfing on coincident faces

// Bearing types
MF106zz = ["MF106zz 6x10x3 flanged bearing", 6, 10, 3, 11.2, 0.6];
MF105zz = ["MF105zz 5x10x4 flanged bearing", 5, 10, 4, 11.6, 0.8];
MF95zz = ["MF95zz 5x9x3 flanged bearing", 5, 9, 3, 10.2, 0.6];

function bearing_name(bearing_type) = bearing_type[0];
function bearing_bore_diameter(bearing_type) = bearing_type[1];
function bearing_diameter(bearing_type) = bearing_type[2];
function bearing_width(bearing_type) = bearing_type[3];
function bearing_flange_diameter(bearing_type) = bearing_type[4];
function bearing_flange_width(bearing_type) = bearing_type[5];

function bearing_bore_radius(bearing_type) = bearing_bore_diameter(bearing_type) / 2;
function bearing_radius(bearing_type) = bearing_diameter(bearing_type) / 2;
function bearing_flange_radius(bearing_type) = bearing_flange_diameter(bearing_type) / 2;

module bearing(bearing_type = MF106zz)
{
	color("silver")
		difference()
		{
			union()
			{
				// flange
				cylinder(	r = bearing_flange_radius(bearing_type),
							h = bearing_flange_width(bearing_type));
				
				// main bearing
				cylinder(	r = bearing_radius(bearing_type),
							h = bearing_width(bearing_type));
			}
	
			// bore
			translate([0, 0, -ff])
				cylinder(	r = bearing_bore_diameter(bearing_type) / 2,
							h = bearing_width(bearing_type) + ff * 2);
		}
}

*bearing(MF106zz);