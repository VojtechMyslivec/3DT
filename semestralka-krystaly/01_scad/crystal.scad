// needs module thorn!
use <thorn.scad>

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

crystal( [
            [ [   0,   0,   0 ],  41,  5, 3 ],
            [ [  45,  45,   0 ],  46,  3, 6 ],
            [ [   0,  45,  45 ],  41,  4, 4 ],
            [ [   0, -45, -45 ],  41,  4, 4 ],
            [ [   0,  90,   0 ],  47,  3, 6 ],
            [ [  90,   0,   0 ],  45,  3, 8 ]
         ] );

