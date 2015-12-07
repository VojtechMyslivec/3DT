module panev(
    prumer1     = 15,
    prumer2     = 20,
    vyska       = 5,
    tloustka    = 1,

    prumer      = 2,
    delka       = 15

) {
    
    pozice_zaobleni = [ delka+prumer2/2, 0, 0 ];

    difference() {
        union() {
            // panev
            cylinder( d1=prumer1, d2=prumer2, h=vyska );
            // drzadlo
            translate([ 0, 0, vyska - prumer/2 ])
                difference() {
                    union() {
                        rotate([ 0, 90, 0 ])
                            cylinder( d=prumer, h=delka+prumer2/2 );
                        // zaobleny konec
                        translate( pozice_zaobleni )
                            cylinder( r=prumer, h=prumer, center=true );
                    }
                    // provrtani
                    translate( pozice_zaobleni )
                        cylinder( r=prumer-tloustka, h=2*prumer, center=true );
                }
        }
        // vnitrek panve
        translate([ 0, 0, tloustka ])
            cylinder( d1=prumer1-tloustka, d2=prumer2-tloustka, h=vyska );
    }
   

}

panev( $fn=50 );


