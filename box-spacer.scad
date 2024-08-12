// Author: Rob Rakaric
// Model Description: Parametric spacer for offsetting electrical devices from electrical boxes
// Units: mm

// Parameters
numberOfGangs = 3; // Number of gangs (devices) in box
spacerThickness = 3.2; // Thickness of spacer

difference(){

    // Parameters configured for standard US electrical device boxes
    // Do not change unless you know what you are doing

    endLengths = 15; // Length of end pieces
    distanceBetweenGangs = 46; // Distance between gangs (devices) in box
    spacerWidth = 10; // Width of spacer
    holeDiameter = 5; // Diameter of holes

    union() {
    
        // Start piece
        cube([endLengths, spacerWidth, spacerThickness]);
        
        // Pieces for each gang in box (when box is 2-gang or more)
        for (i = [1:1:numberOfGangs]) {
  
            if (i > 1) {

                translate([(i - 2) * distanceBetweenGangs + endLengths, 0, 0])
                    cube([distanceBetweenGangs, spacerWidth, spacerThickness]);
            };
        };
        
        // End piece
        
        translate([(distanceBetweenGangs * (numberOfGangs - 1)) + endLengths, 0, 0])
          cube([endLengths, spacerWidth, spacerThickness]);
        
    };

    for (i = [1:1:numberOfGangs]) {

      if (i == 1) {
        translate([endLengths, spacerWidth / 2, 0])
          linear_extrude(spacerThickness)
            circle(d = holeDiameter); 
      };

      translate([(i - 1) * distanceBetweenGangs + endLengths, spacerWidth / 2, 0])
        linear_extrude(spacerThickness)
          circle(d = holeDiameter);   
    };
};