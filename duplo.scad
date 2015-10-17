/**
 * Lego brick
 * @author Vojtech Myslivec
 * @param num_x pocet pinu na ose x
 * @param num_y pocet pinu na ose y
 * @param num_z vyska na ose z v jednotkach lega dupla, obycejny dil ma 2 jednotky
 * @param smooth jestli dil ma byt hladky nebo ne 
 */

module duplo(
    num_x   = 4,
    num_y   = 2,
    num_z   = 2,
    smooth  = false
) {
    // konstanty
    layer_height = 9.5;
    pin_radius   = 9.35/2;
    pin_height   = 14.2 - layer_height;
    pin_distance = 25.35-pin_radius*2;
    wall_thick   = 3.35;
    stred_radius = 13.15/2;

    mezera  = pin_distance - 2*pin_radius;

    kostka_x    = num_x * (mezera + pin_radius*2);
    kostka_y    = num_y * (mezera + pin_radius*2);
    kostka_z    = num_z * layer_height;

    pozice_x    = 0-pin_radius-mezera/2;
    pozice_y    = 0-pin_radius-mezera/2;
    pozice_z    = 0-layer_height/2-(num_z-1)*layer_height;

    if ( !smooth ) {
        for( i=[0:num_x-1], j=[0:num_y-1] ) {
            translate([ i*(mezera + pin_radius*2), j*(mezera + pin_radius*2), layer_height/2]) 
                difference() {
                    cylinder(   r=pin_radius, h=pin_height );
                    cylinder( r=pin_radius-1, h=pin_height+1 );
                }
        }
    }

    for( i=[1:num_x-1], j=[1:num_y-1] ) {
        translate([ pozice_x+i*pin_distance, pozice_y+j*pin_distance, pozice_z ]) 
            difference() {
                cylinder( r=stred_radius, h=kostka_z-wall_thick );
                translate([0,0,-1])
                    cylinder( r=stred_radius-1, h=kostka_z-wall_thick+1 );
            }
    }

    translate([ pozice_x, pozice_y, pozice_z ])
        difference() {
            cube([ kostka_x, kostka_y, kostka_z ]);

            translate([ wall_thick, wall_thick, 0 - wall_thick ])
                cube([ kostka_x-2*wall_thick, kostka_y-2*wall_thick, kostka_z ]);
        }


};


duplo(8,2);

