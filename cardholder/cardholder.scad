
module prihradka(
                    size        = [ 20, 5, 30 ],
                    thickeness  = 1,
                    spacing     = 1,
                    podstavec   = 0
    ) {
        // celkova velikost prihradky
        celkova_velikost = size + 2*(thickeness+spacing)*[1,1,0] + [0,0,spacing];
        // posunuti prihradky na danou uroven
        translate( [ 0, 0, podstavec ]) {
            // rozdil 2 cubes -- duta prihradka
            difference() {
                cube( celkova_velikost );
                translate( thickeness*[1,1,1] + spacing*[1,1,0] ) {
                    intersection() {
                        
                        minkowski() {
                            cube( size + [0,0,spacing] );
                            sphere( spacing );
                        }

                        translate(-spacing*[1,1,0]) {
                            cube(size+2*spacing*[1,1,1]);
                        }
                    }
                }
            }
        }
        // podstavec
        #cube( [ celkova_velikost[0], celkova_velikost[1], podstavec ] );
}

module cardholder(
                    size        = [ 85, 54, 1 ],
                    thickeness  = 3,
                    spacing     = 1,
                    cards       = 4,
                    delta       = 25,
                    visibility  = 0.3
    ) { 

    // rozmery prihradky
    vyska_urovne        = (1 - visibility) * size[0];
    rozmery_prihradky   = [ size[1], size[2], vyska_urovne ];

    celkova_velikost    = rozmery_prihradky + 2*(thickeness+spacing)*[1,1,0] + [0,0,spacing];

    // upravi celkovou pozici cardholderu
    translate([ 0-celkova_velikost[0]/2, 0-celkova_velikost[1], 0 ]) {
        // pro kazdou kartu vygeneruje prihradku vlastnim modulem
        for ( i = [0:cards-1] ) {
            translate([ 0, 0-i*celkova_velikost[1], 0 ])
                prihradka( 
                            size        = rozmery_prihradky,
                            thickeness  = thickeness,
                            podstavec   = i*delta
                         );
        }
    }
}

cardholder();
//prihradka( size=[451,100,700], thickeness=30, spacing=30, podstavec=100  );

