/**************************************************
| ISO standard external and internal threads
| Uses threads library by Dan Kirschner
**************************************************/
use <dan_kirschner/threads.scad>;
use <polyholes.scad>;							//polyholes_help();
use <docSCAD.scad>;							//docSCAD_help();
use <common.scad>;

ff = 0.05;									// CSG fudge factor
$fs = 1.0;									// CSG segment size (mm)
$fa = 5;										// CSG minimum angle (degrees)

// swell compensation in mm
Metric_tap = [];
Metric_die = [];
Imperial_tap = [];
Imperial_die = [0.4, 0.6, 0.8];

function tight_fit(thread_type) = thread_type[0];
function medium_fit(thread_type) = thread_type[1];
function loose_fit(thread_type) = thread_type[2];
function swell_compensation(thread_type, fit) =
	fit=="tight" ? tight_fit(thread_type) :
		fit=="loose" ? loose_fit(thread_type) : 
			medium_fit(thread_type);
//echo(swell_compensation(Imperial_die, "loose"));

function convert_inches_to_mm(inches) =
	inches * 25.4;
function	convert_mm_to_inches(mm) =
	mm/25.4;

//Metric_tap(diameter=8, length=12);				// M8x12
module Metric_tap(diameter=1, pitch=1, length=1, threads=1, thread_size=-1, groove=false, fit="medium")
{
	translate([0, 0, -length])
	metric_thread(
		diameter = corrected_diameter(diameter),
		pitch = pitch,
		length = length,
		internal = false,
		n_starts = threads,
		thread_size = thread_size,
		groove = groove);
}

//Metric_die(diameter=8, length=12);				// M8x12
module Metric_die(diameter, pitch=1, length=1, threads=1, thread_size=-1, groove=false, fit="medium")
{
	translate([0, 0, -length])
		metric_thread(
			diameter = corrected_diameter(diameter),
			pitch = pitch,
			length = length,
			internal = true,
			n_starts = threads,
			thread_size = thread_size,
			groove = groove);
}

//Imperial_tap();
module Imperial_tap(diameter=1/4, threads_per_inch=20, length=1, threads=1, thread_size=-1, groove=false, fit="medium")
{
	mm_diameter = convert_inches_to_mm(diameter);
	mm_pitch = (1.0/threads_per_inch)*25.4;
	mm_length = convert_inches_to_mm(length);

	translate([0, 0, -mm_length])
		metric_thread(
			diameter = corrected_diameter(mm_diameter),
			pitch = mm_pitch,
			length = mm_length,
			internal = false,
			n_starts = threads,
			thread_size = thread_size,
			groove = groove);
}

//Imperial_die();
module Imperial_die(diameter=1/1, threads_per_inch=20, length=1, threads=1, thread_size=-1, groove=false, fit="medium")
{
	mm_diameter = convert_inches_to_mm(diameter) + swell_compensation(Imperial_die, fit);
	mm_pitch = (1.0/threads_per_inch)*25.4;
	mm_length = convert_inches_to_mm(length);

	translate([0, 0, -mm_length])
		metric_thread(
			diameter = corrected_diameter(mm_diameter),
			pitch = mm_pitch,
			length = mm_length,
			internal = true,
			n_starts = threads,
			thread_size = thread_size,
			groove = groove);
}

//threads_help();
module threads_help()
{
	name = "threads.scad";
	description = "A library creating metric and imperial screw threads";
	types=[];
	accessors=[];
	properties = [];
	functions = [
		new_help_item(
			"convert_inches_to_mm(inches)",
			[	new_help_item_parameter("inches", "number", "value to convert in inches")],
			"Returns value in mm"),
		new_help_item(
			"convert_mm_to_inches(mm)",
			[	new_help_item_parameter("mm", "number", "value to convert in mm")],
			"Returns value in inches")
	];
	modules = [
		new_help_item(
			"Metric_tap(diameter=1, pitch=1, length=1, threads=1, thread_size=-1, groove=false)",
			[	new_help_item_parameter("diameter", "number", "thread diameter in mm"),
				new_help_item_parameter("pitch", "number", "thread pitch in mm"),
				new_help_item_parameter("length", "number", "thread length in mm"),
				new_help_item_parameter("threads", "number", "number of thread helixes"),
				new_help_item_parameter("thread_size", "number", "size of thread if non-standard (-1 = same as pitch)"),
				new_help_item_parameter("groove", "number", "set to true to subtract 'V' from cylinder")],
			"Create a metric screw thread"),
		new_help_item(
			"Metric_die(diameter=1, pitch=1, length=1, threads=1, thread_size=-1, groove=false)",
			[	new_help_item_parameter("diameter", "number", "thread diameter in mm"),
				new_help_item_parameter("pitch", "number", "thread pitch in mm"),
				new_help_item_parameter("length", "number", "thread length in mm"),
				new_help_item_parameter("threads", "number", "number of thread helixes"),
				new_help_item_parameter("thread_size", "number", "size of thread if non-standard (-1 = same as pitch)"),
				new_help_item_parameter("groove", "number", "set to true to subtract 'V' from cylinder")],
			"Create a metric screw thread with clearance for a hole"),
		new_help_item(
			"Imperial_tap(diameter=1/4, threads_per_inch=20, length=1, threads=1, thread_size=-1, groove=false)",
			[	new_help_item_parameter("diameter", "number", "thread diameter in inches"),
				new_help_item_parameter("threads_per_inch", "number", "number of threads per inch"),
				new_help_item_parameter("length", "number", "thread length in inches"),
				new_help_item_parameter("threads", "number", "number of thread helixes"),
				new_help_item_parameter("thread_size", "number", "size of thread if non-standard (-1 = same as pitch)"),
				new_help_item_parameter("groove", "number", "set to true to subtract 'V' from cylinder")],
			"Create an imperial screw thread"),
		new_help_item(
			"Imperial_die(diameter=1/4, threads_per_inch=20, length=1, threads=1, thread_size=-1, groove=false)",
			[	new_help_item_parameter("diameter", "number", "thread diameter in inches"),
				new_help_item_parameter("threads_per_inch", "number", "number of threads per inch"),
				new_help_item_parameter("length", "number", "thread length in inches"),
				new_help_item_parameter("threads", "number", "number of thread helixes"),
				new_help_item_parameter("thread_size", "number", "size of thread if non-standard (-1 = same as pitch)"),
				new_help_item_parameter("groove", "number", "set to true to subtract 'V' from cylinder")],
			"Create an imperial screw thread with clearance for a hole")
	];

	format_help(
		name=name,
		description=description,
		types=types,
		accessors=accessors,
		properties=properties,
		functions=functions,
		modules=modules);
}