//#import("stls/snowman.stl");

/**
 * Snowman
 * @param r Poloměr největší koule
 * @param factor Velikost menší koule jako zlomek velikosti koule pod ní (0.7 = 70 %)
 * @param overlap Překryv menší koule s koulí pod ní jako zlomek výšky spodní koule (0.2 = 20 %)
 * @param balls Počet koulí (pro uznání nutno řešit rekurzí)
 * Jde zde pouze o "sněhové" koule, nikoliv o ozdoby na sněhulákovi
 * @author Miro Hrončok
 */
module snowman(
    r=50,
    factor=0.7,
    overlap=0.2,
    balls=3
) {
    if ( balls > 0 ) {
        sphere(r=r);

        rNovy=r*factor;

        translate([0,0,(r+rNovy)*(1-overlap)])
            snowman(
                        r       = rNovy,
                        factor  = factor,
                        overlap = overlap,
                        balls   = balls-1
                   );
    }
}

//snowman( balls=1, overlap=0.5, factor=1);
snowman( );
