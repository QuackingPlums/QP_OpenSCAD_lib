//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Cameras - header definitions
//

// Camera types
GoPro_HD_Hero3_Black = ["GoPro HD Hero3: Black Edition",		// GoPro HD Hero3	 ** VERIFIED **
	59.1, 41, 21.1,					// width, height, depth
	"None",							// mount type ** DEPRECATED **
	23.0, 15.05, 7.85, 7.0, 1.2];		// lens diameter, lens x-offset, lens y-offset, lens z-offset (from center), lens dome

// mass = 75g
// CoG left/right ~ 30mm/30mm
// CoG top/bottom ~ 22mm/18mm
// CoG front/back ~ 12mm/9mm
// FoV = 114mm

GoPro_HD_Hero2 = ["GoPro HD Hero2",							// GoPro HD Hero2 ** VERIFIED **
	60.1, 42.1, 30.1,					// width, height, depth
	"None",							// mount type ** DEPRECATED **
	20.0, 14.6, 6, 3.6, 2.0];			// lens diameter, lens x-offset, lens y-offset, lens z-offset (from center), lens dome

GoPro_HD_Hero = ["GoPro HD Hero",								// GoPro HD Hero ** VERIFIED **
	60.1, 41.9, 30.15,					// width, height, depth
	"None",							// mount type ** DEPRECATED **
	20.2, 14.6, 6, 3.6, 1.5];			// lens diameter, lens x-offset, lens y-offset, lens z-offset (from center), lens dome

Panasonic_GF3 = ["Panasonic Lumix DMC-GF3",
	107.7, 67.1, 32.5,
	"1/4inUNC",
	56, 10, 28, -3, 0];

Sony_NEX5N = ["Sony NEX-5N",
	111, 59, 38,
	"1/4inUNC",
	0, 0, 0, 0, 0];

Mobius = ["Mobius ActionCam",								// Mobius ActionCam ** VERIFIED **
	35.50, 18.5, 59,					// width, height, depth
	"None",							// mount type ** DEPRECATED **
	18.5, 9.25, 2.5, 0, 0];			// lens diameter, lens x-offset, lens y-offset, lens z-offset (from center), lens dome

DJI_Phantom3_Pro = ["DJI Phantom3 Pro",						// DJI Phantom 3 Pro
	0, 0, 0,							// width, height, depth (unlikely to ever need this on P3!)
	"None",							// mount type ** DEPRECATED **
	35.0, 0, 9.0, 0, 1.0,				// lens diameter, lens x-offset, lens y-offset, lens z-offset (from center), lens dome
	"Sony EXMOR IX220", "1/2.3\"",		// sensor name, sensor type
	6.30, 4.72, -1.0, 94];				// sensor width, sensor height, sensor depth, sensor FoV

/*
name
width
height
depth
mount type							*** DEPRECATED ***
lens diameter
lens x-offset		(from center)
lens y-offset		(from front of body - how far main ring sticks out)
lens z-offset		(from center)
lens dome			(glass protrusion from lens body - added to y-offset)
sensor name		(e.g. Sony EXMOR IMX220)
sensor type		(e.g. 1/2.3")
sensor width
sensor height
sensor depth		(offset from front face of camera body, should be -ve)
sensor_FoV		(field of view - should be a single value based on circular lens)
*/

function camera_name(camera_type) = camera_type[0];
function camera_width(camera_type) = camera_type[1];
function camera_height(camera_type) = camera_type[2];
function camera_depth(camera_type) = camera_type[3];
function camera_mount_type(camera_type) = camera_type[4];
function camera_lens_diameter(camera_type) = camera_type[5];
function camera_lens_dx(camera_type) = camera_type[6];
function camera_lens_dy(camera_type) = camera_type[7];
function camera_lens_dz(camera_type) = camera_type[8];
function camera_lens_dome(camera_type) = camera_type[9];
function camera_sensor_name(camera_type) = camera_type[10];
function camera_sensor_type(camera_type) = camera_type[11];
function camera_sensor_width(camera_type) = camera_type[12];
function camera_sensor_height(camera_type) = camera_type[13];
function camera_sensor_depth(camera_type) = camera_type[14];
function camera_sensor_FoV(camera_type) = camera_type[15];
