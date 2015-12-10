
module zub( delka, sirka, vyska, uhel ) {
    translate([delka/2,0,0])
        rotate([ 0, -uhel, 0 ]) {
            cube( [ delka, sirka, vyska ], center=true );
            translate([delka/2,0,0])
                cylinder( d=sirka, h=vyska, center=true );
        }

}


module gear(
    r1          = 50,
    r2          = 40,
    h           = 10,
    pocet_zubu  = 20,
    sirka_zubu  = 5,
    delka_zubu  = 10,
    vyska_zubu  = 8,
    hridel      = 10
) {
    rozdilR = r1-r2;
    zub     = (r1+r2)/2 + delka_zubu - sirka_zubu/2;
    uhel    = 90-atan( h/rozdilR );
    pseudoVyska = 4*(sqrt( rozdilR*rozdilR + h*h ) + cos(uhel)*delka_zubu);

    difference() {
        union() {
            cylinder( r1=r1, r2=r2, h=h, center=true );

            intersection() {
                for( i=[0:pocet_zubu-1] ) {
                    rotate ([0,0,i*360/pocet_zubu])
                        zub( zub, sirka_zubu, pseudoVyska, uhel );
                }
                // maska
                cylinder( r=r1+r2, h=vyska_zubu, center=true );
            }

        }

        cylinder( d = hridel, h =  h*2, center=true );
    }
}

gear(
    r1 = 16.5/2, r2 = 15.2/2, h = 12.8, 
    hridel = 6,
    pocet_zubu = 12, delka_zubu = 3.55, sirka_zubu = 2.5, vyska_zubu = 12.5,
    $fn=100
);

//gear();

