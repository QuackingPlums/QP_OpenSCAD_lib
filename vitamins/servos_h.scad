//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Servos - header definitions
//

// Servo types

generic_9g = ["Generic 9g servo",						// name
	[23, 22, 12.5], "Steelblue",						// body
	[32, 2, 12.5], "Steelblue",							// mount tabs, colour
	4,												// shoulder height
	12, 25.75, 0,	"Steelblue",							// output shaft d, h (total), offset, colour
	4.7, 29.25, "White"								// spline d, h (total), colour
];

function servoName(servo) = servo[0];
function servoBody(servo) = servo[1];
function servoBodyColour(servo) = servo[2];
function servoMount(servo) = servo[3];
function servoMountColour(servo) = servo[4];
function servoShoulder(servo) = servo[5];
function servoOutputShaftDiameter(servo) = servo[6];
function servoOutputShaftHeight(servo) = servo[7];
function servoOutputShaftOffset(servo) = servo[8];
function servoOutputShaftColour(servo) = servo[9];
function servoSplineDiameter(servo) = servo[10];
function servoSplineHeight(servo) = servo[11];
function servoSplineColour(servo) = servo[12];

function servoBodyWidth(servo) = servoBody(servo)[0];		// x, in this orientation
function servoBodyHeight(servo) = servoBody(servo)[1];		// y, in this orientation
function servoBodyThick(servo) = servoBody(servo)[2];		// z, in this orientation
function servoMountLength(servo) = servoMount(servo)[0];	// x
function servoMountThick(servo) = servoMount(servo)[1];	// y
function servoMountWidth(servo) = servoMount(servo)[2];	// z
