/**************************************************
| Rounded corners are less prone to lifting than
| sharp corners. They also look nicer.
**************************************************/
use <common.scad>;

ff = 0.05;

function new_help_item(signature, parameters, description) =
	[signature, parameters, description];
function help_item_signature(help_item) = help_item[0];
function help_item_parameters(help_item) = help_item[1];
function help_item_description(help_item) = help_item[2];

function new_help_item_parameter(name, example, description) =
	[name, example, description];
function parameter_name(parameter) = parameter[0];
function parameter_example(parameter) = parameter[1];
function parameter_description(parameter) = parameter[2];

module format_help(name, description, functions, modules)
{
	num_modules = len(modules);
	num_functions = len(functions);

	echo("========================================");
	echo(str( "Name: <b>", name, "</b>" ));
	echo(description);
	if (num_functions > 0)
		for (i = [0:num_functions-1])
		{
			echo();
			echo(str( "function <b>", help_item_signature(functions[i]), "</b>" ));
			echo(str( help_item_description(functions[i]) ));
			if (len(help_item_parameters(functions[i])) > 0)
				for (j = [0:len(help_item_parameters(functions[i]))-1])
					assign(parameter = help_item_parameters(functions[i])[j])
						echo(str( "<b>", parameter_name(parameter), "</b> <i>", parameter_example(parameter), "</i> - ", parameter_description(parameter) ));
		}
	if (num_modules > 0)
		for (i = [0:len(modules)-1])
		{
			echo();
			echo(str( "module <b>", help_item_signature(modules[i]), "</b>" ));
			echo(str( help_item_description(modules[i]) ));
			if (len(help_item_parameters(modules[i])) > 0)
				for (j = [0:len(help_item_parameters(modules[i]))-1])
					assign(parameter = help_item_parameters(modules[i])[j])
						echo(str( "<b>", parameter_name(parameter), "</b> <i>", parameter_example(parameter), "</i> - ", parameter_description(parameter) ));
		}
	echo("========================================");
}

rounded_rects_help();
module rounded_rects_help()
{
	name = "rounded_rects.scad";
	description = "A library for creating rounded rectangles and cuboids.";
	functions = [
		new_help_item(
			"minimum_corner_radius(edge_clearance)",
			[	new_help_item_parameter("edge_clearance", "number", "Desired edge clearance")],
			"Returns the smallest corner radius to accommodate a specified edge clearance")];
	modules = [
		new_help_item(
			"Stadium(rect)",
			[	new_help_item_parameter("rect", "[x, y]", "Size of constraining rectangle")],
			"Draws a 2D pill shape."),
		new_help_item(
			"Rounded_rectangle(rect, corner_radius)",
			[	new_help_item_parameter("rect", "[x, y]", "Size of constraining rectangle"),
				new_help_item_parameter("corner_radius", "number", "Size of corner circles")],
			"Draws a 2D rectangle with rounded corners."),
		new_help_item(
			"Extruded_rounded_rectangle(cube, corner_radius)",
			[	new_help_item_parameter("cube", "[x, y, z]", "Size of constraining cube"),
				new_help_item_parameter("corner_radius", "number", "Size of constrainging circle")],
			"Draws an extruded 2D rectangle with rounded corners."),
		new_help_item(
			"Capsule(rect, teardrop = false)",
			[	new_help_item_parameter("rect", "[x, y]", "Size of constraining rectangle"),
				new_help_item_parameter("teardrop", "boolean", "Set to true to use teardrop instead of sphere")],
			"Draws a 3D pill shape."),
		new_help_item(
			"Rounded_cube(cube, corner_radius, teardrop)",
			[	new_help_item_parameter("cube", "[x, y, z]", "Size of constraining cube"),
				new_help_item_parameter("corner_radius", "number", "Size of constrainging circle"),
				new_help_item_parameter("teardrop", "boolean", "Set to true to use teardrop instead of sphere")],
			"Draws a 3D cuboid with rounded corners and optional teardrop lower edge profile.")
	];

	format_help(
		name,
		description,
		functions,
		modules
	);
}

//function rect_width(rect) =
//	min(rect[0], rect[1]);

//function corner_centres(length, width, radius) =
//	[[radius, radius], [radius, width-radius], [length-radius, width-radius], [length-radius, radius]];

function minimum_corner_radius(edge_clearance) =			// square peg/round hole problem
	edge_clearance / (sqrt(2)-1) + edge_clearance;

//Stadium([100, 20]);
module Stadium(rect)
{
	x = rect[0];
	y = rect[1];
	r = min(x, y)/2;

	hull()
	{
		translate([r, r])
			circle(r = r);
		if (x != y)
			translate([x-r, y-r])
				circle(r = r);
	}
}

//Rounded_rectangle([20, 10], 4);
module Rounded_rectangle(rect, corner_radius)
{
	x = rect[0];
	y = rect[1];
	r = min(min(x, y)/2, corner_radius);
	d = 2*r;

	hull()
	{
		Stadium([d, y]);

		if (x > d)
			translate([x-d, 0])
				Stadium([d, y]);
	}
}

//Extruded_rounded_rectangle([20, 30, 10], 5);
module Extruded_rounded_rectangle(cube, corner_radius)
{
	x = cube[0];
	y = cube[1];
	z = cube[2];

	linear_extrude(height = z)
		Rounded_rectangle([x, y], corner_radius);
}

//Capsule([10, 20], true);
module Capsule(rect, teardrop = false)
{
	x = rect[0];
	y = rect[1];
	r = min(x,y)/2;

	hull()
	{
		translate([r, r, r])
			if (teardrop)
				_teardrop(r = r, invert = true);
			else
				sphere(r = r);

		if (x != y)
			translate([x-r, y-r, r])
				if (teardrop)
					_teardrop(r = r, invert = true);
				else
					sphere(r = r);
	}
}

//_teardrop(10, true);
module _teardrop(r, invert = false)
{
	mirror([0, 0, invert ? 1 : 0])
		intersection()
		{
			union()
			{
				sphere(r = r);
				translate([0, 0, r / sqrt(2)])
					cylinder(h = r/sqrt(2), r1 = r/sqrt(2), r2 = 0);
			}
			cube(2*r, center = true);
		} 
}

//Rounded_cube([10, 30, 35], 5, true);
module Rounded_cube(cube, corner_radius, teardrop = false)
{
	x = cube[0];
	y = cube[1];
	z = cube[2];
	r = min(min(x, y, z)/2, corner_radius);
	d = 2*r;

	hull()
	{
		Capsule([d, y], teardrop);

		if (x > d)	// lower corners
			translate([x-d, 0, 0])
				Capsule([d, y], teardrop);

		if (z > d)	// upper corners
			translate([0, 0, z-d])
			{
				Capsule([d, y], teardrop);

				if (x > d)
					translate([x-d, 0, 0])
						Capsule([d, y], teardrop);
			}
	}
}




//**************

//rounded_pill(30, 10, 5);
module rounded_pill(length, width, height = ff)
{
	echo("<b>rounded_pill()</b> is deprecated; use <b>Rounded_rectangle()</b>");
	
	l = length;
	w = width;
	h = height;

	r = w/2;

	translate([-l/2, -w/2, 0])
		Extruded_rounded_rectangle([l, w, h], r);
}

//rounded_rect(10, 20, 3);
module rounded_rect(length, width, corner_radius, height = ff)
{
	echo("<b>rounded_rect()</b> is deprecated; use <b>Rounded_rectangle()</b> instead");

	Extruded_rounded_rectangle([length, width, height], corner_radius);
}

//rounded_cube2([30, 20, 5], 5);
module rounded_cube2(cuboid, corner_radius = 0.01)
{
	echo("<b>rounded_cube2()</b> is deprecated; use <b>Extruded_rounded_rectangle()</b> instead");

	l = cuboid[0];
	w = cuboid[1];
	h = cuboid[2];
	r = corner_radius;

	Extruded_rounded_rectangle([l, w, h], r);
}

//rounded_cube([40, 30, 20], 5, true);
module rounded_cube(cuboid, corner_radius, teardrop = false)
// always draws a cube with minimum height = 2*corner_radius
{
	echo("<b>rounded_cube()</b> is deprecated; use <b>Rounded_cube()</b> instead");

	l = cuboid[0];
	w = cuboid[1];
	h = cuboid[2];
	r = corner_radius;

	Rounded_cube([l, w, h], r, teardrop);
}