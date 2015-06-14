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

use <docSCAD.scad>;				//docSCAD_help();

function sides(r) = max(round(4 * r),3);
function corrected_radius(r,n) = 0.1 + r / cos(180 / (n==undef ? sides(r) : n) );
function corrected_diameter(d, n) = 0.2 + d / cos(180 / (n==undef ? sides(d / 2) : n) );

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

//poly_d_cylinder(r = 1.6, h = 40);
module poly_d_cylinder(r, h, d, center = false)
{
	r = r == undef ? d/2 : r;

	n = sides(r);
	r = corrected_radius(r,n);
	cylinder(h = h, r = r, $fn = n, center = center);
	translate([0, -r, 0])
		cube([r, 2 * r, h]);
}

//polyholes_help();
module polyholes_help()
{
	name = "polyholes.scad";
	description = "A library for creating holes, corrected for faceting errors.";
	types = [];
	accessors = [];
	properties = [];
	functions = [
		new_help_item(
			signature="sides(r)",
			parameters=[
				new_help_item_parameter(name="r", type="number", description="Radius")],
			description="Calculate the appropriate number of edges given the size of the hole"),
		new_help_item(
			signature="corrected_radius(r,n)",
			parameters=[
				new_help_item_parameter("r", "number", "Radius"),
				new_help_item_parameter("n", "number", "[optional] Number of edges")],
			description="Calculate the corrected radius r for the given number of sides. If n isn't supplied then calculate from the radius"),
		new_help_item(
			signature="corrected_diameter(d, n)",
			parameters=[
				new_help_item_parameter("d", "number", "Radius"),
				new_help_item_parameter("n", "number", "[optional] Number of edges")],
			description="Calculate the correct diameter d for the given number of sides. If n isn't supplied then calculate from the diameter")
	];
	modules = [
		new_help_item(
			"poly_circle(r, d, center = false)",
			[	new_help_item_parameter("r|d", "number", "Radius | Diameter"),
				new_help_item_parameter("center", "boolean", "Set to true to centre about the origin")],
			"Corrected 2D circle"),
		new_help_item(
			"poly_cylinder(r, h, d, center = false)",
			[	new_help_item_parameter("r|d", "number", "Radius | Diameter"),
				new_help_item_parameter("h", "number", "Height"),
				new_help_item_parameter("center", "boolean", "Set to true to centre about the origine")],
			"Corrected cylinder"),
		new_help_item(
			"poly_slot(r, h, w, d, center)",
			[	new_help_item_parameter("r|d", "number", "Radius | Diameter"),
				new_help_item_parameter("h", "number", "Height"),
				new_help_item_parameter("w", "number", "Width"),
				new_help_item_parameter("center", "boolean", "Library description")],
			"Corrected 3d slot"),
		new_help_item(
			"poly_d_cylinder(r, h, d, center = false)",
			[	new_help_item_parameter("r|d", "number", "Radius | Diameter"),
				new_help_item_parameter("h", "number", "Height"),
				new_help_item_parameter("center", "boolean", "Library description")],
			"Corrected 3D D-profile cylinder."),
	];

	format_help(
		name=name,
		description=description,
		types=types,
		accessors=accessors,
		properties=properties,
		functions=functions,
		modules=modules
	);
}