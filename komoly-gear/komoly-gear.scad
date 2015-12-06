module gear(
    r1          = 50,
    r2          = 40,
    h           = 10,
    pocet_zubu  = 20,
    sirka_zubu  = 5,
    delka_zubu  = 10,
    hridel      = 10,
    oriznuty    = true
)  {
    zub = r1 + delka_zubu;

    intersection() {
        difference() {
            union() {
                cylinder( r1=r1, r2=r2, h=h, center=true );

                for( i=[0:pocet_zubu-1] ) {
                    rotate([ 0, 0, i*360/pocet_zubu ])
                        translate([zub/2, 0, 0 ])
                            cube( [ zub, sirka_zubu, h ], center=true );
                }
            }

            cube( [ hridel, hridel, h*2 ], center=true );
        }
        if ( oriznuty ) 
            cylinder( r1=r1+delka_zubu, r2=r2+delka_zubu, h=h, center=true );
    }
}

//gear( r1 = 100, r2 = 50, h = 100, delka_zubu = 5, pocet_zubu = 10 );
gear( r1 = 50, r2 = 30, h = 30  );

