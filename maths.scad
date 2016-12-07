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

function pythagoras(hyp, s, s1, s2) =
	(hyp!=undef && s!=undef)?sqrt(pow(hyp,2)-pow(s,2)):					// hypoteneuse and one side
		(s1!=undef && s2!=undef)?sqrt(pow(s1,2)+pow(s2,2)):				// two sides
			undef;
