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

layer_height = 0.2;	// config variable

//teardrop_2D(10);
//teardrop(10, 10);
//teardrop_plus(10, 10);
//tearslot(10, 10, 50);
//vertical_tearslot(10, 10, 50);
//qp_tearslot(10, 10, 50);
//qp_vertical_tearslot(10, 10, 50);

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