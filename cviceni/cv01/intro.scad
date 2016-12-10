// sphere( r=25 );

// cylinder( r1=0, r2=20, h=30 );

/*
// vice objektu najednou, translace
cube(150,center=true);
translate([150,0,0]) sphere(100);
*/

/*
// scale
// operace nejsou komutativni

rotate([45,0,0])
    scale([1,1,2])
    sphere(100);


translate([200,0,0])
    scale([1,1,2])
    rotate([45,0,0])
    sphere(100);
*/

/*
// resize
color("blue")
    //rotate([45,0,0])
    resize([12,0,0],auto=[0,1,1])
    rotate([45,0,0])
    cube( size=[100,100,50], center=true );
*/

/*
// opet nekomukatitivni
color("green") rotate([0,0,60]) translate([30,0,0]) cube(5);
color("red") translate([30,0,0]) rotate([0,0,60]) cube(5);
*/

/*
// operace plus/minus
difference() {
    union() {
      cube(150,center=true);
      sphere(100);
    }
    cylinder(r=10,h=1000, center=true);
}
*/

// cyklus
/*
a=100;
for ( i = [1:6] ) {
    translate([1.5*a*i,0,0]) sphere(a);
}
*/

/*
// modul
module sisojd(size=12,amount=6) {
    intersection_for(n = [1 : amount]) {
        rotate([0,0,n*60])
        translate([size/4,0,0]) sphere(size);
    }
}


sisojd(size=100,amount=6);
*/
