//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Simple text modules using the makerbot lo-res font
//

use <Makerbot font (Thingiverse 22730)/font_DesignerBlock_lo.scad>;

layer_height = 0.2;
extrusion_width = 0.3;

translate([0, 30, 0])
	text(text = "qp", size = 9, height = layer_height, width = extrusion_width, spacing = 1.05, align = "C");

outline(text = "qp", size = 4, height = layer_height, width = extrusion_width, spacing = 1.05, align = "C");

module text(text, size=5.0, height=1.0, spacing=1.0, align="C")
{
	label(text=text, size=size, height=height, spacing=spacing, align=align);
}

module outline(text, size=5.0, height=1.0, width=0.4, spacing=1.0, align="C")
{
	body_height = size * 5;	// fudged. Don't know the baseline offset for this font
	label_width = label_width(text=text, len=len(text), size=size, spacing=spacing) + 10;
	echo(str("label width: ", label_width));

	render()
		intersection()
		{
			difference()
			{
				minkowski()
				{
					label(text, size=size, height=height, spacing=spacing, align=align);
					cylinder(h=height, r=width*2);
				}
				label(text, size=size, height=height, spacing=spacing, align=align);
			}
			translate([-label_width/2, -body_height/2, 0])
				cube([label_width,body_height,height]);
		}
}
