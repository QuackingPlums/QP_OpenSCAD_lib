n = 6;			// n-polygon
a = 360/n;		// angle

ir = 30;			// inner circumradius
xr = 52;			// outer circumradius can we calculate these?

for (i = [0 : n - 1])
	rotate([0, 0, i * a])
		polygon([[xr, 0], [ir * cos(a/2), ir * sin(a/2)], [ir * cos(a/2), -ir * sin(a/2)]]);