use <star_3d.scad>

module duta_hvezda(
    cipu        = 5,
    velikost    = 40,
    vyska       = 2,
    tloustka    = 5
) {
    difference() {
        star_3d( points=cipu, point_len=velikost, pnt_h=vyska, cent_h=vyska );
        translate([0,0,-vyska])
            star_3d( points=cipu, point_len=(velikost-tloustka), pnt_h=3*vyska, cent_h=3*vyska );
    }
}

module nausnice(
    cipu        = 5,
    velikost    = 40,
    vyska       = 2,
    pocet       = 4,
    tloustka    = 5,
    vypln_vyska = 1
) {
    // jednotlive hvezdy ---------------------------------------------
    rozdil = velikost/pocet;
    for ( i = [0:(pocet-1)] )
        duta_hvezda( cipu, velikost-i*rozdil, vyska, tloustka );

    // spojeni hvezd -------------------------------------------------
    difference() {
        // vypln jen v horni polovine a uvnitr hvezdy
        intersection() {
            star_3d( points=cipu, point_len=velikost, pnt_h=vyska, cent_h=vyska );
            translate([-1/2,-1,0]*velikost)
                cube([velikost,velikost,vypln_vyska]);

            for ( i=[1.5,-1.5] )
                rotate([0,0,i*360/cipu ])
                    cube( [2*velikost,vyska,2*vypln_vyska], center=true );
        }
        // a vyriznuta vnitrni hvezda
        delka_vnitrnich_cipu    = velikost - tloustka - (pocet-1)*rozdil;
        star_3d( points=cipu, point_len=delka_vnitrnich_cipu, pnt_h=vyska, cent_h=vyska );
    }
    // krouzek na zaveseni -------------------------------------------
    translate([0,-velikost,0])
    difference() {
        cylinder( r=tloustka, h=vypln_vyska );
        cylinder( d=tloustka, h=2*(vypln_vyska+vyska), center=true );
    }
}


cipu        = 5;
velikost    = 40;
vyska       = 4;
pocet       = 3;

tloustka    = 5;

vypln_vyska = 2;

nausnice( cipu, velikost, vyska, pocet, tloustka, vypln_vyska, $fn=50 );
