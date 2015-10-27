
module jmenovka( text="Jméno", frame=true ) {
    x   = 48;
    y   = 16;
    z   =  2;

    velikost = [x,y,z];

    translate( -velikost/2 - [0,0,z/2]) {
        cube( velikost );

        if ( frame ) {
            for ( i = [0,1] )
                translate( i*[x-2,0,0] )
                    cube( [z,y,2*z] );

            for ( i = [0,1] )
                translate( i*[0,y,0] )
                    cube( [x,z,2*z] );
        }
    }

    translate([0,0,0.5])
        color("black")
            text( text=text, size=8, halign="center", valign="center", spacing=1 );
}

jmenovka("Myslivec");

