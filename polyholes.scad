//
// Mendel90
//
// GNU GPL v2
// nop.head@gmail.com
// hydraraptor.blogspot.com
//
// See http://hydraraptor.blogspot.com/2011/02/polyholes.html
//
// Subsequent additions by quackingplums@gmail.com
//
function sides(r) = max(round(4 *r),3);
function corrected_radius(r,n) = 0.1 + r / cos(180 / n);
function corrected_diameter(d) = 0.2 + d / cos(180 / sides(d / 2));

module poly_circle(r, d, center = false)
{
	r = r == undef ? d/2 : r;

	n = sides(r);
	circle(r = corrected_radius(r,n), $fn = n, center = center);
}

module poly_cylinder(r, h, d, center = false)
{
	r = r == undef ? d/2 : r;

	n = sides(r);
	cylinder(h = h, r = corrected_radius(r,n), $fn = n, center = center);
}

module poly_slot(r, h, w, d, center)
{
	r = r == undef ? d/2 : r;

	hull()
	{
		translate([-w/2, 0, 0])
			poly_cylinder(r = r, h = h, center = center);
		translate([w/2, 0, 0])
			poly_cylinder(r = r, h = h, center = center);
			
	}
}

module poly_d_cylinder(r, h, d, center = false)
{
	r = r == undef ? d/2 : r;

	n = sides(r);
	r = corrected_radius(r,n);
	cylinder(h = h, r = r, $fn = n, center = center);
	translate([0, -r, 0])
		cube([r, 2 * r, h]);
}