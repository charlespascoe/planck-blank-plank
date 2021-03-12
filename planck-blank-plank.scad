length=57;
height=19;
corner_radius=3;
thickness=2+3.5;
plate_thickness=1.4;
clip_radius=0.4;
clip_length=14;

corner_trim=6;

// 7.3-4.1 = 3.2 (L/R)
// 7-4.1 = 2.9 (B)
// Clip bounds: 51.9

left_offset=2.8;
bottom_offset=2.6;
space_between_clips=51.9;

module pin() {
    size=2.5;
    difference() {
        cube([size, size, size]);
        translate([0, 0, plate_thickness]) rotate([60, 0, 0]) cube([size, size, size]);
        translate([0, 0, plate_thickness]) rotate([0, -60, 0]) cube([size, size, size]);
    }
}

union() {
    difference() {
        cube([length, height, thickness]);
        translate([corner_radius, corner_radius, 0]) rotate([0, 0, 180]) difference() {
            translate([0, 0, -1]) cube([corner_radius+1, corner_radius+1, thickness+2]);
            translate([0, 0, -2]) cylinder(r=corner_radius, h=thickness+4, $fn=100);
        }
        // A small cutout for the plate bolt
        translate([length, height, thickness]) rotate([180, 0, 45]) translate([-corner_trim/2, -corner_trim/2, 0]) rotate([0, -45, 0]) translate([0, 0, -corner_trim]) cube(corner_trim);
        // A small grove to remove it using a screwdriver
        translate([(length-10)/2, height-2, thickness-2]) cube([10, 10, 10]);
    }

    translate([left_offset, bottom_offset, thickness]) pin();
    translate([left_offset, bottom_offset+clip_length, thickness]) rotate([0, 0, -90]) pin();
    translate([left_offset+space_between_clips, bottom_offset, thickness]) rotate([0, 0, 90]) pin();
    translate([left_offset+space_between_clips, bottom_offset+clip_length, thickness]) rotate([0, 0, 180]) pin();
}
