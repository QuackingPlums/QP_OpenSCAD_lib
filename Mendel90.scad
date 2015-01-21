//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Mendel90 dimensions, etc
//
use <docSCAD.scad>; //docSCAD_help();

IKEA_SORLI = ["IKEA SÖRLI", 196, 196, 18];
default_build_plate = IKEA_SORLI;

function build_plate_name(build_plate = default_build_plate) = build_plate[0];
function build_plate_x(build_plate = default_build_plate) = build_plate[1];		// width
function build_plate_y(build_plate = default_build_plate) = build_plate[2];		// depth
function build_plate_cr(build_plate = default_build_plate) = build_plate[3];		// corner radius

function max_width(build_plate = default_build_plate) = 
	build_plate_x(build_plate);

function max_depth(build_plate = default_build_plate) = 
	build_plate_y(build_plate);

function max_diagonal(build_plate = default_build_plate) = 
	sqrt(
		pow(build_plate_x(build_plate) - 2*build_plate_cr(build_plate), 2) +
		pow(build_plate_y(build_plate) - 2*build_plate_cr(build_plate), 2)
	) + 2*build_plate_cr(build_plate);

module show_build_area(build_plate = default_build_plate)
{
	%	// transparency modifier - doesn't print
	hull()
	{
		translate([build_plate_x(build_plate)/2 - build_plate_cr(build_plate), build_plate_y(build_plate)/2 - build_plate_cr(build_plate), -1])
			cylinder(h = 1, r = build_plate_cr(build_plate));
		translate([-build_plate_x(build_plate)/2 + build_plate_cr(build_plate), build_plate_y(build_plate)/2 - build_plate_cr(build_plate), -1])
			cylinder(h = 1, r = build_plate_cr(build_plate));
		translate([-build_plate_x(build_plate)/2 + build_plate_cr(build_plate), -build_plate_y(build_plate)/2 + build_plate_cr(build_plate), -1])
			cylinder(h = 1, r = build_plate_cr(build_plate));
		translate([build_plate_x(build_plate)/2 - build_plate_cr(build_plate), -build_plate_y(build_plate)/2 + build_plate_cr(build_plate), -1])
			cylinder(h = 1, r = build_plate_cr(build_plate));
	}
}

module show_M90_build_area()
{
	show_build_area(build_area = IKEA_SORLI);
}

module clip_to_build_area()
{
	intersection()
	{
		translate([-100, -100, 0])
			cube(200);	
		children();
	}

}

//echo(max_diagonal());

Mendel90_help();
module Mendel90_help()
{
	name = "Mendel90.scad";
	description = "A library for Mendel90 specific hardware.";
	types = [
		new_type(type="IKEA_SORLI", description="IKEA Sörli mirror tile")
	];
	accessors = [
		new_help_item(
			signature="build_plate_name(build_plate = default_build_plate)",
			description="GETs name of the build_plate"),
		new_help_item(
			signature="build_plate_x(build_plate = default_build_plate)",
			description="GETs x dimension of build_plate"),
		new_help_item(
			signature="build_plate_y(build_plate = default_build_plate)",
			description="GETs y dimension of build_plate"),
		new_help_item(
			signature="build_plate_cr(build_plate = default_build_plate)",
			description="GETs corner radius of build_plate")
	];
	properties = [];
	functions = [
		new_help_item(
			signature="max_width(build_plate = default_build_plate)",
			parameters=[
				new_help_item_parameter(
					name="build_plate",
					type="type",
					description="Build plate")],
			description="Returns max printable width for the specified build_plate."),
		new_help_item(
			signature="max_depth(build_plate = default_build_plate)",
			parameters=[
				new_help_item_parameter(
					name="build_plate",
					type="type",
					description="Build plate")],
			description="Returns max printable depth for the specified build_plate."),
		new_help_item(
			signature="max_diagonal(build_plate = default_build_plate)",
			parameters=[
				new_help_item_parameter(
					name="build_plate",
					type="type",
					description="Build plate")],
			description="Returns max printable diagonal for the specified build_plate.")
	];
	modules = [
		new_help_item(
			signature="show_build_area(build_plate = default_build_plate)",
			parameters=[
				new_help_item_parameter(
					name="build_plate",
					type="type",
					description="Build plate")],
			description="Show the build plate."),
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