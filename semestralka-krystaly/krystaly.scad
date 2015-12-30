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

/** crystal
 * 
 * This module creates a crystal made of thorns (from module thorn) according
 * to given parameters. Each thorn is rotated as well.
 *
 * thorns = [[[rotx, roty, rotz], height, circumr, seg], ...]
 *      [rotx, roty, rotz]      rotate vector
 *      height, circumr, seg    thorn parameters
 * 
 * thorns_example  = [[[0,0,0], 30, 3, 4], [[90,0,0], 25.5, 2.65, 7]];
 *
 */
module crystal( thorns=[] ) {
    for( t = thorns ) {
        rotate( t[0] )
            thorn( height=t[1], circumr=t[2], seg=t[3] );
    }
}

/** random_crystal
 *
 * This module creates a crystal made of random thorns with paramteres within
 * given ranges.
 *
 * nthorns      total number of crystal thorns
 * rot          range of random rotation
 * height       range of random height  (thorn parameter)
 * circumr      range of random circumr (thorn parameter)
 * seg          range of random seg     (thorn parameter)
 *
 */
module random_crystal(
    nthorns = 350,
    rot     = [ -90, 100 ],
    height  = [  20,  40 ],
    circumr = [   2,   4.5 ],
    seg     = [   3,  10 ]
) {
//    thorns = [];

    // generation of random parameters
    // each of the vaiable is a vector of nthorns random numbers
    rand_rotx       = rands(     rot[0],     rot[1], nthorns );
    rand_roty       = rands(     rot[0],     rot[1], nthorns );
    rand_rotz       = rands(     rot[0],     rot[1], nthorns );
    rand_height     = rands(  height[0],  height[1], nthorns );
    rand_circumr    = rands( circumr[0], circumr[1], nthorns );
    rand_seg        = rands(     seg[0],   seg[1]+1, nthorns );

    // makes a rotated thorn for each of the generated parameter
    for ( i = [0:nthorns-1] ) {
//        rot_i       = [ rand_rotx[i], rand_roty[i], rand_rotz[i] ];
//        height_i    = rand_height[i];
//        circumr_i   = rand_circumr[i];
//        seg_i       = rand_seg[i];
//        thorns[i]   = [ rot_i, height_i, circumr_i, seg_i ];
//
        rotate( [ rand_rotx[i], rand_roty[i], rand_rotz[i] ] )
            thorn( height=rand_height[i], circumr=rand_circumr[i], seg=rand_seg[i] );
    }
//    echo( thorns );

}

//thorn( 25, 5, 6 );

//crystal( [
//            [ [   0,   0,   0 ],  41,  5, 3 ],
//            [ [  45,  45,   0 ],  46,  3, 6 ],
//            [ [   0,  45,  45 ],  41,  4, 4 ],
//            [ [   0, -45, -45 ],  41,  4, 4 ],
//            [ [   0,  90,   0 ],  47,  3, 6 ],
//            [ [  90,   0,   0 ],  45,  3, 8 ]
//         ] );

//random_crystal( nthorns=20, rot=[-45,45], seg=[3,4] );

random_crystal( );

