/*
 * Module: project_12mm_hex_wheel_adaptors.scad
 * this generates an adaptor the connects standard RC wheel 12mm hex nut
 *   wheels to standard robotics motor hubs  
 *
 *   NOTE that hub adaptors should be printed slowly -- about 50% normal print speed 
 *
 * Author(s): Don Korte 
 *
 * github: https://github.com/dnkorte/
 *  
 * MIT License
 * 
 * Copyright (c) 2022 Don Korte
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */


/* [What PART do you want to model?] */
part = "80mm_DFR_wheel_5";  // [ "80mm_DFR_wheel_6", "80mm_DFR_wheel_5", "80mm_DFR_wheel_4", "48mm_DFR_wheel (NOT)", "test" ]

shaft = 4; // [ 6:6mm, 5:5mm, 4:4mm ]

// length of "round" part of adaptor that surrounds axle
hub_len = 15;   // [12, 15, 18, 20 ]

/* [Grub Screw Details] */
// distance of "first" grub screw from motor end of adaptor
grubscrew_dist_from_end = 4;    // [ 3, 4, 5, 6 ]
// distance between grub screws
grubscrew_separation = 3;       // [ 2, 3, 4, 5, 6, 7, 8 ] 
// grubscrew type
grubscrew_type = 3;  // [ 1:"M3 selftap", 2:"M2.5 selftap", 3:"M3 insert", 4:"M2.5 insert" ]
// wall thickness where screws are (for self-tap or TI)
screw_area_thickness = 6;       // [ 3, 4, 5, 6, 7 ]




draw_part();

module draw_part() {
    $fn = 24;

    if (part == "80mm_DFR_wheel_6") {
        //draw_80mm_dfr_adaptor();
        draw_80mm_dfr_adaptor_A(6);
    }
    if (part == "80mm_DFR_wheel_5") {
        //draw_80mm_dfr_adaptor();
        draw_80mm_dfr_adaptor_A(5);
    }
    if (part == "80mm_DFR_wheel_4") {
        //draw_80mm_dfr_adaptor();
        draw_80mm_dfr_adaptor_A(4);
    }
    if (part == "48mm_adaptor") {
        //draw_48mm_dfr_adaptor();
    }
    if (part == "test") {
        draw_80mm_dfr_adaptor_A();
    }
}
/*
 * hub adaptor parameters that are not displayed in OpenScad Customizer
 */

// standard parameters for all parts
screwhole_radius_M30_passthru = 2;  
screwhole_radius_M30_selftap = 1.45;
screwhole_radius_M25_passthru = 1.8;  
screwhole_radius_M25_selftap = 1.25; 
TI30_through_hole_diameter = 4.3; 
TI25_through_hole_diameter = 4.1;  
axle_clearance_gap = 0.7;   // allowance for 3d printer "slop" + slide fit


// parameters for the motor insert "nut"
screwhole_dia_wheel_attachment_screw = (screwhole_radius_M30_selftap * 2);

width_across_flats_80mm_dfr = 6.5;
nut_length_80mm_dfr = 12;
max_apron_dia_80mm = 25;
width_across_flats_48mm_dfr = 6.0;
nut_length_48mm_dfr = 12;
max_apron_dia_48mm = 22;
TT_shaft_dia = 5.3 + axle_clearance_gap;
TT_shaft_flatwidth = 3.8 + axle_clearance_gap;


module draw_80mm_dfr_adaptor_A(motor_shaft_dia = 4) {
    hub_dia_fat = motor_shaft_dia + 2*(screw_area_thickness);   // dia at motor end

    g1 = grubscrew_dist_from_end;
    g2 = grubscrew_dist_from_end + grubscrew_separation;


    translate([ 0, 0, hub_len ]) make_hex_nut(width_across_flats_80mm_dfr, nut_length_80mm_dfr, screwhole_dia_wheel_attachment_screw);
    

    difference() {  
        cylinder(d=(hub_dia_fat), h=hub_len);
        translate([ 0, 0, -0.1 ]) cylinder(d=motor_shaft_dia + axle_clearance_gap, h=hub_len - 1);

        if (grubscrew_type == 1) {
            // M3 selftap
            translate([ 0, 0, g1 ]) rotate([  -90, 0, 180  ])  
                cylinder( r=screwhole_radius_M30_selftap, h=hub_dia_fat);
            translate([ 0, 0, g2 ]) rotate([  -90, 0, 0  ])  
                cylinder( r=screwhole_radius_M30_selftap, h=hub_dia_fat);

        } else if (grubscrew_type == 2) {
            // M2.5 selftap
            translate([ 0, 0, g1 ]) rotate([  -90, 0, 180  ])  
                cylinder( r=screwhole_radius_M25_selftap, h=hub_dia_fat);
            translate([ 0, 0, g2 ]) rotate([  -90, 0, 0  ])  
                cylinder( r=screwhole_radius_M25_selftap, h=hub_dia_fat);

        } else if (grubscrew_type == 3) {
            // M3 threaded insert
            translate([ 0, 0, g1 ]) rotate([  -90, 0, 180  ])  
                cylinder( d=TI30_through_hole_diameter, h=hub_dia_fat);
            translate([ 0, 0, g2 ]) rotate([  -90, 0, 0  ])  
                cylinder( d=TI30_through_hole_diameter, h=hub_dia_fat);
        
        } else if (grubscrew_type == 4) {
            // M2.5 threaded insert
            translate([ 0, 0, g1 ]) rotate([  -90, 0, 180  ])  
                cylinder( d=TI25_through_hole_diameter, h=hub_dia_fat);
            translate([ 0, 0, g2 ]) rotate([  -90, 0, 0  ])  
                cylinder( d=TI25_through_hole_diameter, h=hub_dia_fat);
        
        }
    } 
}


module draw_80mm_dfr_adaptor() {
    hub_dia = 12;

    g1 = hub_len - grubscrew_dist_from_end;
    g2 = hub_len - grubscrew_dist_from_end - grubscrew_separation;
    apron_dia = min((2*(g2+3)), max_apron_dia_80mm);

    translate([ 0, 0, hub_len + nut_length_80mm_dfr ]) rotate([ 180, 0, 0 ]) union() {
        make_hex_nut(width_across_flats_80mm_dfr, nut_length_80mm_dfr, screwhole_dia_wheel_attachment_screw);
    
        // translate and rotate this part because i generated it assuming nut is down
        // but it should be printed with nut up...

        translate([ 0, 0, nut_length_80mm_dfr ]) difference() {
            union() {
                cylinder(d=hub_dia, h=hub_len);
                translate([ 0, -(hub_dia+3)/2, g1 ]) rotate([  -90, 0, 0  ])  cylinder( d=5, h=hub_dia+3);
                translate([ 0, -(hub_dia+3)/2, g2 ]) rotate([  -90, 0, 0  ])  cylinder( d=5, h=hub_dia+3);
                //cylinder (d1=apron_dia, d2=6, h=g2);
            }

            if (shaft == 0) {
                // this is a TT shaft
                translate([ 0, 0, -0.1 ]) shaft_flat(TT_shaft_dia, TT_shaft_flatwidth, hub_len + 0.2, orientation="wide");
            } else {
                // this is a round shaft with specified diameter
                translate([ 0, 0, -0.1 ]) cylinder(d=shaft, h=hub_len + 0.2);
            }


            translate([ 0, -((hub_dia+3)/2)-0.1, g1 ]) rotate([  -90, 0, 0  ])  cylinder( r= screwhole_radius_M30_selftap, h=hub_dia+3.2);
            translate([ 0, -((hub_dia+3)/2)-0.1, g2 ]) rotate([  -90, 0, 0  ])  cylinder( r= screwhole_radius_M30_selftap, h=hub_dia+3.2);
        } 
    }
}

module test() {
    difference() {
        roundedbox(50, 40, 3, 4);
        //translate([ 21, 16, -0.1 ]) cylinder( d=3.5, h=4.2);
        translate([ 16, 16, -0.1 ]) cylinder( d=3.5, h=4.2);
        translate([ 16, 0, -0.1 ]) cylinder( d=3.5, h=4.2);
        translate([ 16, -16, -0.1 ]) cylinder( d=3.5, h=4.2);

        translate([ 0, 16, -0.1 ]) cylinder( d=3.5, h=4.2);
        translate([ 0, 0, -0.1 ]) cylinder( d=3.5, h=4.2);
        translate([ 0, -16, -0.1 ]) cylinder( d=3.5, h=4.2);

        translate([ -16, 16, -0.1 ]) cylinder( d=3.5, h=4.2);
        translate([ -16, 0, -0.1 ]) cylinder( d=3.5, h=4.2);
        translate([ -16, -16, -0.1 ]) cylinder( d=3.5, h=4.2);
    }
}

module nut_tester() {
    cube([ 15, 15, 2 ], center=true);
    make_hex_nut(6.6, 15, screwhole_dia_wheel_attachment_screw);
}



/*
 * module prism generates a basic "wedge" shape that can be used vertically to make support-less
 * 3d-printable shelves; this is defined in openSCAD documetation at:
 *      https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Primitive_Solids
 */

module prism(l, w, h){
   polyhedron(
           points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
           faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
           );
}

/*
 * ***************************************************************************
 * module shaft_flat() makes a flattened shaft
 * this is a round cylinder, with flats on 2 sides (ie for a TT motor)
 *  
 * this is generated in xy plane, centered at origin, pointed "up" (towards + Z)
 * it should be "added" to design, there are no holes needed at placement level
 *
 * for TT motor, assume actual 5.3 diameter, with flatwidth 3.8mm;  but leave clearance gap too
 *
 * parameters:
 *      diameter    diameter of round part of shaft, in mm
 *      flatwidth   dimension across flat part in mm (flat-to-flat)
 *      length      length (or height) of shaft
 *      orientation "tall" or "wide" 
 *          (for tall, initial flats are on left/right (+/- x sides))
 * ***************************************************************************
 */
module shaft_flat(diameter, flatwidth, length, orientation="tall") {
    remove_from_each_side = (diameter - flatwidth) / 2;

    if (orientation == "tall") {
        difference() {
            cylinder(r=(diameter/2), h=length);
            translate([ -(diameter/2), -(diameter/2), -0.1 ]) 
                cube([ remove_from_each_side, diameter, length+0.2 ]);
            translate([ (diameter/2)-remove_from_each_side, -(diameter/2), -0.1 ]) 
                cube([ remove_from_each_side, diameter, length+0.2 ]);
        }
    } else {
        rotate([ 0, 0, -90 ]) difference() {
            cylinder(r=(diameter/2), h=length);
            translate([ -(diameter/2), -(diameter/2), -0.1 ]) 
                cube([ remove_from_each_side, diameter, length+0.2 ]);
            translate([ (diameter/2)-remove_from_each_side, -(diameter/2), -0.1 ]) 
                cube([ remove_from_each_side, diameter, length+0.2 ]);
        }
    }
}

/*
 * hex nut generator, from
 * https://github.com/chrisspen/openscad-extra
 */


module make_hex_nut(w, h, d=0){
    // d = inner diameter
    // w = width across the flats
    // h = height or thickness
    s = w/sqrt(3);
    $fn = 100;
    
    translate([ 0, 0, h/2 ]) difference(){
        union(){
            for(i=[0:1:2]){
                rotate([0,0,120*i])
                cube([w, s, h], center=true);
            }
        }
        if(d){
            cylinder(d=d, h=h+1, center=true);
        }
    }
}

/*
 * this generates a box with rounded corners
 * the box is centered on the origin, running "up" from z=0
 * reference: https://hackaday.com/2018/02/13/openscad-tieing-it-together-with-hull/
 */
module roundedbox(x, y, radius=3, height=3) {
    left_x = -(x/2) + radius;
    right_x = (x/2) - radius;
    bottom_y = -(y/2) + radius;
    top_y = +(y/2) - radius;
    
    points = [ [left_x, bottom_y,0], [left_x, top_y,0], [right_x, top_y,0], [right_x, bottom_y,0] ]; 
    hull() {
        for (p=points) {
            translate(p) cylinder(r=radius, h=height);
        }
    }
}