/**************************************************
| Modules for building simple bases that allow
| PCB-based boards (such as VTx modules, OSDs, etc)
| to be clipped in to place and held securely.
**************************************************/

$fn = 12;
ff = 0.05;						// fudge factor

// machine settings
extrusion_width = 0.5;
layer_height = 0.2;

// static/default settings
ww = extrusion_width * 2;			// always a multiple of extrusion width
default_lip_height = 1.6;	
default_ledge_depth =			// also used for clip reach
	2*extrusion_width;
default_thick = 1.2;

// properties
function ww() =
	ww;


//Clip(width = 8, height = 7, extend = 4);
module Clip(width, height, clip_reach = ww, extend = 0)
{
	if (width == undef)
		echo("<b>Usage:</b> Clip(width, height, clip_reach, extend);");

	translate([0, -ww, 0])
	{
		// base
		cube([width, ww, height+ff]);

		// rake
		hull()
		{
			translate([0, 0, height])
				cube([width, ww, ff]);
			translate([0, 0, height + clip_reach])
				cube([width, ww + clip_reach, ff]);
		}

		// lever
		hull()
		{
			translate([0, 0, height + clip_reach])
				cube([width, ww + clip_reach, ff]);
			translate([0, 0, height + 2*clip_reach + extend - ff])
				cube([width, extrusion_width, ff]);
		}
	}	
}

//Ledge(width = 8, height = 5);
module Ledge(width, height, lip_height = default_lip_height, ledge_depth = default_ledge_depth)
{
	if (width == undef)
		echo("<b>Usage:</b> Ledge(width, height, lip_height, ledge_depth);");

	translate([0, -ww, 0])
	{
		// base
		cube([width, ww + ledge_depth, height]);

		// lip
		cube([width, ww, height + lip_height]);
	}
}

