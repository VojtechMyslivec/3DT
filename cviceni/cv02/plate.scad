/**
 * Plate
 * Obdélníková podložka pod elektroniku na 4 rohové šroubky
 * @param x Šířka podložky
 * @param y Délka podložky
 * @param z Výška/tloušťka posložky
 * @param c Vzdálenost osy šroubu od rohu (všude stejná)
 * @param r Poloměr díry na šroub
 * @param b Poloměr sloupku na šroub
 * @param h Výška sloupku na šroub
 * @author Miro Hrončok, Jakub Průša
 */
 
  
//#import("stls/plate.stl");

module plate(
    x=70,
    y=90,
    z=2,
    c=5,
    r=1.5,
    b=2.5,
    h=3
) {

    difference() {        

        union() {
            translate([ -x/2, -y/2, 0 ])
                cube([ x, y, z ]);

            for ( i=[1,-1], j=[1,-1] ) {
                translate([i*(x/2-c),j*(y/2-c),z])
                    cylinder( r=b, h=h );    
            }
        }
    
    for ( i=[1,-1], j=[1,-1] ) {
            translate([i*(x/2-c),j*(y/2-c),-z])
                #cylinder( r=r, h=2*h+2*z );
    }
}

}


//plate();

plate(
    x=100,
    y=40,
    z=5,
    c=10,
    r=4,
    b=5,
    h=30
);
