//
// Mendel90
//
// GNU GPL v2
// nop.head@gmail.com
// hydraraptor.blogspot.com
//
// For making horizontal holes that don't need support material
// Small holes can get away without it but they print better with truncated teardrops
//
// Subsequent additions by quackingplums@gmail.com
//

use <QP_OpenSCAD_lib/docSCAD.scad>;							//docSCAD_help();

layer_height = 0.2;	// config variable

//teardrop_2D(10);
//teardrop(10, 10);
//teardrop_plus(10, 10);
//tearslot(10, 10, 50);
//vertical_tearslot(10, 10, 50);
//qp_tearslot(10, 10, 50);
//qp_vertical_tearslot(10, 10, 50);

/* NEW TEARDROPS
teardrop(r, truncate) (flat, 2D)
extrudedTeardrop(r, h, truncate)
teardrop3D(r, truncate)
extrudedHorizontalTearslot()
verticalHorizontalTearslot()
*/

//!Teardrop3D(10);
module Teardrop3D(r, truncate=true)
{
	trunc = r*cos(45);

	intersection()
	{
		union()
		{
			sphere(r=r);
			translate([0, 0, -2*trunc])
				cylinder(r1=0, r2=trunc, h=trunc);
		}
		cube(2*r, center=true);
	}
}

module ExtrudedTeardrop(r, h, truncate=true)
{
	teardrop(h=h, r=r, center=false, truncate=truncate);
}

module Teardrop(r, truncate=true)
{
	teardrop_2D(r=r, truncate=truncate);
}

// flat teardrop shape
module teardrop_2D(r, truncate = true) {
    difference() {
        union() {
            circle(r = r, center = true);
            translate([0,r / sqrt(2),0])
                rotate([0,0,45])
                    square([r, r], center = true);
        }
        if(truncate)
            translate([0, r * 2, 0])
                square([2 * r, 2 * r], center = true);
    }
}

// teardrop extruded into a 'cylinder'
module teardrop(h, r, center, truncate = true)
    linear_extrude(height = h, convexity = 2, center = center)
        teardrop_2D(r, truncate);

// extruded teardrop, adjusted for layer height?
module teardrop_plus(h, r, center, truncate = true)
    teardrop(h, r + layer_height / 4, center, truncate);

// teardrop extruded into a cylinder and hulled horizontally into a slot
module tearslot(h, r, w, center)
    linear_extrude(height = h, convexity = 6, center = center)
        hull() {
            translate([-w/2,0,0]) teardrop_2D(r, true);
            translate([ w/2,0,0]) teardrop_2D(r, true);
        }

// teardrop extruded into a cylinder and hulled vertically into a slot
module vertical_tearslot(h, r, l, center = true)
    linear_extrude(height = h, convexity = 6, center = center)
        hull() {
            translate([0, l / 2]) teardrop_2D(r, true);
            translate([0, -l / 2, 0])
                circle(r = r, center = true);
        }

module qp_tearslot(h, r, w, center)							// corrected for actual width
	tearslot(h, r, w-2*r, center);
//    linear_extrude(height = h, convexity = 6, center = center)
//        hull() {
//            translate([r-w/2,0,0]) teardrop_2D(r, true);
//            translate([w/2-r,0,0]) teardrop_2D(r, true);
//        }

module qp_vertical_tearslot(h, r, l, center = true)				// corrected for actual length
	vertical_tearslot(h, r, l-2*r, center);
//    linear_extrude(height = h, convexity = 6, center = center)
//        hull() {
//            translate([0, l/2-r]) teardrop_2D(r, true);
//            translate([0, r-l/2, 0])
//                circle(r = r, center = true);
//        }


!teardrops_help();
module teardrops_help()
{
	formatHelp_simple(
		libraryName = "teardrops.scad",
		description = str(
			"Small horizontal holes can get away with it but larger ones can be printed without support material if the upper half is replaces with 45-degree overhangs.<br>",
			"Truncates to an octagonal approximation by default (requires a small bridge at the top).",
			"<p>Can also be inverted and used for 'rounded' bottom edges that would otherwise collapse.",
			"<p>THIS LIBRARY IS CURRENTLY UNDERGOING AN OVERHAUL"
		),
		members = [
			new_member(
				name = "Teardrop",
				description = ["Flat, two-dimensional teardrop",
					"",
					Number("r", "teardrop radius"),
					Optional(Boolean("truncate", "constrain to circle [default=true]"))],
				parameters = "r [, truncate]"),
			new_member(
				name = "ExtrudedTeardrop",
				description = ["Extruded teardrop  (i.e. a teardrop-profile cylinder)",
					"",
					Number("r", "teardrop radius"),
					Number("h", "teardrop extrusion height"),
					Optional(Boolean("truncate", "constrain to circle [default=true]"))],
				parameters = "r, h [, truncate]"),
			new_member(
				name = "Teardrop3D",
				description = ["Three-dimensional teardrop.",
					"Rendered inverted as this is normally used for rounded bottom edges",
					"",
					Number("r", "teardrop radius"),
					Optional(Boolean("truncate", "constrain to circle [default=true]"))],
				parameters = "r, [, truncate]")
//horizontalTearslot()
//verticalTearslot()

			
		]
	);
}