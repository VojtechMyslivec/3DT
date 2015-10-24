//cylinder(r1=40,r2=0,h=30);
//for (i=[1:10])
//    translate([20*i,0,0]) {
//        cylinder(r=5,h=25);
//        difference() {
//            sphere(20);
//            translate([0,0,-25])
//            cylinder(r=5,h=10);
//        }
//    }

a = 100;

difference() {
    intersection() {
        cube( size=4*a, center=true );
        sphere( r = 2.5*a );
    }
    union() {
            cylinder( r=a, h=5*a, center=true );
        rotate ([90,0,0])
            cylinder( r=a, h=5*a, center=true );
        rotate ([0,90,0])
            cylinder( r=a, h=5*a, center=true );
    }
}
