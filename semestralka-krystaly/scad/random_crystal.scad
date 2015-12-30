// needs module thorn!
use <thorn.scad>

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


//random_crystal( nthorns=20, rot=[-45,45], seg=[3,4] );

random_crystal( );

