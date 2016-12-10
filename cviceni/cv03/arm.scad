//#import("stls/arm.stl");

/**
 * Arm
 * rameno napriklad na RC auticko
 * @param h vyska ramena
 * @param offset vyosetni horni a spodni casti
 * @param thick tloustka ramena
 * @param number_holes pocet der nahore a dole
 * @param hole_radius polomer der v ramenu
 * mezera mezi diramy je jejich radius, to stejne od kraje
 * vyska je brana ze stredu der ke stredu der
 * off set je pocita opet ze stredu der
 * @author Jakub Průša
 */
module arm(
            height       = 60,
            offset       = -25,
            thick        = 3,
            number_holes = 2,
            hole_radius  = 3
) {
    difference() {
        hull() {
            for ( i=[-1,1], j=[-1,1] ) {
                    translate([ i*offset/2 + j*(1.5*hole_radius), i*height/2, 0 ])
                        cylinder( r=2*hole_radius, h=thick  );
            }
        }

        #translate([0,0,-thick/2])
            for ( i=[-1,1], j=[-1,1] ) {
                translate([ i*offset/2 + j*(1.5*hole_radius), i*height/2, 0 ])
                    cylinder( r=hole_radius, h=2*thick );
            }
    }
}

arm();
