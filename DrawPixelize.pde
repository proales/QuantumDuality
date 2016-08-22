void pixelizeImage() {
 
  for (int x = 0; x < numberColumns; x++) {
    for (int y = 0; y < numberRows; y++) {
      int avgColor = 0;       // Average color of the box 7x7 pixels
      int adjustedColor = 0;  // Adjusted for brigtness
      int recoloredColor = 0; // Adjusted for color rgb
      
      avgColor = avgColor(x, y);
      adjustedColor = increaseBrightness(avgColor, brightnessAdjustment);
      
      if (step4On) {
        if (monomeOverlayRight[x][y] != 0) {
          adjustedColor = increaseBrightness(adjustedColor, monomeOverlayRight[x][y]);
        }
      } 
      
      // If the first step is on then recolor color
      if (step1On) {
        recoloredColor = mergeColors(adjustedColor, colorOverlay);
      } else {
        recoloredColor = adjustedColor;
      }
      
      // Fill the 7x7 box of pixels
      fill(recoloredColor);
      rect(420 + x * pixelSize, y * pixelSize, pixelSize, pixelSize);
      
      // Save average color of the box 
      avgColors[x][y] = recoloredColor;
    }
  }
  
}

color linearToColor (int value) {
return HSBtoRGB(((float) value)/100.0*.85, (float) 1, (float) 1);
}

color HSBtoRGB(float h, float s, float v) {
  double r = 0, g = 0, b = 0, i, f, p, q, t;
  i = Math.floor(h * 6);
  f = h * 6 - i;
  p = v * (1 - s);
  q = v * (1 - f * s);
  t = v * (1 - (1 - f) * s);
  switch ((int) (i % 6)) {
       case 0: r = v; g = t; b = p; break;
       case 1: r = q; g = v; b = p; break;
       case 2: r = p; g = v; b = t; break;
       case 3: r = p; g = q; b = v; break;
       case 4: r = t; g = p; b = v; break;
       case 5: r = v; g = p; b = q; break;
   }
   return color((float) r * 255, (float) g * 255, (float) b * 255);
}

color increaseBrightness (color c, int amount) {
  float newRed = constrain(red(c) + amount, 0, 255);
  float newGreen = constrain(green(c) + amount, 0, 255);
  float newBlue = constrain(blue(c) + amount, 0, 255);
  return color(newRed, newGreen, newBlue); 
}

color mergeColors(color a, color b) {
  return blendColor(a, b, blendColorMode);
}

int avgColor(int col, int row) {
  int red = 0;
  int green = 0;
  int blue = 0;
  int currentColor;
  int totalPixels = 7 * 7;
  
  for (int x = 0; x < pixelSize; x++) {
    for (int y = 0; y < pixelSize; y++) {
      currentColor = getPixel(col * pixelSize + x, row * pixelSize + y);
      red += red(currentColor);
      green += green(currentColor);
      blue += blue(currentColor);
    }
  }
  
  return color(red/totalPixels, green/totalPixels, blue/totalPixels);
}

int getPixel (int x, int y) {
  return pixels[y*canvasWidth+x];
}