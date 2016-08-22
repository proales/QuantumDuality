// Pixel Pusher setup class.
class TestObserver implements Observer {
  public boolean hasStrips = false;
  public void update(Observable registry, Object updatedDevice) {
    //println("Registry changed!");
    if (updatedDevice != null) {
      //println("Device change: " + updatedDevice);
    }
    this.hasStrips = true;
  }
}

void drawPixelPusher(){
  if (testObserver.hasStrips) {
    List<PixelPusher> pusherList = registry.getPushers();
    for(PixelPusher pusher : pusherList) {
      int pusherNumber;
      if (pusher.getStrips().size() == 6) {
        pusherNumber = 1;
      } else {
        pusherNumber = 2;
      }
      
      List<Strip> strips = pusher.getStrips();
      for(int stripX = 0; stripX < strips.size(); stripX++) {
        Strip strip = strips.get(stripX);
        int sheetNumber = sheetNumber(pusherNumber, stripX);
        if (sheetNumber == 99) {
          strip.setPixel(colorSelected, 0);
          strip.setPixel(colorOverlay, 1);
        } else {
          int stripLength = strip.getLength();
          for (int pixelX = 0; pixelX < stripLength; pixelX++) {
             int averageColor = getAverageColor(sheetNumber, pixelX);
             strip.setPixel(averageColor, map400[pixelX]);
          }
        }
      }
    }
  }
}

int getAverageColor(int sheet, int pixelX) {
  int sheetXOffset = sheetXOffset(sheet);
  int sheetYOffset = sheetYOffset(sheet);
  int x = pixelX % sheetWidth;
  int y = pixelX / sheetHeight;
  return avgColors[sheetXOffset + x][sheetYOffset + y];
}


int sheetNumber(int pusherNumber, int stripX) {
  /**  Sheets are arranged like so:
   *   0, 1, 2
   *   3, 4, 5
   *   6, 7, 8
   */
  if (pusherNumber == 1) {
    switch (stripX) {
      case 0: return 0;
      case 1: return 1;
      case 2: return 2;
      case 3: return 3;
      case 4: return 4;
      case 5: return 5;
    }
  } else {
    switch (stripX) {
      case 0: return 6;
      case 1: return 7;
      case 2: return 8;
      case 3: return 99; // The special 2 piece strip
    }
  }
  
  return 0;
}

int sheetXOffset(int sheet) {
  /**  Sheets are arranged like so:
   *   0, 1, 2
   *   3, 4, 5
   *   6, 7, 8
   */
   switch (sheet) {
     case 0: return 0;
     case 1: return sheetWidth;
     case 2: return sheetWidth * 2;
     case 3: return 0;
     case 4: return sheetWidth;
     case 5: return sheetWidth * 2;
     case 6: return 0;
     case 7: return sheetWidth;
     case 8: return sheetWidth * 2;
   }
   
   return 0;
}

int sheetYOffset(int sheet) {
  /**  Sheets are arranged like so:
   *   0, 1, 2
   *   3, 4, 5
   *   6, 7, 8
   */
   switch (sheet) {
     case 0: return 0;
     case 1: return 0;
     case 2: return 0;
     case 3: return sheetHeight;
     case 4: return sheetHeight;
     case 5: return sheetHeight;
     case 6: return sheetHeight * 2;
     case 7: return sheetHeight * 2;
     case 8: return sheetHeight * 2;
   }
   
   return 0;
}