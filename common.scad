//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Useful tools and utilities
//

/*
Combine rotate() and translate() into a single operation for easy positioning of objects
*/
module position(translate = [], rotate = [], colour = -1)
	for (i = [0 : $children-1])
		translate(translate)
			rotate(rotate)
				if (colour == -1)
					child(i);
				else
					color(colour)
						child(i);

/*
Draw build platform template for plating up objects.
Default to Mendel90 with IKEA mirror tile.
*/
module show_build_area(x = 200, y = 200, corner_radius = 20)
{
	%	// transparency modifier - doesn't print
	hull()
	{
		translate([x/2 - corner_radius, y/2 - corner_radius, -1])
			cylinder(h = 1, r = corner_radius);
		translate([-x/2 + corner_radius, y/2 - corner_radius, -1])
			cylinder(h = 1, r = corner_radius);
		translate([-x/2 + corner_radius, -y/2 + corner_radius, -1])
			cylinder(h = 1, r = corner_radius);
		translate([x/2 - corner_radius, -y/2 + corner_radius, -1])
			cylinder(h = 1, r = corner_radius);
	}
}