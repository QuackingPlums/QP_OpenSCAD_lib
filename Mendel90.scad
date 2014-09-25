//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Mendel90 dimensions, etc
//

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