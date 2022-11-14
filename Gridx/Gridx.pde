import ketai.camera.*;
KetaiCamera cam;
float gridSize = 20;
PImage output;

void setup() {
  orientation(LANDSCAPE);
  fullScreen();
  cam = new KetaiCamera(this, 1280, 720, 30);                 // 1
  imageMode(CENTER);
  cam.setCameraID(0);
  cam.start();
  output = createImage(1280, 720, RGB);
 
}


void draw() {
   background(0);
  if (cam.isStarted()) {

    cam.loadPixels();


    for (int i = 0; i< height; i+=gridSize) {
      for (int j = 0; j< width; j+=gridSize) {
        textSize(gridSize);
        fill(brightness(cam.get(j, i)));
        text(rndChar(), j, i);
      }
    }
  }
}

private char rndChar() {
  int rnd = (int) (Math.random() * 52); // or use Random or whatever
  char base = (rnd < 26) ? 'A' : 'a';
  return (char) (base + rnd % 26);
}

void onCameraPreviewEvent() {                                 // 4
  cam.read();                                                 // 5
}
