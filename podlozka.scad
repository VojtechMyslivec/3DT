module podlozka(
                prumer   = 110,
                tloustka = 5,
                dira     = 5,
                pismeno  = "J"
    ) {

    difference() {
        cylinder( d=prumer, h=tloustka );

        // diry
        pozice  = prumer/2 - dira;

        for ( i=[-1,1] ) {
            translate([ 0, i*pozice, -tloustka/2 ])
                cylinder( d=dira, h=tloustka*2 );
            translate([ i*pozice, 0, -tloustka/2 ])
                cylinder( d=dira, h=tloustka*2 );
        }

        // pismeno
        translate( [ 0, 0, tloustka*3/4 ])
            linear_extrude( height=tloustka )
                text( text=pismeno, size=prumer/2, halign="center", valign="center" );
    }

}

podlozka( $fn=100 );
