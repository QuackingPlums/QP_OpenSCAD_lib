//
// QP_OpenSCAD_lib
//
// GNU GPL v3
// quackingplums@gmail.com
//
// Fasteners - header definitions
//

// useful references:
// http://www.csgnetwork.com/screwsochdcaptable.html
// http://www.roymech.co.uk/Useful_Tables/Screws/cap_screws.htm
// http://www.numberfactory.com/nf%20metric%20screws%20and%20bolts.htm
// http://www.numberfactory.com/nf_metric.html

/////////////////////
// Metric/ISO/US sizes

M2 =		["M2", 2, 2.2];
M3 =		["M3", 3, 3.3];
M4 =		["M4", 4, 4.3];
M5 =		["M5", 5, 5.3];
No2 =	["No2", 1.7, 2.5];		// 2.2mm nominal, 1.7 into ABS, 

function metric_name(size) = size[0];
function metric_diameter(size) = size[1];
function metric_clearance_diameter(size) = size[2];

function metric_radius(size) = metric_diameter(size) / 2;
function metric_clearance_radius(size) = metric_clearance_diameter(size) / 2;


/////
// Head types
cap_head =	["cap head screw"];
hex_head =	["hex screw"];
btn_head =	["button head screw"];
csk_head =	["countersunk screw"];

function screw_type(head_type) = head_type[0];

function head() = cylinder([10]);


///////////
// Screws
M2_washer = "defined later";
M3_washer = "defined later";
M4_washer = "defined later";
M5_washer = "defined later";

// Screw types
M2_cap_screw =	[M2, cap_head,				// aka socket screw
				3.8, 4.0, 2.0, M2_washer];
M3_cap_screw =	[M3, cap_head,
				5.5, 5.8, 3.0, M3_washer];
M3_btn_screw =	[M3, btn_head,
				5.7, 6.0, 1.65, M3_washer];
M3_csk_screw =	[M3, csk_head,
				6.0, 6.72, 1.86];
M4_cap_screw =	[M4, cap_head,
				7.0, 7.3, 4.0, M4_washer];
M5_cap_screw =	[M5, cap_head,
				8.5, 8.8, 5.0, M5_washer];
M3_hex_screw =	[M3, hex_head,				// aka hex set screw or hex bolt
				6.35, 6.65, 2, M3_washer];
M4_hex_screw =	[M4, hex_head,
				8.08, 8.38, 2.8, M4_washer];
M5_hex_screw =	[M5, hex_head,
				9.24, 9.54, 3.5, M5_washer];

No2_self_tapping = [No2, "self tapping screw",	// aka sheet metal screw
				4.1, 4.3, 2.0, M2_washer];

function head_test(screw_type) = head();

function screw_size(screw_type) = metric_name(screw_type[0]);
function screw_head_type(screw_type) = screw_type[1];
function screw_name(screw_type) = screw_type(screw_type[1]);
function screw_head_diameter(screw_type) = screw_type[2];
function screw_head_clearance_diameter(screw_type) = screw_type[3];
function screw_head_height(screw_type) = screw_type[4];
function screw_washer(screw_type) = screw_type[5];

function screw_diameter(screw_type) = metric_diameter(screw_type[0]);
function screw_clearance_diameter(screw_type) = metric_clearance_diameter(screw_type[0]);
function screw_radius(screw_type) = screw_diameter(screw_type) / 2;
function screw_clearance_radius(screw_type) = screw_clearance_diameter(screw_type) / 2;
function screw_head_radius(screw_type) = screw_head_diameter(screw_type) / 2;
function screw_head_clearance_radius(screw_type) = screw_head_clearance_diameter(screw_type) / 2;

function select_screw(length = 7) = ceil(length / 2) * 2;	// round up to the nearest even number!


/////////
// Nuts

// http://en.wikipedia.org/wiki/Nut_(hardware)

// Nut types
M2_nut =		[M2, "nut",
			4.62, 4.72, 1.6, 1.8, 2.0];
m2_nyloc =	[M2, "nyloc",
			4.62, 4.72, 2.6, 2.6, 2.0];
M3_nut =		[M3, "nut", 
			6.35, 6.55, 2.4, 2.6, 3.0];
M3_nyloc =	[M3, "nyloc nut", 
			6.35, 6.55, 4.0, 4.2, 3.0];
M4_nut = 	[M4, "nut", 
			8.07, 8.27, 3.2, 3.4, 4.0];
M4_nyloc = 	[M4, "nyloc nut", 
			8.07, 8.27, 5.0, 5.2, 4.0];
M5_nut = 	[M5, "nut", 
			9.24, 9.44, 4.0, 4.2, 5.0];
M5_nyloc = 	[M5, "nyloc nut", 
			9.24, 9.44, 5.0, 5.2, 5.0];

function nut_size(nut_type) = metric_name(nut_type[0]);
function nut_variant(nut_type) = nut_type[1];
function nut_diameter(nut_type) = nut_type[2];
function nut_clearance_diameter(nut_type) = nut_type[3];
function nut_height(nut_type) = nut_type[4];
function nut_clearance_height(nut_type) = nut_type[5];
function nut_trap_depth(nut_type) = nut_type[6];	// this is the distance below the "surface"

function nut_thread(nut_type) = metric_diameter(nut_type[0]);
function nut_radius(nut_type) = nut_diameter(nut_type) / 2;
function nut_clearance_radius(nut_type) = nut_clearance_diameter(nut_type) / 2;
function nut_nylon_height(nut_type) = nut_nyloc_height(nut_type) - nut_height(nut_type);
function nut_flat_diameter(nut_type) = nut_diameter(nut_type) * cos(30);
function nut_flat_clearance_diameter(nut_type) = nut_clearance_diameter(nut_type) * cos(30);
function nut_flat_radius(nut_type) = nut_radius(nut_type) * cos(30);
function nut_flat_clearance_radius(nut_type) = nut_clearance_radius(nut_type) * cos(30);


////////////
// Washers

// http://www.a2stainless.co.uk/Metric-Washers-Dimensional-Data_AHDHV.aspx

// Washer types
M2_washer = [M2, "washer", metric_clearance_diameter(M2), 5.5, 0.3];
M3_washer = [M3, "washer", metric_clearance_diameter(M3), 7, 0.6];
M3_12mm_penny_washer = [M3, "penny washer", metric_clearance_diameter(M3), 12, 0.8];
M4_washer = [M4, "washer", metric_clearance_diameter(M4), 9, 0.8];
M4_washer_c = [M4, "form C washer", metric_clearance_diameter(M4), 9.8, 1];
M5_washer = [M5, "washer", metric_clearance_diameter(M5), 10.0, 1.0];
M5_washer_c = [M5, "form C washer", metric_clearance_diameter(M5), 12.0, 1];

function washer_size(washer_type) = str(metric_name(washer_type[0]), washer_type[1] == "washer" ? "" : str("x", washer_type[3],"x", washer_type[4]));
function washer_variant(washer_type) = washer_type[1];
function washer_bore_diameter(washer_type) = metric_clearance_diameter(washer_type[0]);
function washer_outer_diameter(washer_type) = washer_type[3];
function washer_thickness(washer_type) = washer_type[4];

function washer_bore_radius(washer_type) = washer_bore_diameter(washer_type) / 2;
function washer_outer_radius(washer_type) = washer_outer_diameter(washer_type) / 2;

/////////////////////////
// Studing & set screws

// Stud/set types
M3_stud = [M3, "threaded stud", M3_nyloc];
M4_stud = [M4, "threaded stud", M4_nyloc];
M5_stud = [M5, "threaded stud", M5_nyloc];

function stud_size(stud_type) = metric_name(stud_type[0]);
function stud_description(stud_type) = stud_type[1];
function stud_nyloc(stud_type) = stud_type[2];

function stud_diameter(stud_type) = metric_diameter(stud_type[0]);
function stud_clearance_diameter(stud_type) = metric_clearance_diameter(stud_type[0]);

function stud_radius(stud_type) = stud_diameter(stud_type) / 2;
function stud_clearance_radius(stud_type) = stud_clearance_diameter(stud_type) / 2;


function select_length(length = 7) = (length > 16) ? length :  ceil(length / 2) * 2; // round up small sizes to next largest even number
