/**************************************************
| 2D and 3D pie slices
**************************************************/

ff = 0.05;											// fudge factor
$fs = 1.0;											// CSG segment size (mm)
$fa = 5;												// CSG minimum angle (degrees)

translate([3, 3, 0]) rounded_pie_slice_3D(30, 0, 60, 3, 3);
module rounded_pie_slice_3D(r, start_angle, end_angle, h, corner_radius)
{
	linear_extrude(height = h)
		rounded_pie_slice_2D(r, start_angle, end_angle, corner_radius);
}

//pie_slice_3D(30, 0, 60, 3);
module pie_slice_3D(r, start_angle, end_angle, h)
{
	linear_extrude(height = h)
		pie_slice_2D(r, start_angle, end_angle);
}

//translate([3, 3, 0]) rounded_pie_slice_2D(30, 0, 60, 3);
module rounded_pie_slice_2D(r, start_angle, end_angle, corner_radius)
{
	minkowski()
	{
		pie_slice_2D(r, start_angle, end_angle);
		circle(r = corner_radius);
	}
}

//pie_slice_2D(30, 0, 60);
module pie_slice_2D(r, start_angle, end_angle)
{
    R = r * sqrt(2) + 1;
    a0 = (4 * start_angle + 0 * end_angle) / 4;
    a1 = (3 * start_angle + 1 * end_angle) / 4;
    a2 = (2 * start_angle + 2 * end_angle) / 4;
    a3 = (1 * start_angle + 3 * end_angle) / 4;
    a4 = (0 * start_angle + 4 * end_angle) / 4;
    if(end_angle > start_angle)
        intersection() {
        circle(r);
        polygon([
            [0,0],
            [R * cos(a0), R * sin(a0)],
            [R * cos(a1), R * sin(a1)],
            [R * cos(a2), R * sin(a2)],
            [R * cos(a3), R * sin(a3)],
            [R * cos(a4), R * sin(a4)],
            [0,0]
       ]);
    }
}