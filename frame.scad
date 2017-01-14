module frame(
    frame_r = 26,
    frame_h = 5,
    hole_r  = 14.6,
    hole_h  = 3.8,
    lug_r   = 5,
    lug_h   = 2
  ) {
    difference() {
        cylinder( r = frame_r, h = frame_h );
        translate([ 0, 0, frame_h-hole_h ])
            cylinder( r = hole_r, h = hole_h + 1 );
    }
    translate([ frame_r, 0, 0 ]) {
        difference() {
            cylinder( r = lug_r, h = lug_h );
            translate([ 0, 0, -1 ])
                cylinder( r = lug_r/2, h = lug_h + 2 );
        }
    }
}

frame($fn=50);
