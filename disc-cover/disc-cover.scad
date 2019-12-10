module disc_cover(width=65, height=30, thickness=8) {
    difference() {
        cylinder(d=width, h=height);
        translate([0,0,-1])
            cylinder(d=width-2*thickness, h=height-thickness+1);
    };
}

disc_cover($fn=64);
