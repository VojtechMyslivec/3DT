
module jmenovka( text="Jméno", frame=true ) {
    pismo    = 8;
    x   = 60;
    y   = 2.5*pismo;
    z   = 2;

    ramecek = 1/10;

    velikost = [x,y,z];

    translate( -velikost/2 - [0,0,z/2]) {
        difference() {
        cube( velikost );

            if ( frame ) {
                translate( [ ramecek*x/2, y-z-ramecek*y, z/2 ] )
                    cube( [(1-ramecek)*x,z,z] );

                translate( [ ramecek*x/2, ramecek*y, z/2 ] )
                    cube( [(1-ramecek)*x,z,z] );

                translate( [ ramecek*x/2, ramecek*y, z/2 ] )
                    cube( [z,(1-2*ramecek)*y,z] );

                translate( [ x-z-ramecek*x/2, ramecek*y, z/2 ] )
                    cube( [z,(1-2*ramecek)*y,z] );
            }
        }
    }

    color("black")
        translate([0,0,0])
        linear_extrude( height=z/2 )
            text( text=text, size=pismo, halign="center", valign="center", spacing=1 );
}

scale(2)
//translate([-50,0,0])
    jmenovka("Myslivec");
//translate([50,0,0])
//    jmenovka( text="Kodýtek" );

