$fn = 50;

x = 40;
y = 50;
z = 1.2;
r = 1;

%cube([x, y, z]);
//square_cutout();
//slot();
//diagonal_cutout1(x = x, y = y, width = 3, depth = z, r = r);
zigzag_cutout1 (x = x, y = y, width = 3, depth = z, r = r, strong = false);
//diagonal_cutout2(x = x, y = y, width = 3, depth = z, r = r);
//zigzag_cutout2 (x = x, y = y, width = 3, depth = z, r = r);

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

/*
	a2 = 90-a;
	echo(r + r/cos(a));
	echo(r + r/sin(a2));
	echo(y/x);
	echo(a);
	echo(tan(a));
	echo((r + r / cos(a2)) / tan(a2));
	echo(tan(a) / (r + r / sin(a)));
*/

	*rotate([0, 0, a])
		translate([0, -width/2, 0])
			cube([h, width, 0.1]);

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

	//%cube([x, y, 0.5]);
}

module zigzag_cutout1(x = 100, y = 30, width = 3, depth = 1.2, r = 2, strong = true)
{
	// if strong is true then use strict 60deg diagonals (even if that leaves partials)
	// else try to get as close to 45deg as possible (cos it's easier!)
	ix = strong ? (y / tan(60)) : x / round(x/y);

	for (i = [0 : x / ix])
		translate([i * (ix - r*2), (i % 2 == 1) ? y : 0, 0])
			mirror([0, (i % 2 == 1) ? 1 : 0, 0])
				diagonal_cutout1(x = ix, y = y, width = width, depth = depth, r = r);
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
	//echo(solns);
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


	//%cube([x, y, 0.5]);
}

module zigzag_cutout2(x = 100, y = 20, width = 3, depth = 1.2, r = 1.5)
{
	n = floor(x / y);
	sub_x = ((x - r*2) / n) + r*2;

	for (i = [0 : n - 1])
		translate([i * (sub_x - r*2), (i % 2 == 1) ? y : 0, 0])
			mirror([0, (i % 2 == 1) ? 1 : 0, 0])
				diagonal_cutout2(x = sub_x, y = y, width = width, depth = depth, r = r);

	//%cube([x, y, 0.5]);
}

function SolveQuadratic(a = 1, b = 1, c = 1) = 
	[
		(-b + sqrt(pow(b,2) - (4 * a * c)))/(2*a),
		(-b - sqrt(pow(b,2) - (4 * a * c)))/(2*a)
	];
