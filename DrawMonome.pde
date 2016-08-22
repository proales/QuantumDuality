public void monomeDraw(){
  if (timer == stepTime) {
    if (play_position == 5) {
      play_position = 0;
      hightlightOn = !hightlightOn;
    } else { 
      play_position++;
    }
    
    // Diminish Right drawing boxes
    for (int x = 0; x < 60; x++) {
      for (int y = 0; y < 60; y++) {
        if (monomeOverlayRight[x][y] > 0) {
          monomeOverlayRight[x][y] -= 10;
        } else if (monomeOverlayRight[x][y] < 0) {
          monomeOverlayRight[x][y] +=10;
        }
      }
    }
    // Diminish Right monome pad
    for (int x = 0; x < 6; x++) {
      for (int y = 0; y < 6; y++) {
        if (step[x][y] > 5) {
          step[x][y]--;
        } else if (step[x][y] < 5) {
          step[x][y]++;
        }
      }
    }
    // Diminish left monome pad
    for (int x = 7; x < 13; x++) {
      for (int y = 0; y < 6; y++) {
        if (step[y][x] > 5) {
          step[y][x]--;
        } else if (step[y][x] < 5) {
          step[y][x]++;
        }
      }
    }
    // Diminish left monome pad points
    for(int x = 0; x < monomeOverlayLeftPoints.size(); x++) {
      Point3d point = monomeOverlayLeftPoints.get(x);
      point.step++;
      if (point.step > 7) {
        monomeOverlayLeftPoints.remove(x);
      }
    }
    // Wind monome 
    if (windMonome) {
      int blinkOn = step[6][0] > 0 ? 0 : 15;
      for (int placeInRow = 0; placeInRow < 16; placeInRow++) {
        step[6][placeInRow] = blinkOn;
      }
      
      if (brightnessAdjustment > 0) {
        brightnessAdjustment -= 10;
      } else if (brightnessAdjustment < 0) {
        brightnessAdjustment += 10;
      } else {
        windMonome = false;
        for (int placeInRow = 0; placeInRow < 16; placeInRow++) {
          step[6][placeInRow] = 0;
        }
        step[6][6] = 11;
      }
    }
    
    timer = 0;
    dirty = true;
  } else {
    timer++;
  }
  
  if(dirty) {
    int[][] led = new int[8][16];
    int highlight;
    
    // display steps
    for(int x = 0; x < 16; x++) {
      for(int y = 0; y < 8; y++) {
       
       // highlight the play position
       if(x == 6 && y == play_position) {
         step[y][x] = hightlightOn ? 0 : 10;
       }
       
       led[y][x] = step[y][x];
      }
    }
    
    // update grid
    m.refresh(led);
    dirty = false;
  }
}

public void key(int x, int y, int s) {
  
  // Last row, sliders for brightness and color
  if (s == 1 && (y == 6 || y == 7)) {
    for (int placeInRow = 0; placeInRow < 16; placeInRow++) {
      step[y][placeInRow] = 0;
    }
    step[y][x] = 11;
    
    if (y == 6) {
      switch (x) {
        case 0:  brightnessAdjustment = -60; break;
        case 1:  brightnessAdjustment = -50; break;
        case 2:  brightnessAdjustment = -40; break;
        case 3:  brightnessAdjustment = -30; break;
        case 4:  brightnessAdjustment = -20; break;
        case 5:  brightnessAdjustment = -10; break;
        case 6:  brightnessAdjustment = 0; break;
        case 7:  brightnessAdjustment = 10; break;
        case 8:  brightnessAdjustment = 20; break;
        case 9:  brightnessAdjustment = 30; break;
        case 10: brightnessAdjustment = 40; break;
        case 11: brightnessAdjustment = 50; break;
        case 12: brightnessAdjustment = 60; break;
        case 13: brightnessAdjustment = -250; break;
        case 14: brightnessAdjustment = 250; break;
        case 15: windMonome = true; break;
      }
    } else if (y == 7) {
      switch (x) {
        case 0:  colorSelected = color( 255,   0,   0); break;
        case 1:  colorSelected = color( 255, 128,   0); break;
        case 2:  colorSelected = color( 255, 255,   0); break;
        case 3:  colorSelected = color( 128, 255,   0); break;
        case 4:  colorSelected = color(   0, 255,   0); break;
        case 5:  colorSelected = color(   0, 255, 128); break;
        case 6:  colorSelected = color(   0, 255, 255); break;
        case 7:  colorSelected = color(   0, 128, 255); break;
        case 8:  colorSelected = color(   0,   0, 255); break;
        case 9:  colorSelected = color( 127,   0, 255); break;
        case 10: colorSelected = color( 255,   0, 255); break;
        case 11: colorSelected = color( 255,   0, 127); break;
        case 12: colorSelected = color( 128, 128, 128); break;
        case 13: colorSelected = color(   0,   0,   0); break;
        case 14: colorSelected = color( 255, 255, 255); break;
        case 15: colorSelected = color( 204,   0,   0); break;
      }
      
      if (!step2On) {
        colorOverlay = colorSelected;
      }

    }
   
    dirty = true;
    return;
  }
  
  // Far right step toggles on and off
  if (s == 1 && x == 15 && y < 6) {
    if (y == 0){
      step1On = !step1On;
    } else if (y == 1) {
      step2On = !step2On;
      
      if (!step2On) {
        colorOverlay = colorSelected;
      }
    } else if (y == 2) {
      step3On = !step3On;
    } else if (y == 3){
      step4On = !step4On;
    } else if (y == 4) {
      step5On = !step5On;
    } else if (y == 5) {
      step6On = !step6On;
    }
    
    step[y][x] = step[y][x] == 11 ? 0 : 11; 
    dirty = true;
    return;
  }
  
  // Speed up and slow down timer
  if (s == 1 && x == 6 && y < 6) {
    if (y == 0){
      if (stepTime > 0) {
        stepTime--;
      }
    } else if (y == 1) {
      stepTime = 3;
    } else if (y == 2) {
      stepTime = 10;
    } else if (y == 3) {
      stepTime = 15;
    } else if (y == 4) {
      stepTime = 20;
    } else if (y == 5) {
      stepTime++;
    } 
    
    timer = 0;
    return;
  }
  
  // Color overlay modifiers
  if (s == 1 && (x == 13 || x == 14) && y < 6) {
    for(int placeInColumn = 0; placeInColumn < 6; placeInColumn++) {
      step[placeInColumn][13] = 0;
      step[placeInColumn][14] = 0;
    }
    step[y][x] = 11; 
    
    if (x == 13) {
      switch (y) {
        case 0: blendColorMode = DODGE; break; 
        case 1: blendColorMode = ADD; break;
        case 2: blendColorMode = SUBTRACT; break; 
        case 3: blendColorMode = DARKEST; break;
        case 4: blendColorMode = LIGHTEST; break;
        case 5: blendColorMode = DIFFERENCE; break;
      }
    } else {
      switch (y) {
        case 0: blendColorMode = EXCLUSION; break;
        case 1: blendColorMode = MULTIPLY; break;
        case 2: blendColorMode = SCREEN; break;
        case 3: blendColorMode = OVERLAY; break;
        case 4: blendColorMode = BURN; break; 
        case 5: blendColorMode = SOFT_LIGHT; break;
      }
    }
    
    dirty = true;
    return;
  }
  
  // Monome draw right
  if (s == 1 && x > 6 && x < 13 && y < 6) {
    int adjustedX = x - 7;
    int brightnessAdjustment = step6On ? 100 : -100;
    
    for (int newX = 0; newX < 6; newX++) {
      int xBase = newX * 10;
      int yBase = y * 10;
      for (int gridExpandX = 0; gridExpandX < 10; gridExpandX++) {
        for (int gridExpandY = 0; gridExpandY < 10; gridExpandY++) {
          monomeOverlayRight[xBase+gridExpandX][yBase+gridExpandY] = brightnessAdjustment;
        }
      }
    
      step[y][newX + 7] = 15;  
    }
    
    for (int newY = 0; newY < 6; newY++) {
      int xBase = adjustedX * 10;
      int yBase = newY * 10;
      for (int gridExpandX = 0; gridExpandX < 10; gridExpandX++) {
        for (int gridExpandY = 0; gridExpandY < 10; gridExpandY++) {
          monomeOverlayRight[xBase+gridExpandX][yBase+gridExpandY] = brightnessAdjustment;
        }
      }
    
      step[newY][x] = 15;  
    }

    dirty = true;
    return;
  }
  
  // Monome draw left
  if (s == 1 && y < 6 && x < 6) {
   Point3d d = new Point3d(x, y, 0);
   monomeOverlayLeftPoints.add(d);
   step[y][x] = 15;  

   dirty = true;
   return;
  }
  
  // toggle steps
  //if(s == 1 && y < 6) {
  //  step[y][x] ^= 1;
    
  //  dirty = true; 
  //}
}

class Point3d {
  int x;
  int y;
  int step;
  
  Point3d(int x, int y, int step) {
    this.x = x;
    this.y = y;
    this.step = step;
  }
  
  int getX() {
    return x;
  }
  
  int getY() {
    return y;
  }
  
  int getStep() {
    return step;
  }
}