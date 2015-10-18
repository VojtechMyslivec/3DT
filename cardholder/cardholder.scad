// ramecek, se zaoblenym vrskem
module blok( 
             velikost   = [ 30, 10, 35 ],
             spacing    = 1,
             delta      = 10
           ) {
    //hranaty spodek
    cube( velikost - delta*[0,0,1] );
    // zaobleny vrsek
    translate( [0,0,velikost[2]-delta] ) {
        intersection() {
            cube( [velikost[0],velikost[1],delta] );
            translate( [spacing,0,0] ) {
                minkowski() {
                    cube( [velikost[0]-2*spacing, velikost[1]-spacing, delta] );
                    sphere( spacing );
                }
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
    intersection() {
        // zaobleni
        minkowski() {
            cube( velikost + [0,0,spacing] );
            sphere( spacing );
        }
        // prunik s rovnou krychli
        translate( -spacing*[1,1,0] ) {
            cube( velikost + 2*spacing*[1,1,1] );
        }
    }
}

// prihradka na jednu kartu s podstavcem
module prihradka(
                    celkova_velikost    = [ 25, 5, 30 ],
                    vnitrni_velikost    = [ 21, 1, 29 ],
                    spacing     = 1,
                    delta       = 10,
                    uroven      = 0
                ) {
    // posun diry oproti bloku
    posun = (celkova_velikost - vnitrni_velikost + [0,0,spacing])/2;
    // celkova velikost podstavce
    podstavec = delta*uroven;

    // posunuti prihradky na danou uroven
    translate( [ 0, 0, podstavec ]) {
        // rozdil 2 -- duta prihradka
        difference() {
            blok( 
                    velikost    = celkova_velikost,
                    spacing     = spacing,
                    delta       = delta
                    );

            // dira
            translate( posun ) {
                dira(
                        velikost    = vnitrni_velikost,
                        spacing     = spacing
                    );
            }

        }
    }

    // podstavec
    cube( [ celkova_velikost[0], celkova_velikost[1], podstavec ] );
}

module cardholder(
                    size        = [ 85, 54, 1 ],
                    thickeness  = 3,
                    spacing     = 1,
                    cards       = 4,
                    delta       = 25,
                    visibility  = 0.3
                 ) { 

    // rozmery jedne prihradky
    vyska_urovne        = (1-visibility) * size[0];

    vnitrni_velikost    = [ size[1], size[2], vyska_urovne ];
    celkova_velikost    = vnitrni_velikost + 2*(thickeness+spacing)*[1,1,0] + spacing*[0,0,1];

    // rozmery masky (kvuli zaoblenym rohum) alias celkova velikost cardholderu
    maska_velikost      = celkova_velikost + (cards-1)*[ 0, celkova_velikost[1], delta ];
    maska_pozice        = [ 0, (1-cards)*celkova_velikost[1], 0 ] + spacing*[1,1,0];

    // upravi celkovou pozici cardholderu
    translate([ 0-celkova_velikost[0]/2, 0-celkova_velikost[1], 0 ]) {
        intersection() { 

            // pro kazdou kartu vygeneruje prihradku vlastnim modulem
            for ( i = [0:cards-1] ) {
                translate([ 0, 0-i*celkova_velikost[1], 0 ]) {
                    prihradka( 
                                celkova_velikost = celkova_velikost,
                                vnitrni_velikost = vnitrni_velikost,
                                spacing     = spacing,
                                delta       = delta,
                                uroven      = i
                             );
                }
            }

            // maska -- zaoblene rohy
            translate ( maska_pozice ) {
                minkowski() {
                    // velikost zmensena o 2*spacing
                    cube( maska_velikost - spacing*[2,2,0] );
                    sphere( spacing );
                }
            }

        }
    }
}

//translate([0,100,]) cardholder( );
cardholder( 
                size        = [100,50,10],
                spacing     = 10,
                cards       = 4,
                thickeness  = 10,
                visibility  = 0.3,
                delta       = 35
            );

//prihradka( celkova_velikost=[451,100,700], vnitrni_velikost=[350,10,600], spacing=30, delta=100, uroven=1  );

