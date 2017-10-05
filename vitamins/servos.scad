//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Servos
//

include <servos_h.scad>;
use <../docSCAD.scad>;							//docSCAD_help();
use <../common.scad>;


Servo();
module Servo(type=generic_9g, colour=true)
{
	body = servoBody(type);
	bodyColour = colour?servoBodyColour(type):0;
	bodyWidth = servoBodyWidth(type);
	bodyHeight = servoBodyHeight(type);
	bodyThick = servoBodyThick(type);
	mount = servoMount(type);
	mountColour = colour?servoMountColour(type):0;
	mountLength = servoMountLength(type);
	mountThick = servoMountThick(type);
	mountWidth = servoMountWidth(type);
	shoulder = servoShoulder(type);
	outputShaftColour = colour?servoOutputShaftColour(type):0;
	outputShaftDiameter = servoOutputShaftDiameter(type);
	outputShaftHeight = servoOutputShaftHeight(type);
	outputShaftOffset = servoOutputShaftOffset(type);
	splineColour = colour?servoSplineColour(type):0;
	splineDiameter = servoSplineDiameter(type);
	splineHeight = servoSplineHeight(type);

	// body
	color(bodyColour)
		cube(body);
	// mount
	translate([
		(bodyWidth-mountLength)/2, 	bodyHeight-mountThick-shoulder, (bodyThick-mountWidth)/2])
		color(mountColour)
			cube(mount);
	position(
		rotate=[-90, 0, 0],
		translate=[outputShaftDiameter/2 + outputShaftOffset, 0, outputShaftDiameter/2])
	{
		// output shaft collar
		color(outputShaftColour)
			cylinder(d=outputShaftDiameter, h=outputShaftHeight);
		// spline
		translate([0, 0, 0.01])
		color(splineColour)
			cylinder(d=splineDiameter, h=splineHeight);
	}
}

servos_help();
module servos_help()
{
	formatHelp_simple(
		libraryName = "servos.scad",
		description = str("Servo placeholders for the following servos:<p>",
			"<b>generic_9g</b> - generic blue 9g servo"
		),
		members = [
			new_member(
				name="Servo",
				description=[
					"Render a servo",
					"",
					"type = Servo type (see above)",
					"colour = true|false"
					],
				parameters="type, colour"
			)
		]
	);
}