function point(x, y) = [x, y];
function x(point) = point[0];
function y(point) = point[1];

function line(point1, point2) = [point1, point2];
function point1(line) = line[0];
function point2(line) = line[1];

function line_coeff_A(line) = y(point2(line)) - y(point1(line));
function line_coeff_B(line) = x(point1(line)) - x(point2(line));
function line_coeff_C(line) = line_coeff_A(line)*x(point1(line)) + line_coeff_B(line)*y(point1(line));

function determinant(line1, line2) =
	line_coeff_A(line1)*line_coeff_B(line2) -
	line_coeff_A(line2)*line_coeff_B(line1);

function line_intersection_x(line1, line2) =
	(line_coeff_B(line2)*line_coeff_C(line1) - line_coeff_B(line1)*line_coeff_C(line2))/determinant(line1, line2);

function line_intersection_y(line1, line2) =
	(line_coeff_A(line1)*line_coeff_C(line2) - line_coeff_A(line2)*line_coeff_C(line1))/determinant(line1, line2);

function line_intersection(line1, line2) =
	point(
		line_intersection_x(line1, line2),
		line_intersection_y(line1, line2));


example();
module example()
{
	line1 = line(point(-10, 0), point(10, 0));
	line2 = line(point(0, 5), point(5, -1));;
	
	echo(line1);
	echo(line2);
	echo(line_coeff_A(line1));
	echo(line_coeff_B(line1));
	echo(line_coeff_C(line1));
	echo(determinant(line1, line2));
	echo(line_intersection(line1, line2));
}