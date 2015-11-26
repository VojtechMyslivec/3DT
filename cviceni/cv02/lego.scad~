/**
 * Lego brick
 * @author Jakub Prusa
 * @documentation http://cdn.instructables.com/F65/PI3W/HDYZBK5Y/F65PI3WHDYZBK5Y.LARGE.jpg
 * @param num_x pocet pinu na ose x
 * @param num_y pocet pinu na ose y
 * @param num_z vyska na ose z ale ne v mm ale v jednotkach lega, obycejny dil ma vysky 3
 * @param smooth jestli dil ma byt hladky nebo ne (bez cudliku)
 * rozmery jednotlivych casti
 * prumer cudliku je 4.8 mm
 * vyska cudliku 1.8 mm
 * rozestup je 8 mm
 * vyska vrstvy bez cudliku je 3.2 mm
 * tlouska steny je 1.2 mm
 *
 * uvnitr kosticky nereste zadne cudliky jako v realu, staci ze bude prazdna a tlouska steny bude odpovidat parametru
 * a jak vite nektere lego dilky jsou hladke takze nemaji nahore ty cudliky. Na to je zde promena typu BOOL ktera se jmenuje smooth
 */
 
 
//#import("stls/lego_brick.stl");

module  lego_brick(
num_x=10,
num_y=2,
num_z=1,
smooth=false
) {
                      
    prumerC   = 4.8;
    vyskaC    = 1.8;
    rezestupC = 8 - prumerC;
    vyskaUnit = 3.2;
    tloustkaS = 1.2;

    xK  = num_x*(rezestupC+prumerC);
    yK  = num_y*(rezestupC+prumerC);
    zK  = vyskaUnit * num_z;
    
    xPoz    = 0-(prumerC+rezestupC)/2;
    yPoz    = 0-(prumerC+rezestupC)/2;
    zPoz    = 0-zK+vyskaUnit/2;

    if (!smooth) {
        for (i=[0:num_x-1],j=[0:num_y-1]){
            translate([
                i*(rezestupC+prumerC),
                j*(rezestupC+prumerC),
                vyskaUnit/2
            ])
                cylinder( d=prumerC, h=vyskaC );
        }
    }
    
    
    difference() {
        translate([ xPoz, yPoz, zPoz ])
            cube([ xK, yK, zK ]);
        translate([ xPoz+tloustkaS, yPoz+tloustkaS, zPoz-tloustkaS ])
            cube([ xK-2*tloustkaS, yK-2*tloustkaS, zK ]);
    }                      
                      
                      
}

//lego_brick();
lego_brick(
    num_x=1,
    num_y=1,
    num_z=3,
    smooth=false
);
