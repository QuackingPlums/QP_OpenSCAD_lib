//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Fillets and radii for smoothing and strengthening edges
//
use <QP_OpenSCAD_lib/docSCAD.scad>;	 //docSCAD_help();

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

// weld two objects together at their intersection
module weld(t=1) { 
    union() {
        children(0);
        children(1);
        hull(){
            union(){
                intersection() {
                    minkowski(){
                        intersection(){
                            children(0);
                            children(1);
                        }
                        sphere(r=t);
                    }
                    children(0);
                }
                intersection() {
                    minkowski(){
                        intersection() {
                            children(0);
                            children(1);                   
                        }
                        sphere(r=t);
                    }
                    children(1);
                }
            }
        }
    }
}

fillets_help();
module fillets_help()
  formatHelp_simple(
    libraryName="fillets.scad",
    description="Fillets and radii",
    members=[
		new_member(
			"fillet",
			["Add this into internal corners to strengthen the joint"],
			"length=100, radius=5"),
		new_member(
			"radius",
			["Subtract a radius from a straight edge to form a curved", "edge (use minkowski for rounding ALL edges)"],
			"length=100, radius=5"),
		new_member(
			"weld",
			["Weld two objects together at their intersection"],
			"t=1")
	]
  );	
