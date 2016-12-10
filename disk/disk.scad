d_okraj = 14;
d_stred = 6;
d_osa   = 2;
h_okraj = 9;
$fn     = 50;

// okraj
difference() {
    cylinder( d=d_okraj, h=h_okraj );
    translate([ 0,0,1 ])
        cylinder( d=d_okraj-2, h=h_okraj );
}

// vystuze
intersection() {
    cylinder( d=d_okraj, h=h_okraj );
    union() {
    translate([ 0, 0, h_okraj/4 ])
        cube([ d_okraj, 1, h_okraj/2 ], center=true );
    translate([ 0, 0, h_okraj/4 ])
        cube([ 1, d_okraj, h_okraj/2 ], center=true );
    }
}

// stred
difference() {
    cylinder( d=d_stred, h=h_okraj*1.5 );
    translate([ 0,0,h_okraj/2 + 1 ])
        cylinder( d=d_osa, h=h_okraj*1.5 );
}

