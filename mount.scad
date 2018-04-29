/**
 * Copyright 2018 Nathan Fairhurst.
 */

module mount(
  thickness, // How thick the walls should be
  clearance, // How much room should be around the screw holes/slots
  slot_depth, // How deep the slots should protrude
  slot_height, // Height of the slots (distance oriented from bottom to top of the car)
  front_slot_width, // Width of the slot closest to the driver (distance oriented from front to back of the car)
  back_slot_width, // Width of the slot furthest to the driver (distance oriented from front to back of the car)
  d_slot_to_slot, // space between the two slots measured from their closest edges
  d_slot_front_to_inner_bend, // the front most point of the forward slot, to the inside wall of the front wing
  screw_offset_width, // Distance from the furthest stereo-side point of the front wing to the center point of the screws
  screw_offset_height, // Distance from the pin center to the screw center
  screw_radius, // radius of the screw hole
  pin_radius, // radius of the pin hole
) {
  height =
    2 * (screw_radius + screw_offset_height + clearance);

  back_slot_offset =
    d_slot_front_to_inner_bend + front_slot_width + d_slot_to_slot;

  back_wing_length =
    back_slot_offset + back_slot_width + clearance;

  front_wing_length =
    screw_offset_width + max(screw_radius, pin_radius) + clearance;

  // Back wing
  translate([-thickness, 0, -height/2])
    cube([thickness, back_wing_length, height]);

  // Front slot
  translate([0, d_slot_front_to_inner_bend, -slot_height/2])
    cube([slot_depth, front_slot_width, slot_height]);

  // Back slot
  translate([0, back_slot_offset, -slot_height/2])
    cube([slot_depth, back_slot_width, slot_height]);

  // Front wing (with holes)
  difference() {
    translate([-front_wing_length, -thickness, -height/2])
      cube([front_wing_length, thickness, height]);

    // Top screw hole
    translate([-screw_offset_width, thickness/2, screw_offset_height])
      rotate([90, 0, 0])
      cylinder(thickness*2, screw_radius, screw_radius);

    // center pin hole
    translate([-screw_offset_width, thickness/2, 0])
      rotate([90, 0, 0])
      cylinder(thickness*2, pin_radius, pin_radius);

    // Bottom screw hole
    translate([-screw_offset_width, thickness/2, -screw_offset_height])
      rotate([90, 0, 0])
      cylinder(thickness*2, screw_radius, screw_radius);
  }
}

mount(
  4, // thickness
  6, // clearance
  6, // slot_depth
  15, // slot_height
  8, // front_slot_width
  12, // back_slot_width
  10, // d_slot_to_slot
  20, // d_slot_front_to_inner_bend
  20, // screw_offset_width
  10, // screw_offset_height
  2.5, // screw_radius
  1.5 // pin_radius
);
