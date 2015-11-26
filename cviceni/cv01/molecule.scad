module molecule( ar=5, ac=4, ad=12, br=1 ) {
    for (x=[0:ac-1],y=[0:ac-1],z=[0:ac-1]) {
        translate([x*ad,y*ad,z*ad])
        sphere( r=ar );
    }
    for (j=[0:ac-1],k=[0:ac-1]) {
        translate([j*ad,k*ad,0])
        cylinder( r=br, h=(ac-1)*ad );
        
        translate([j*ad,k*ad,0])
        rotate( [0,0,-90] )
        cylinder( r=br, h=(ac-1)*ad );
    }
}

molecule();

