/** thorn
 *
 *  This module creates a single crystal thorn pointing upwards
 *
 *  height      total thorn height
 *  circumr     radius of thorn widest point
 *  seg         number of thorn segments
 *
 */
module thorn(
    height  = 15,
    circumr = 3,
    seg     = 5
) {
    // height of the upper stump is third root of total height
    stump_height    = pow( height, 1/3 );
    base_height     = height - stump_height;
    // translated upper stump
    translate( [0,0,base_height] )
        cylinder( r1=circumr, r2=0, h=stump_height, $fn=seg );
    // thorn base
    cylinder( r1=circumr/3, r2=circumr, h=base_height, $fn=seg );
}


thorn( 25, 5, 6 );
