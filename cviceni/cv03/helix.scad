//#import("stls/helix.stl");

/**
 * Helix
 * @param d Vzdálenost středů šroubovic měřená na vodorovné rovině
 * @param o Poloměr šroubovice měřený na vodorovné rovině
 * @param h Výška šroubovice bez podstav
 * @param s Stupně rotace na milimetr výšky (znaménko určuje směr otáčení)
 * @param db Průměr podstav
 * @param hb Výška podstav
 * Model byl vyexportován s nastavením $fn=50 a výškové rozlišení je 50 µm
 * @author Miro Hrončok
 */
module helix(
                d=10,
                o=1,
                h=50,
                s=18,
                db=13,
                hb=1
            ) {

    //sroubovice
    $fn         = 50;
    stupnu      = h*s;
    pocetSlicu  = h*20;

    translate([0,0,hb])
        linear_extrude( height=h, twist=stupnu, slices=pocetSlicu ) {
            for ( i=[-1,1] )
                translate([ i*d/2, 0, 0 ])
                    circle(r=o);
        }


    //podstavy
    for( i=[0,1] )
        translate([ 0, 0, i*(h+hb) ])
            cylinder( d=db, h=hb );
}

//helix( h=10, s=10  );
helix( );
