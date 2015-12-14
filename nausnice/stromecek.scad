use <./star_3d.scad>;

module koruna( prumer, vyska, pomer, prekryti, uroven ) {
    color("green")
        cylinder( d1=prumer, d2=0, h=vyska, $fn=6 );
    if ( uroven > 1 )
        rotate([0,0,90])
            translate([ 0, 0, vyska*prekryti ])
                koruna( prumer*pomer, vyska*pomer, pomer, prekryti, uroven-1 );
}

module hvezda( a = 10, n = 8 ) {
    difference() {
        translate([0,0,-a/4])
            star_3d( points=n, point_len=a, pnt_h = a/2, cent_h = a/2 );
        cylinder( d=a/2, h=a, center=true );
    }
}

module stromecek(
    prumer      = 20,
    vyska       = 10,
    pomer       = 0.6,
    prekryti    = 0.8,
    uroven      = 4,
    hvezda      = true,
    ostatni     = true,
) {
    if (ostatni) {
        // strom -------------------------------------------
        koruna( prumer, vyska, pomer, prekryti, uroven );

        // kmen --------------------------------------------
        color("brown")
            translate([0,0,-vyska/2])
            cylinder( prumer=prumer/4, h=vyska/2 ); 
    }
    // hvezda ----------------------------------------------
    if ( hvezda ) {
        velikost    = vyska*pow(pomer,uroven-1);
        koeficient  = pomer*prekryti;
        soucet      = vyska*(1-pow(koeficient,uroven))/(1-koeficient);
        color("yellow")
            translate( [0,0,1]*soucet + [0,0,1]*vyska*pow(pomer*prekryti,uroven) )
                rotate([90,0,0])
                    hvezda( velikost );
    }
}

stromecek( prumer=30, vyska=20, $fn=50, uroven=4, hvezda=true, ostatni=true );

