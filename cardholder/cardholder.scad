/* cardholder.scad 
 *
 * Vypracovani ukolu z predmetu BI-3DT
 * Vojtech Myslivec, FIT CVUT v Praze, 2015
 *
 */


// ramecek, se zaoblenym vrskem
module blok( 
             velikost   = [ 30, 10, 35 ],
             zaobleni   = 1,
             delta      = 10
           ) {
    //hranaty spodek
    cube( velikost - delta*[0,0,1] );
    // zaobleny vrsek
    translate( [0,0,velikost[2]-delta] ) {
        intersection() {
            cube( [velikost[0],velikost[1],delta] );

            // maska -- zaoblene rohy
            pozice      = [ 0, velikost[1], 0 ] + zaobleni*[1,-1,0];
            rozestup_X  = velikost[0] - 2*zaobleni;
            rozestup_Y  = velikost[1];

            translate( pozice ) 
                hull() {
                    for ( i=[0,1], j=[0,1] )
                        translate ( [ i*rozestup_X, -j*rozestup_Y, 0 ] )
                            cylinder( r=zaobleni, h=delta );
                }
        }
    }
}

// dira na kartu
module dira(
            velikost    = [ 20, 5, 25 ],
            spacing     = 1
           ) {
    // vnitrni dira je zaoblena, ale spodni strana je rovna
    if ( spacing == 0 ) {
        cube( velikost );
    }
    else {
        hull() {
            for ( i=[0,1], j=[0,1] )
                translate([ i*velikost[0], j*velikost[1], 0 ])
                    cylinder( r=spacing, h=velikost[2] );
        }
    }
}

// prihradka na jednu kartu s podstavcem
module prihradka(
                    blok_velikost    = [ 25, 5, 30 ],
                    dira_velikost    = [ 21, 1, 29 ],
                    spacing     = 1,
                    thickness   = 1,
                    delta       = 10,
                    uroven      = 0
                ) {
    if ( blok_velikost[2] > 0 || uroven != 0 ) { 
        // posun diry oproti bloku
        stred_X = ( blok_velikost[0] - dira_velikost[0] )/2;
        stred_Y = ( blok_velikost[1] - dira_velikost[1] )/2;
        posun = [ stred_X, stred_Y, thickness ];
        // celkova velikost podstavce
        podstavec = delta*uroven;

        // posunuti prihradky na danou uroven
        // rozdil 2 -- duta prihradka
        difference() {
            blok( 
                    velikost    = blok_velikost + [0,0,podstavec],
                    zaobleni    = spacing + thickness,
                    delta       = delta
                );

            // dira
            #translate( [ 0, 0, podstavec ]) {
                translate( posun ) {
                    dira(
                            //  vyska je plus 1, aby byla dira videt v nahledu
                            velikost    = dira_velikost + [0,0,1],
                            spacing     = spacing
                        );
                }

            }
        }
    }
}

module drzak (
                    blok_velikost   = [ 25, 5, 30 ],
                    dira_velikost   = [ 21, 1, 29 ],
                    thickness       = 3,
                    spacing         = 1,
                    cards           = 4,
                    delta           = 25,
    ) {
    // celkove vnejsi zaobleni
    zaobleni    = spacing + thickness;

    // posun dalsi prihradky -- velikost - thickness
    posun_prihradky_Y = blok_velikost[1]-thickness;

    // rozmery masky (celkova velikost objektu) -- vyska a rozestupy valcu
    maska_vyska      = blok_velikost[2] + (cards-1)*delta;
    maska_rozestup_X = blok_velikost[0] - 2*zaobleni;
    maska_rozestup_Y = cards*posun_prihradky_Y + thickness - 2*zaobleni;
    maska_pozice     = zaobleni*[1,1,0] - [ 0, (cards-1)*posun_prihradky_Y, 0 ]; 

    intersection() { 
        // pro kazdou kartu vygeneruje prihradku vlastnim modulem
        for ( i = [0:cards-1] ) {
            translate([ 0, 0-i*posun_prihradky_Y, 0 ]) {
                prihradka( 
                            blok_velikost   = blok_velikost,
                            dira_velikost   = dira_velikost,
                            spacing         = spacing,
                            thickness       = thickness,
                            delta           = delta,
                            uroven          = i
                         );
            }
        }

        // maska -- zaoblene rohy
        translate ( maska_pozice ) {
            hull() {
                for ( i=[0,1], j=[0,1] )
                    translate([ i*maska_rozestup_X, j*maska_rozestup_Y, 0 ])
                        cylinder( r=zaobleni, h=maska_vyska );
            }
        }
    }
}

module karta( size = [ 20, 10, 5 ] ) {
    color( "green" ) 
            cube( [ size[1], size[2], size[0] ] );
}

module cardholder(
                    size        = [ 85, 54, 1 ],
                    thickness   = 3,
                    spacing     = 1,
                    cards       = 4,
                    delta       = 25,
                    visibility  = 0.3
        ) { 

    // TODO kontrola, ze size je vektor alespon 2 hodnot. 
    if ( size[0] > 0 && size[1] > 0 && size[2] >= 0 && cards > 0 ) {

        // oprava otoceni dle zadani
        rotate([0,0,180])
            // hnusny if, kvuli zadani
            if ( delta < 0 ) {
                // diky oprave otoceni se objekt otoci, kdyz je znovu zavolan
                //rotate([0,0,180])
                //translate(-[0,0,thickness + spacing + (1-cards)*delta])
                cardholder( size, thickness, spacing, cards, -delta, visibility );
            }
            else {
                // okrajove hodnoty
                spacing         =   spacing > 0 ?   spacing: 0;
                thickness       = thickness > 0 ? thickness: 0;
                viditelnost_max =      ( visibility > 1 ) ? 1 :      visibility;
                viditelnost     = ( viditelnost_max < 0 ) ? 0 : viditelnost_max;

                // celkove vnejsi zaobleni
                zaobleni    = spacing + thickness;

                // rozmery jedne prihradky
                dira_velikost   = [ size[1], size[2], (1-viditelnost) * size[0] + spacing ];
                blok_velikost   = dira_velikost + 2*zaobleni*[1,1,0] + [0,0,thickness];

                // oprava pozice dle zadani
                oprava_pozice_X = -1/2*blok_velikost[0];
                // pro liche je y jeste posunuta
                oprava_pozice_Y = (blok_velikost[1]-thickness)*(cards-2)/2 - thickness + ( (cards % 2) ? thickness/2 : 0 );
                oprava_pozice   = [ oprava_pozice_X, oprava_pozice_Y, 0 ];

                translate( oprava_pozice ) {
                    // demo karta
                    %translate( zaobleni*[1,1,1] )
                        karta( size=size );

                    drzak(
                            blok_velikost   = blok_velikost,
                            dira_velikost   = dira_velikost,
                            thickness       = thickness,
                            spacing         = spacing,
                            cards           = cards,
                            delta           = delta
                         );
                }
            }
    }
}

//translate([0,100,0]) cardholder( );
cardholder( 
            size        = [30,20,10],//[80,40,5],
            spacing     = 2,
            cards       = 5,
            thickness   = 5,
            visibility  = 0.5,
            delta       = -15
          );

//prihradka( celkova_velikost=[451,100,700], vnitrni_velikost=[350,10,600], spacing=30, delta=100, uroven=1  );


