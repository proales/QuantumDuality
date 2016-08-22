void setup() {
  // Define window size
  size(1040, 420);
  canvasHeight = 420;
  canvasWidth = 1040;
  
  // No lines
  noStroke();
  
  // Setup Midi
  MidiBus.list();
  myBus = new MidiBus(this, "Logidy UMI3", "Real Time Sequencer"); 
  myBus2 = new MidiBus(this, "Moog Music, Inc.", "Real Time Sequencer"); 
  
  // Setup pixel pusher
  registry = new DeviceRegistry();
  testObserver = new TestObserver();
  registry.addObserver(testObserver);
  registry.setLogging(false);
  registry.setAntiLog(true);
  
  // Setup monome
  m = new Monome(this);
  dirty = true;
  step = new int[8][16];
  monomeOverlayRight = new int[60][60];
  monomeOverlayLeft = new int[6][6];
  monomeOverlayLeftPoints = new ArrayList<Point3d>();
  
  // Setup drawing variables
  avgColors = new int[numberColumns][numberRows];
  
  // Set initial state of Monome
  // Set left box
  for (int x = 0; x < 6; x++) {
    for (int y = 0; y < 6; y++) {    
      step[y][x] = 5;
    }
  }
  // Set right box
  for (int y = 7; y < 13; y++) {
    for (int x = 0; x < 6; x++) {    
      step[x][y] = 5;
    }
  }
  // Set color and brightness sliders
  step[6][6] = 11;
  step[7][6] = 11;
  // Set blend mode
  step[0][13] = 11;
  // Step1,4,5,6 on by default
  step[0][15] = 11;
  step[3][15] = 11;
  step[4][15] = 11;
  step[5][15] = 11;
}