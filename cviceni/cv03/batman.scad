//#import("stls/batman.stl");

/**
 * Batman
 * Vykrajovatku ve tvaru batmana
 * @param x celkova delka objektu
 * @param y celkova sirka objektu
 * @param z celkova vyska objektu
 * @param thick tloustka steny
 * @author Jakub Průša, Miro Hroncok
 */
module batman(
                x=100,
                y=60,
                z=15,
                thick=2
) {
    resize( [x,y] )
        linear_extrude( height=z )
            difference() {
                offset( thick/2 )
                    import("stls/batman.dxf");
                import("stls/batman.dxf");
            }
}


//batman(150,50,120,10);
batman();


