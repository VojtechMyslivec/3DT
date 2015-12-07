/*
 * downloaded from: https://gist.github.com/anoved/9622826
 * 
 * author: Jim (anoved)
 */

// points = number of points (minimum 3)
// outer  = radius to outer points
// inner  = radius to inner points
module Star(points, outer, inner) {
    
    // polar to cartesian: radius/angle to x/y
    function x(r, a) = r * cos(a);
    function y(r, a) = r * sin(a);
    
    // angular width of each pie slice of the star
    increment = 360/points;
    
    union() {
        for (p = [0 : points-1]) {
            
            // outer is outer point p
            // inner is inner point following p
            // next is next outer point following p

            assign( x_outer = x(outer, increment * p),
                    y_outer = y(outer, increment * p),
                    x_inner = x(inner, (increment * p) + (increment/2)),
                    y_inner = y(inner, (increment * p) + (increment/2)),
                    x_next  = x(outer, increment * (p+1)),
                    y_next  = y(outer, increment * (p+1))) {
                polygon(points = [[x_outer, y_outer], [x_inner, y_inner], [x_next, y_next], [0, 0]], paths  = [[0, 1, 2, 3]]);
            }
        }
    }
}


difference() {
    linear_extrude(height=2, center=true)
        Star(8,20,10);
    cylinder(d=10,h=4,center=true);
}

