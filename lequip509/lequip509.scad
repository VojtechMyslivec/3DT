module lequip509(
                 h = 17,
                 d = 75,
                 thickness = 3.2,

                 h_inner = 3.5,
                 d_inner = 56,

                 s_outer_w = 23,
                 s_outer_l = 6,

                 s_inner_w = 27.5,
                 s_inner_h = 4,
                 s_inner_l = 3.5,

                 //cut_angle = 36 * 2,
                 cut_w = 37,
                 cut_l = 2,
                ) {

    d_outer = d + 2*thickness;

    intersection() {
        union() {
            // outer
            difference() {
                union() {
                    // shell
                    cylinder(h=h, d=d_outer);
                    // outer stumps
                    for (i=[0:60:359])
                        rotate([0,0,i])
                            translate([0,-s_outer_w/2,0])
                                cube([d_outer/2+s_outer_l,s_outer_w,h]);
                }
                // hole
                translate([0,0,-1])
                    cylinder(h=h+2, d=d);
            }


            // inner
            difference() {
                cylinder(h=h_inner, d=d_outer);
                translate([0,0,-1])
                    cylinder(h=h_inner+2, d=d_inner);

                // cut out
                intersection() {
                    translate([0,-cut_w/2,-1])
                        cube([d_outer/2,cut_w,h_inner+2]);
                    translate([0,0,-1])
                        cylinder(d=d_inner+cut_l*2,h=h_inner+2);
                }
            }

            // inner stumps
            intersection() {
                difference() {
                    for (i=[0:120:359])
                        rotate([0,0,i])
                            translate([0,-s_inner_w/2,h-s_inner_h])
                                cube([d_outer/2,s_inner_w,s_inner_h]);
                    // inner hole
                    translate([0,0,-1])
                        cylinder(h=h+2, d=d-s_inner_l*2);
                }
                // outer shell border
                cylinder(h=h+2, d=d_outer);
            }

        }

        // round corners
        translate([0,0,-d_outer+1.7*h])
            sphere(r=d_outer);
    }


}

lequip509($fn=100);
