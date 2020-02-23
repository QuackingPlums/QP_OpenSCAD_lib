//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Fillets and radii for smoothing and strengthening edges
//
use <QP_OpenSCAD_lib/common.scad>;
use <QP_OpenSCAD_lib/docSCAD.scad>;	 			//docSCAD_help();
use <QP_OpenSCAD_lib/teardrops.scad>;			//teardrops_help();

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
// weld(t=1) {cylinder(r=5, h=40, center=true); rotate([0, 60, 0]) cylinder(r=4, h=40, center=true);};
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


//!Torus(teardrop=true);
module Torus(R=20, r=5, teardrop=false)
{
	rotate_extrude()
		translate([R, 0, 0])
			if (teardrop)
				Teardrop(r=r);
			else
				circle(r=r);
}

//!RoundFunnelChamfer(teardrop=false);
module RoundFunnelChamfer(r=10, cornerRadius=3, teardrop=true)
{
	difference()
	{
		outerCylRadius = r+cornerRadius;
		translate([0, 0, -ff/2])
			cylinder(r=outerCylRadius, h=cornerRadius+ff);
		position(
			mirror=[0, 0, 1],
			translate=[0, 0, cornerRadius])
			Torus(R=outerCylRadius, r=cornerRadius, teardrop=teardrop);
	}
}

//!StadiumFunnelChamfer(teardrop=false);
module StadiumFunnelChamfer(x=20, y=50, cornerRadius=3, teardrop=true)
{
	r = min(x, y)/2;
	dy = y - 2*r;
	dx = x - 2*r;

	// ends
	RoundFunnelChamfer(r=r, cornerRadius=cornerRadius, teardrop=teardrop);
	translate([dx, dy, 0])
		RoundFunnelChamfer(r=r, cornerRadius=cornerRadius, teardrop=teardrop);

	// centre section
	w = 2*r;
	l = max(dx, dy);

	rotate([0, 0, (x>y)?-90:0])
		translate([-w/2-cornerRadius, 0, cornerRadius])
			rotate([-90, 0, 0])
		linear_extrude(l)
			difference()
			{
				union()
				{
					square([w+2*cornerRadius, cornerRadius+ff/2]);
					translate([cornerRadius, -ff/2])
						square([w, cornerRadius+ff]);
				}

				if (teardrop)
				{
					Teardrop(r=cornerRadius, truncate=true);
					translate([w+2*cornerRadius, 0])
						Teardrop(r=cornerRadius, truncate=true);
				}
				else
				{
					circle(r=cornerRadius);
					translate([w+2*cornerRadius, 0])
						circle(r=cornerRadius);
				}
			}
}

//fillets_help();
module fillets_help()
  formatHelp_simple(
    libraryName="fillets.scad",
    description="Fillets and radii",
    members=[
		new_member(
			name="fillet",
			parameters="length=100, radius=5",
			description=["Add this into internal corners to strengthen the joint",
				Indent( Number("length", "length of fillet") ),
				Indent( Number("radius", "fillet radius") )
			]
		),
		new_member(
			name="radius",
			parameters="length=100, radius=5",
			description=["Subtract a radius from a straight edge to form a curved",
				"edge (similar to minkowski but quicker for single edges)",
				Indent( Number("length", "length of radius") ),
				Indent( Number("radius", "edge radius") )
			]
		),
		new_member(
			name="weld",
			parameters="t=1",
			description=["Weld two objects together at their intersection",
				Indent( Number("t", "minkowski thickness of weld") )
			]
		),
		new_member(
			name="RoundFunnelChamfer",
			parameters="r=10, cornerRadius=3, teardrop=false",
			description=["Subtract from the base of a hollow cylinder to create a ", 
				"funnelled intake. Set teardrop=false when inverted.",
				Indent( Number("r", "radius of hole") ),
				Indent( Number("cornerRadius", "radius of funnel lip") ),
				Indent( Boolean("teardrop", "truncated teardrop for printability") )
			]),
		new_member(
			name="StadiumFunnelChamfer",
			parameters="x=20, y=50, cornerRadius=3, teardrop=true",
			description=["Subtract from the base of a hollow extruded stadium to create a ", 
				"funnelled intake. Set teardrop=false when inverted.",
				Indent( Number("x", "x-dimension of stadium") ),
				Indent( Number("y", "y-dimension of stadium") ),
				Indent( Number("cornerRadius", "radius of funnel lip") ),
				Indent( Boolean("teardrop", "truncated teardrop for printability") )
			])
	]
  );	
