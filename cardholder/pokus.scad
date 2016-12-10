//
// // dira na kartu
// module dira(
//             velikost    = [ 20, 5, 25 ],
//             spacing     = 1
//            ) {
//     // vnitrni dira je zaoblena, ale spodni strana je rovna
//     hull() {
//         for ( i=[0,1], j=[0,1] )
//             translate([ i*velikost[0], j*velikost[1], 0 ])
//                 cylinder( r=spacing, h=velikost[2] );
//     }
// }
//
// module dira1(
//             velikost    = [ 20, 5, 25 ],
//             spacing     = 1
//            ) {
//     // vnitrni dira je zaoblena, ale spodni strana je rovna
//     intersection() {
//         // zaobleni
//         minkowski() {
//             cube( velikost + [0,0,spacing] );
//             sphere( spacing );
//         }
//         // prunik s rovnou krychli
//         translate( -spacing*[1,1,0] ) {
//             cube( velikost + 2*spacing*[1,1,1] );
//         }
//     }
// }


//v=[25,10,20];
//s=10;
//#dira1(v,s);
//dira(v,s);

//a=10;
//intersection() {
//    cube(a);
//    translate([a,0,0])
//        cube(a);
//}

use <./cardholder.scad>;

cardholder();
