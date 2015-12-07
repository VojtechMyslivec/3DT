use <./Star.scad>;

module koruna( prumer, vyska, pomer, prekryti, uroven ) {
    color("green")
        cylinder( d1=prumer, d2=0, h=vyska, $fn=6 );
    if ( uroven > 1 )
        rotate([0,0,90])
            translate([ 0, 0, vyska*prekryti ])
                koruna( prumer*pomer, vyska*pomer, pomer, prekryti, uroven-1 );

    if ( uroven == 1 ) {
        color("yellow")
            translate([0,0,vyska*1.3]) rotate([90,0,0])
                difference() {
                    linear_extrude( height=vyska/2, center=true )
                        Star( 8, vyska, vyska/2 );
                    cylinder( d=vyska/2, h=vyska, center=true );
                }
    }
}

module stromecek(
    prumer      = 20,
    vyska       = 10,
    pomer       = 0.6,
    prekryti    = 0.8,
    uroven      = 4
) {
    koruna( prumer, vyska, pomer, prekryti, uroven );
    color("brown")
        translate([0,0,-vyska/2])
            cylinder( prumer=prumer/4, h=vyska/2 ); 

}

stromecek( $fn=50 );

