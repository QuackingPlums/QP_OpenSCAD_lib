$fn = 50;

//x = 60;
//y = 50;
//z = 1.2;
//r = 3;
//w = 6;
//
//%cube([x, y, z+1]);

//square_cutout(x = x, y = y, width = w, depth = z, r = r);
//slot(length = x, depth = z, r = r);
//diagonal_cutout1(x = x, y = y, width = w, depth = z, r = r);
//zigzag_cutout1 (x = x, y = y, width = w, depth = z, r = r, strong = false);
//cross_cutout(x = x, y = y, width = w, depth = z, r = r);
//diagonal_cutout2(x = x, y = y, width = w, depth = z, r = r);
//zigzag_cutout2 (x = x, y = y, width = w, depth = z, r = r, strong = false);

module triangle_cutout(x = 20, y = 10, depth = 3, r = 1)
{
	hull()
	{
		translate([r, r, 0])
			cylinder(h = depth, r = r);
		translate([x-r, r, 0])
			cylinder(h = depth, r = r);
		translate([r, y-r, 0])
			cylinder(h = depth, r = r);
	}
}

module square_cutout(x = 20, y = 10, depth = 3, r = 1)
{
	hull()
	{
		translate([r, r, 0])
			cylinder(h = depth, r = r);
		translate([x-r, r, 0])
			cylinder(h = depth, r = r);
		translate([x-r, y-r, 0])
			cylinder(h = depth, r = r);
		translate([r, y-r, 0])
			cylinder(h = depth, r = r);
	}
}

module slot(length = 20, depth = 3, r = 1.5)
{
	hull()
	{
		cylinder(h = depth, r = r);
		translate([length - 2*r, 0, 0])
			cylinder(h = depth, r = r);
	}
}

module diagonal_cutout1(x = 100, y = 30, width = 3, depth = 1.2, r = 2)
{
	a = atan(y/x);					// angle of diagonal
	h = sqrt(pow(x,2) + pow(y,2));	// length of diagonal

	hull()
	{
		translate([r, y - r, 0])
			cylinder(h = depth, r = r);
		translate([x - width/2 / sin(a) - (r + r / cos(a)) / tan(a), y - r, 0])
			cylinder(h = depth, r = r);		
		translate([r, width/2 / cos(a) + tan(a) * (r + r / sin(a)), 0])
			cylinder(h = depth, r = r);
	}

	hull()
	{
		translate([x - r, r, 0])
			cylinder(h = depth, r = r);
		translate([x - r, y - width/2 / cos(a) - tan(a) * (r + r / sin(a)), 0])
			cylinder(h = depth, r = r);
		translate([width/2 / sin(a) + (r + r / cos(a)) / tan(a), r, 0])
			cylinder(h = depth, r = r);		
	}
}

module zigzag_cutout1(x = 100, y = 30, width = 3, depth = 1.2, r = 2, strong = true)
{
	// if strong is true then use strict 60deg diagonals (even if that leaves partials)
	// else calculate nearest whole number of triangles where angle ~60deg
	ideal_x = y/tan(60);												// ideal x to give 60deg angles
	actual_x = strong ? ideal_x : x / max(1, round(x / (ideal_x + r)));	// actual x value
	n = ceil(x / actual_x);											// number of diagonals
	ix = (n == 1) ? actual_x : actual_x + (n - 1) * 2 * r / n ;			// adjusted x value

	intersection()
	{
		// triangles
		for (i = [0 : n-1])
			translate([i * (ix - r*2), (i % 2 == 1) ? y : 0, 0])
				mirror([0, (i % 2 == 1) ? 1 : 0, 0])
					diagonal_cutout1(x = ix, y = y, width = width, depth = depth, r = r);

		// mask
		square_cutout(x = x, y = y, depth = depth, r = r);
	}
}

module cross_cutout(x = 100, y = 30, width = 3, depth = 1.2, r = 2)
{
	a = atan(y/x);					// angle of diagonals
	h = sqrt(pow(x,2) + pow(y,2));	// length of diagonals

	x_inset = width/2 / sin(a) + (r + r / cos(a)) / tan(a);
	y_inset = width/2 / cos(a) + tan(a) * (r + r / sin(a));
	x_point = (y/2 - y_inset) / tan(a) + r;
	y_point = (x/2 - x_inset) * tan(a) + r;

	// top
	hull()
	{
		translate([x_inset, y - r, 0])
			cylinder(h = depth, r = r);
		translate([x - x_inset, y - r, 0])
			cylinder(h = depth, r = r);		
		translate([x/2, y - y_point, 0])
			cylinder(h = depth, r = r);
	}

	// right
	hull()
	{
		translate([x - r, y - y_inset, 0])
			cylinder(h = depth, r = r);
		translate([x - r, y_inset, 0])
			cylinder(h = depth, r = r);
		translate([x - x_point, y/2, 0])
			cylinder(h = depth, r = r);
	}

	// bottom
	hull()
	{
		translate([x_inset, r, 0])
			cylinder(h = depth, r = r);
		translate([x - x_inset, r, 0])
			cylinder(h = depth, r = r);
		translate([x/2, y_point, 0])
			cylinder(h = depth, r = r);
	}

	// left
	hull()
	{
		translate([r, y - y_inset, 0])
			cylinder(h = depth, r = r);
		translate([x_point, y/2, 0])
			cylinder(h = depth, r = r);
		translate([r, y_inset, 0])
			cylinder(h = depth, r = r);
	}
}

module diagonal_cutout2(x = 30, y = 30, width = 3, depth = 1.2, r = 2)
{
	G = width + 2*r;
	L = x - 2*r;
	W = y - 2*r;

	a = pow(G, 2) - pow(W, 2);
	b = 2 * pow(W, 2) * L;
	c = pow(W, 2) * (pow(G, 2) - pow(L, 2));

	solns = SolveQuadratic(a, b, c);
	offset = min(solns[0], solns[1]) + r;

	hull()
	{
		translate([r, y - r, 0])
			cylinder(h = depth, r = r);
		translate([offset, y - r, 0])
			cylinder(h = depth, r = r);		
		translate([r, r, 0])
			cylinder(h = depth, r = r);
	}

	hull()
	{
		translate([x - r, r, 0])
			cylinder(h = depth, r = r);
		translate([x - r, y - r, 0])
			cylinder(h = depth, r = r);
		translate([x - offset, r, 0])
			cylinder(h = depth, r = r);		
	}
}

module zigzag_cutout2(x = 100, y = 20, width = 3, depth = 1.2, r = 1.5, strong = true)
{
	// if strong is true then use strict 60deg diagonals (even if that leaves partials)
	// else calculate nearest whole number of triangles where angle ~60deg
	ideal_x = y/tan(60) + 2*r + width;									// ideal x to give 60deg angles
	actual_x = strong ? ideal_x : x / max(1, round(x / (ideal_x + r)));	// actual x value
	n = ceil(x / actual_x);											// number of diagonals
	ix = (n == 1) ? actual_x : actual_x + (n - 1) * 2 * r / n ;			// adjusted x value

	intersection()
	{
		// triangles
		for (i = [0 : n - 1])
		{
			translate([i * (ix - r*2), (i % 2 == 1) ? y : 0, 0])
				mirror([0, (i % 2 == 1) ? 1 : 0, 0])
					diagonal_cutout2(x = ix, y = y, width = width, depth = depth, r = r);
		}

		// mask
		square_cutout(x = x, y = y, depth = depth, r = r);
	}
}

function SolveQuadratic(a = 1, b = 1, c = 1) = 
	[
		(-b + sqrt(pow(b,2) - (4 * a * c)))/(2*a),
		(-b - sqrt(pow(b,2) - (4 * a * c)))/(2*a)
	];
