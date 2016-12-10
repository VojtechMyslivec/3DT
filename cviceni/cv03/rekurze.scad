module rec(
    cr=5,
    ch=50,
    bc=3,
    angle=30,
    level=3
) {
    cylinder(r=cr, h=ch);
    if ( level > 0 ) {
        translate([0,0,ch]) {
            sphere(r=cr);

            for ( i=[1:bc] ) {
                rotate([0,0,(360/bc)*i])
                    rotate([angle,0,0])
                        rec(cr=cr,ch=ch,bc=3,angle=angle,level=level-1);
            }
        }
    }
}

rec(bc=7,level=5,angle=20);
