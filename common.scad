//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Useful tools and utilities
//
use <Mendel90.scad>;

/*
module position(translate = [], rotate = [], colour = -1)
Rotate, translate and colour an arbitrary list of objects. In that order
translate		coordinate vector
rotate    		axis angles
colour   		any valid w3/css3 colour name

module show_build_area(x = 196, y = 196, corner_radius = 18)
Draw (non-printing) build platform template
Useful for plating up objects.
Default to Mendel90 with IKEA SÖRLI mirror tile.
x				x dimension
y				y dimension
corner_radius	20mm for SÖRLI

module slot(length, width, depth)
Subtractive rounded-end slot shape to fit within given dimensions
length			length of slot including radii
width			width of slot
depth			depth of slot
*/


module position(translate = [], rotate = [], mirror = [0, 0, 0], colour = -1)
{
	for (i = [0 : $children-1])
		translate(translate)
			rotate(rotate)
				mirror(mirror)
					if (colour == -1)
						child(i);
					else
						color(colour)
							child(i);
}

module show_build_area(x = 196, y = 196, corner_radius = 18)
{
	show_M90_build_area();
}

module slot(length, width, depth)
{
	hull()
	{
		cylinder(h = depth, r = width/2);
		translate([length - width, 0, 0])
			cylinder(h = depth, r = width/2);
	}
}
