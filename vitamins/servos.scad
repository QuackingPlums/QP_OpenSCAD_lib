//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Servos
//

include <servos_h.scad>;
use <../common.scad>;


echo(servoBodyThick(generic_9g));

Servo();
module Servo(type=generic_9g)
{
	body = servoBody(type);
	bodyColour = servoBodyColour(type);
	bodyWidth = servoBodyWidth(type);
	bodyHeight = servoBodyHeight(type);
	bodyThick = servoBodyThick(type);
	mount = servoMount(type);
	mountColour = servoMountColour(type);
	mountLength = servoMountLength(type);
	mountThick = servoMountThick(type);
	mountWidth = servoMountWidth(type);
	shoulder = servoShoulder(type);
	outputShaftColour = servoOutputShaftColour(type);
	outputShaftDiameter = servoOutputShaftDiameter(type);
	outputShaftHeight = servoOutputShaftHeight(type);
	outputShaftOffset = servoOutputShaftOffset(type);
	splineColour = servoSplineColour(type);
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