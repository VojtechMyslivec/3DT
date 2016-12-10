module hdd_holder(
    hdd_velikost    = [ 113, 78, 19 ],
    tloustka        = 5,
    sila            = 7,
    zaves_sirka     = 39,
    zaves_delka     = 37,
    zaves_max       = 70,
    zaves_vyrez     = 0.6,
    spodni_vyrez    = 0.9,
    bocni_vyrez     = 0.9,
) {
    // posun spodniho vyrezu -- vycentrovani
    posunSpodek = tloustka*[1,1,0] + (1-spodni_vyrez)/2*[ hdd_velikost[0], hdd_velikost[1], 0 ];
    // posun bocniho vyrezu -- vycentrovani
    posunBok    = tloustka*[0,1,1] + (1-bocni_vyrez)/2*[ 0, hdd_velikost[1], 0 ];

    ramecekVelikost = hdd_velikost + tloustka*[2,2,1] + sila*[0,0,1];
    // ramecek -------------------------------------------------------
    difference() {
        // ramecek
        cube( ramecekVelikost );
        // dira na hdd
        translate( tloustka*[1,1,1] )
            cube( hdd_velikost + [0,0,tloustka+sila+1]);
        // spodni vyrez
        translate( posunSpodek - [0,0,1] )
            cube( spodni_vyrez*hdd_velikost + tloustka*[0,0,2] );
        // bocni vyrez
        translate( posunBok - [1,0,0] )
            cube( bocni_vyrez*hdd_velikost + tloustka*[2,0,0]);
    }

    // zaves ---------------------------------------------------------
    velikostZaves   = [ zaves_max, zaves_sirka+sila, ramecekVelikost[2] ];
    posunZaves      = (ramecekVelikost[0]-zaves_max)/2*[1,0,0] + ramecekVelikost[1]*[0,1,0];

    velikostVyrez   = [ zaves_vyrez*velikostZaves[0], velikostZaves[1], velikostZaves[2] ];
    posunVyrez      = (1-zaves_vyrez)*velikostZaves[0]/2*[1,0,0];

    translate( posunZaves )
        difference() {
            // okraj zavesu
            cube( velikostZaves );
            // vyriznuti zavesu
            translate( -[1,1,1] )
                cube( velikostZaves - sila*[0,1,1] + [2,1,1] );
            // vyrez prostredku zavesu
            translate( posunVyrez - [0,1,1] )
                cube( velikostVyrez + [0,2,2] );
        }
}

module hdd(
    hdd_velikost    = [ 112, 77.5, 19 ],
    zaobleni        = 8
) {
    rozestup_x = hdd_velikost[0] - 2*zaobleni;
    rozestup_y = hdd_velikost[1] - 2*zaobleni;

    translate([zaobleni,zaobleni,0])
        hull() {
            for ( i=[0,1], j=[0,1] )
                translate([ i*rozestup_x, j*rozestup_y, 0 ])
                    cylinder( r=zaobleni, h=hdd_velikost[2] );
        }
}

tloustka    = 5;

hdd_holder( tloustka = tloustka, hdd_velikost = [ 114, 79, 19 ], zaves_sirka = 39.5 );

translate(tloustka*[1,1,1])
    %hdd();
