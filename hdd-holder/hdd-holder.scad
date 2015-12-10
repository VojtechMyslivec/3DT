module hdd_holder(
    hdd_velikost    = [ 113, 78, 19 ],
    tloustka        = 5,
    sila            = 8,
    zaves_sirka     = 39,
    zaves_delka     = 50,
    zaves_max       = 75,
    zaves_vyrez     = 0.6,
    spodni_vyrez    = 0.9,
    bocni_vyrez     = 0.9,
    podpera_sirka   = 15,
    podpera_sila    = 5
) {
    // posun spodniho vyrezu -- vycentrovani
    posunSpodek = tloustka*[1,1,0] + (1-spodni_vyrez)/2*[ hdd_velikost[0], hdd_velikost[1], 0 ];
    // posun bocniho vyrezu -- vycentrovani
    posunBok    = tloustka*[0,1,1] + (1-bocni_vyrez)/2*[ 0, hdd_velikost[1], 0 ];

    // ramecek -------------------------------------------------------
    difference() {
        // ramecek
        cube( hdd_velikost + tloustka*[2,2,1] + sila*[0,0,1] );
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
    zavesY          = zaves_max;
    //zavesY          = hdd_velikost[0];
    posunZaves      = tloustka*[0,2,1] + [0,hdd_velikost[1],hdd_velikost[2]] + [0,0,-zaves_delka] + 1/2*[hdd_velikost[0]-zavesY,0,0];
    velikostZaves   = [ zavesY+2*tloustka, zaves_sirka, zaves_delka ]; 

    posunVyrez      = (1-zaves_vyrez)/2*[velikostZaves[0],0,0];
    velikostVyrez   = zaves_vyrez*[velikostZaves[0],0,0] + [0,velikostZaves[1],velikostZaves[2]] + sila*[0,1,1];

    difference() {
        // okraj zavesu
        translate( posunZaves )
            cube( velikostZaves + sila*[0,1,1] );
        // vyriznuti zavesu
        translate( posunZaves - [1,1,1])
            cube( velikostZaves + [2,1,1] );
        // vyrez prostredku zavesu
        translate( posunZaves + posunVyrez - [0,1,1] )
            cube( velikostVyrez + [0,2,2] );
    }

    // podpera -------------------------------------------------------
    uhelPodpera     = 90 - 30;
    velikostPodpera = [podpera_sirka,podpera_sila,2*hdd_velikost[1]];

    intersection() {
        union() {
            translate([ 0, 0, podpera_sila/sin(uhelPodpera) ])
                for ( i = [0,1] ) {
                    // podpera
                    translate( i*(hdd_velikost[0]+2*tloustka-podpera_sirka)*[1,0,0] ) rotate([-180+uhelPodpera,0,0])
                        cube( velikostPodpera );
                    // podpora podpery
                    translate( (i*hdd_velikost[0]+tloustka)*[1,0,0] ) rotate([-180+uhelPodpera,0,0])
                        translate(hdd_velikost[1]*[0,-2,0])
                            cube([0.3,0,0] + hdd_velikost[1]*[0,2,2]);
                }
        }
        // maska
        translate((hdd_velikost[1]*2+hdd_velikost[2]+tloustka)*[0,0,-1])
            cube( hdd_velikost + hdd_velikost[1]*[0,0,2] + tloustka*[2,2,2] );
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

intersection() {
    *translate([-30,-5,-5])
        cube([100,100,40]);
    hdd_holder( tloustka = tloustka, hdd_velikost = [ 113, 78, 19 ] );
}

translate(tloustka*[1,1,1])
    %hdd();

