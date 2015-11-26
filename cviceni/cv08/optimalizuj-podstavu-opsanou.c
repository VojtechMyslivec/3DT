#include <stdlib.h>
#include <admesh/stl.h>

#define USAGE "USAGE\n\
    optimalizuj-podstavu-opsanou stl-orig stl-new\n\
\n\
        stl     jmeno stl souboru, ktery optimalizovat\n\
        stl-new jmeno souboru do ktereho zapsat optimalizovany\n\
                vysledek (otoceni)\n\
\n\
    optimalizuje podstavu opsanou daneho stl v ramci otaceni\n\
    s krokem 5°\n"

// otoci o uhel a vrati plochu meshe
double otocASpoctiPlochu( stl_file stl_in, float uhel ) {
    double plocha;

    stl_rotate_z( &stl_in, uhel );
    stl_exit_on_error( &stl_in );

    plocha = (double)stl_in.stats.size.x * stl_in.stats.size.y;
    stl_exit_on_error( &stl_in );

    return plocha;
}

int main( int argc, char * argv[] ) {
    stl_file stl_in;
    char * infile;
    char * outfile;
    double plocha, min = 0;
    float  uhel, ideal, krok;

    if ( argc != 3 ) {
        fprintf( stderr, USAGE );
        return 1;
    }
    infile  = argv[1];
    outfile = argv[2];

    fprintf( stderr, "Oteviram %s\n", infile );
    stl_open( &stl_in, infile );
    stl_exit_on_error( &stl_in );

    // nulty 0
    min = otocASpoctiPlochu( stl_in, 0 );
    ideal = 0;

    // o kolik stupnu otacet v kazdem kroku
    krok = 5;
    for ( uhel = 5 ; uhel < 90 ; uhel += krok ) {
        fprintf( stderr, "Zkousim uhel %d\n", (int)uhel );
        // vzdy otoci jen o krok, protoze zmena je trvala
        plocha = otocASpoctiPlochu( stl_in, krok );

        if ( plocha < min ) {
            fprintf( stderr, "Nova nejmensi plocha %f\n", plocha );
            min   = plocha;
            ideal = uhel;
            stl_write_binary( &stl_in, outfile, "ADMesh");
            stl_exit_on_error( &stl_in );
        }

    }

    printf ( "Nejlepsi plocha je %f s uhlem %d\n", min, (int)ideal );

    stl_close( &stl_in );
    return 0;
}

