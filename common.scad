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