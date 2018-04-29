/**
 * Copyright 2018 Nathan Fairhurst.
 */

module mount(
  thickness, // How thick the walls should be
  clearance, // How much room should be around the screw holes/slots
  tolerance, // Room for error
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
  translate([0, d_slot_front_to_inner_bend + tolerance/2, -(slot_height - tolerance)/2])
    cube([slot_depth, front_slot_width - tolerance, slot_height - tolerance]);

  // Back slot
  translate([0, back_slot_offset + tolerance/2, -(slot_height - tolerance)/2])
    cube([slot_depth, back_slot_width - tolerance, slot_height - tolerance]);

  // Front wing (with holes)
  difference() {
    translate([-front_wing_length, -thickness, -height/2])
      cube([front_wing_length, thickness, height]);

    // Top screw hole
    translate([-screw_offset_width, thickness/2, screw_offset_height])
      rotate([90, 0, 0])
      cylinder(thickness*2, screw_radius + tolerance/2, screw_radius + tolerance/2);

    // center pin hole
    translate([-screw_offset_width, thickness/2, 0])
      rotate([90, 0, 0])
      cylinder(thickness*2, pin_radius + tolerance/2, pin_radius + tolerance/2);

    // Bottom screw hole
    translate([-screw_offset_width, thickness/2, -screw_offset_height])
      rotate([90, 0, 0])
      cylinder(thickness*2, screw_radius + tolerance/2, screw_radius + tolerance/2);
  }
}

mount(
  4, // thickness
  6, // clearance
  0.3, // tolerance
  6, // slot_depth
  9, // slot_height
  5.4, // front_slot_width
  6.4, // back_slot_width
  7, // d_slot_to_slot
  11.5, // d_slot_front_to_inner_bend
  15, // screw_offset_width
  9.8, // screw_offset_height
  2.9, // screw_radius
  2.9, // pin_radius
  $fn=30
);
