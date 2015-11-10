/**
 * vytvori pocet_x x pocet_y valcu s rozestupem rozestup
 */
module valce(
                pocet_x  = 5,
                pocet_y  = 4,
                r        = 2,
                h        = 3,
                rozestup = 5
            ) {
    if ( pocet_x > 0 && pocet_y > 0 ) 
        for( i=[0:pocet_x-1], j=[0:pocet_y-1] )
            translate([ i*rozestup, j*rozestup, 0 ])
                cylinder( r=r, h=h );
}

/**
 * vytvori pocet_x pocet_y cudliku s rozestupem rozestup
 */
module cudliky(
                pocet_x     = 10,
                pocet_y     = 5,
                r           = 3,
                h           = 1,
                rozestup    = 4
        ) {
    difference() {
        valce( pocet_x, pocet_y, r  , h  , rozestup );
        valce( pocet_x, pocet_y, r-1, h+1, rozestup );
    }
}


/**
 * vytvori kazdou druhou cube( velikost ) s rozestupem (vektor),
 * tak, aby vysly symetricky dle celkoveho poctu 
 */
module vyztuha(
                velikost    = [10,2,5],
                rozestup    = [0,2,0],
                pocet       = 10
              ) {
    for ( i=[2:2:pocet/2] ) {
            translate( (pocet-i)* rozestup )
                cube( velikost );
            translate( i*rozestup )
                cube( velikost );
        }
}

/**
 * vytvori vyztuhy v osach x i y
 */
module vyztuhy(
                pocet_x    = 10,
                pocet_y    = 5,
                kostka_x   = 100,
                kostka_y   = 55,
                tloustka   = 10,
                vyska      = 40,
                vzdalenost = 10,
              ) {
    // v ose x
    translate([ -tloustka/2, 0, 0 ])
        vyztuha(
                velikost    = [ tloustka, kostka_y, vyska ],
                rozestup    = [ vzdalenost, 0, 0 ],
                pocet       = pocet_x
               );
    // v ose y
    translate([ 0, -tloustka/2, 0 ])
        vyztuha(
                velikost    = [ kostka_x, tloustka, vyska ],
                rozestup    = [ 0, vzdalenost, 0 ],
                pocet       = pocet_y
               );
}

/**
 * vytvori pocet krat cube( velikost ) s rozestupem (vektor) a jejich 
 * 'zrcadlovou' kopii v pozice_kopie
 */
module zasek(
                velikost    = [2,1,10],
                rozestup    = [2,0,0],
                pozice_kopie= [0,10,0], 
                pocet       = 10
            ) {
    for( i=[0:pocet-1] )
        translate( i*rozestup ) {
            cube( velikost );
            translate( pozice_kopie )
                cube( velikost );
        }
}

/**
 * vytvori zaseky v osach x i y
 */
module zaseky(
                velikost    = 2,
                sirka       = 3,
                vyska       = 10,
                vzdalenost  = 3,
                pocet_x     = 9,
                pocet_y     = 6,
                kostka_x    = 50,
                kostka_y    = 35
             ) {
    // podel x
    translate([ (vzdalenost-sirka)/2, 0, 0 ]) 
        zasek(
                velikost    = [ sirka, velikost, vyska ],
                rozestup    = [ vzdalenost, 0, 0 ],
                pozice_kopie= [ 0, kostka_y-velikost, 0 ],
                pocet       = pocet_x
             );
    // podel y
    translate([ 0, (vzdalenost-sirka)/2, 0 ]) 
        zasek(
                velikost    = [ velikost, sirka, vyska ],
                rozestup    = [ 0, vzdalenost, 0 ],
                pozice_kopie= [ kostka_x-velikost, 0, 0 ],
                pocet       = pocet_y
             );

}

/**
 * modul dute kostky o tloustce steny tloustka
 */
module kostka(
                velikost    = [10,12,5],
                tloustka    = 1
             ) {
    difference() {
            cube( velikost );
        translate( tloustka*[1,1,-1] )
            cube( velikost - 2*tloustka*[1,1,0] );
    }
}

/**
 * Lego duplo brick
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
    pin_distance = 25.35 - pin_radius*2;
    wall_thick   = 2;
    zasek_thick  = 3.3;
    stred_radius = 13.15/2;
    // tloustka podlozky (num_z==0)
    podlozka_thick = wall_thick;

    kostka_x        = num_x * pin_distance;
    kostka_y        = num_y * pin_distance;
    kostka_z        = num_z * layer_height;
    kostka_velikost = [ kostka_x, kostka_y, ( kostka_z==0 ? podlozka_thick : kostka_z ) ];

    pozice_z    = 0-kostka_z;
    pozice      = [ 0, 0, pozice_z ];
    // oprava pro num_z=0

    vyztuha_tloustka    = 1.5;
    vyztuha_vyska       = (num_z-1)*layer_height;

    // cudliky -------------------------------------------------------
    if ( !smooth ) {
        translate( pin_distance/2 * [ 1, 1, 0 ] )
            cudliky(
                    pocet_x     = num_x,
                    pocet_y     = num_y,
                    r           = pin_radius,
                    h           = pin_height,
                    rozestup    = pin_distance
                );
    }
    // ---------------------------------------------------------------

    // vnitrek kostky ------------------------------------------------
    translate( pozice ) {
        // rozdil: (plne valce + vyztuhy) - vnitrni (dute) valce
         difference() {
            union() {

                // valce ---------------------------------------------
                translate( pin_distance*[1,1,0] )
                    valce(
                            pocet_x  = num_x-1,
                            pocet_y  = num_y-1,
                            r        = stred_radius,
                            h        = kostka_z - wall_thick,
                            rozestup = pin_distance 
                        );
                // ---------------------------------------------------

                // vyztuhy -------------------------------------------
                translate([ 0, 0, layer_height ])
                    vyztuhy(
                             pocet_x    = num_x,
                             pocet_y    = num_y,
                             kostka_x   = kostka_x,
                             kostka_y   = kostka_y,
                             tloustka   = vyztuha_tloustka,
                             vyska      = vyztuha_vyska,
                             vzdalenost = pin_distance
                           );
                // ---------------------------------------------------

            }

            // vyrez valcu a vyztuh zespodu --------------------------
            translate( pin_distance*[1,1,0] - [0,0,1] )
                valce(
                        pocet_x  = num_x-1,
                        pocet_y  = num_y-1,
                        r        = stred_radius-1,
                        h        = kostka_z - wall_thick + 1,
                        rozestup = pin_distance 
                    );
            // -------------------------------------------------------
        }

        // zaseky ----------------------------------------------------
        zaseky(
                velikost    = zasek_thick,
                sirka       = wall_thick,
                vyska       = kostka_z,
                vzdalenost  = pin_distance,
                pocet_x     = num_x,
                pocet_y     = num_y,
                kostka_x    = kostka_x,
                kostka_y    = kostka_y
              );

    }
    // ---------------------------------------------------------------

    // duta kostka ---------------------------------------------------
    translate([ 0, 0, ( kostka_z==0 ? 0-podlozka_thick : pozice_z ) ]) {
        kostka(
                velikost    = kostka_velikost,
                tloustka    = wall_thick
              );
    }
    // ---------------------------------------------------------------
};


//intersection() {
//translate([20,-30,-20])cube ([100,100,100]);
//
duplo( 4, 8, 2, $fn=10 );
//}

//for ( i=[1:8], j=[1:8] ) {
//    if ( i>=j )
//        translate([ (i-1)*120, (j-1)*120 ])
//            duplo( i, j );
//}

