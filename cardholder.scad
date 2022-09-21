creditCardWidth = 53.98;
creditCardHeight = 85.60;
creditCardThickness = 2.5;
creditCardRadius = 3.48;

holderExtraTop = 5;
holderExtraSides = 1;
holderCircleRadius = 1.5;
holderCircleWidth = 10;
holderCircleGap = 5;

sideArmOverhangHeight = creditCardHeight / 2;
sideArmOverhangWidth = 3;
sideArmOverhangThickness = 0.6;

gradians = 50;
pocketExtra = 1;

svgEnable = true;
svgShouldPenetrate = false;
svgScale = 1;
svgFileName = "salesforce.svg";

if (svgEnable) {
  difference() {
    cardHolder();
    translate([0, 0, -0.5]) {
      rotate([0, 180, 0]) {
        linear_extrude(center=true, height=svgShouldPenetrate ? 5 : 2) {
          scale(svgScale)
          offset(0.01)
          import(svgFileName, center=true);
        }
      }
    }
  }
} else {
  cardHolder();
}

module cardHolder() {
  difference() {
    holder();
    cardGap();
  }
}

module holderCircles() {
  width = 100;

  translate([holderCircleWidth / 2 + holderCircleGap, 0, -width/2]) {
    cylinder(width, r=holderCircleRadius, $fn=gradians);
  }
  translate([-holderCircleWidth / 2 - holderCircleGap, 0, -width/2]) {
    cylinder(width, r=holderCircleRadius, $fn=gradians);
  }
  hull() {
    translate([holderCircleWidth / 2 , 0, -width/2]) {
      cylinder(width, r=holderCircleRadius, $fn=gradians);
    }
    translate([-holderCircleWidth / 2, 0, -width/2]) {
      cylinder(width, r=holderCircleRadius, $fn=gradians);
    }
  }
}

module holder() {
  holderWidth = creditCardWidth + holderExtraSides * 2 + pocketExtra * 2;
  holderHeight = creditCardHeight + holderExtraSides + holderExtraTop + pocketExtra;

  translate([0,(holderExtraTop - holderExtraSides) / 2 ,0]) {
    difference() {
      squircle(holderWidth, holderHeight, creditCardThickness + pocketExtra + sideArmOverhangThickness, creditCardRadius);
      translate([0, (holderHeight - holderExtraTop) / 2, 0]) {
        holderCircles();
      }
    }
  }
}

module cardGap() {
  width = 100;

  difference() {
    translate([0,0,pocketExtra]) {
      squircle(creditCardWidth + pocketExtra * 2, creditCardHeight + pocketExtra, width, creditCardRadius);
    }
    sideArmOverhang();
  }
}

module sideArmOverhang() {
  width = 100;

  translate([0,0,pocketExtra + creditCardThickness]) {
    union() {
      translate([(width + creditCardWidth - sideArmOverhangWidth)/2,0,0]) {
        squircle(width, sideArmOverhangHeight, sideArmOverhangThickness, 1);
      }
      translate([-(width + creditCardWidth - sideArmOverhangWidth)/2,0,0]) {
        squircle(width, sideArmOverhangHeight, sideArmOverhangThickness, 1);
      }
    }
  }
}

module card() {
  squircle(creditCardWidth, creditCardHeight, creditCardThickness, creditCardRadius);
}

module squircle(w, h, d, r) {
  width = w - (r * 2);
  height = h - (r * 2);

  hull() {
    translate([width/2, height/2,0]) {
      cylinder(d, r=r, $fn=gradians);
    }
    translate([width/2, -height/2,0]) {
      cylinder(d, r=r, $fn=gradians);
    }
    translate([-width/2, height/2,0]) {
      cylinder(d, r=r, $fn=gradians);
    }
    translate([-width/2, -height/2,0]) {
      cylinder(d, r=r, $fn=gradians);
    }
  }
}
