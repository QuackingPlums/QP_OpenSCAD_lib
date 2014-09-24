//
// Maths library
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Useful maths functions
//

/* Intersecting chord theorem
chord, w:		width of line intersecting two points on a circle  (creating a segment)
sagitta, h:	height of the segment created by the chord

segment radius r =  h/2  +  w^2 / 8h
*/
function segment_radius(w, h) =
	(h/2) + pow(w,2)/(8*h);

