
void draw() {
  // Setup canvas
  background(0);
  fill(255);
  
  // Add controller status text
  text("Volume:", textStartX, 11);
  text("  Min: " + volumeMin, textStartX, 21);
  text("  Max: " + volumeMax, textStartX, 31);
  text("  Now: " + brightnessAdjustment, textStartX, 41);
  text("Note:", textStartX, 52);
  text("  Min: " + noteMin, textStartX, 62);
  text("  Max: " + noteMax, textStartX, 72);
  text("  Now: " + note, textStartX, 82);
  text("Wind: ", textStartX, 93);
  text("  Up:     " + windUp, textStartX, 103);
  text("  Down: " + windDown, textStartX, 113);
  text("Step: ", textStartX, 124);
  text("  1: " + step1On, textStartX, 134);
  text("  2: " + step2On, textStartX, 144);
  text("  3: " + step3On, textStartX, 154);
  text("  4: " + step4On, textStartX, 164);
  text("  5: " + step5On, textStartX, 174);
  text("  6: " + step6On, textStartX, 184);
  text("Time: ", textStartX, 195);
  text("  Now: " + stepTime, textStartX, 205);
  if (testObserver.hasStrips) {
    text("PixelPusher: ", textStartX, 165);
    text("  Strips:" + registry.getStrips().size(), textStartX, 175);
    text("  Power:" + registry.getTotalPower(), textStartX, 185);
    text("  Limit:" + registry.getTotalPowerLimit(), textStartX, 195);
  }

  // Get screenshot
  try{
    Robot robot_Screenshot = new Robot();                        // 50 for Header, 300x300 just arbitrary box
    screenshot = new PImage(robot_Screenshot.createScreenCapture(new Rectangle(0, canvasHeight+50, 300, 300)));
  }
  catch (AWTException e){ }
  
  // Copy screenshot to canvas
  image(screenshot, 0, 0, pixelColumns, pixelRows);
  
  if (step4On) {
    noFill();
    stroke(colorOverlay);
    strokeWeight(30);
    for(int x = 0; x < monomeOverlayLeftPoints.size(); x++) {
      Point3d point = monomeOverlayLeftPoints.get(x);
      if (step5On) {
        ellipse((float) (point.getX() * 70), (float) (point.getY() * 70), (float) (point.getStep() * 100), (float) (point.getStep() * 100));
      } else {
        rectMode(RADIUS);
        rect((float) (point.getX() * 70), (float) (point.getY() * 70), (float) (point.getStep() * 100), (float) (point.getStep() * 100));
        rectMode(CORNER);
      }
    }
    noStroke();
  }
  
  // Load the canvas pixel buffer
  loadPixels();
  
  // Iterate through to average pixels and apply adjustments
  pixelizeImage();
  
  // Fill out the LEDs
  drawPixelPusher();

  // Draw box on canvas for current played color on Theramin
  fill(colorSelected);
  rect(840, 0, 100, 210);
  
  // Draw box on canvas for current locked color on Theramin
  fill(colorOverlay);
  rect(840, 210, 100, 210);
  
  // Wind up or down the theramin brightness (volume) adjustment
  windTheramin();
  
  // Update and draw on the Monome
  monomeDraw(); 
} 