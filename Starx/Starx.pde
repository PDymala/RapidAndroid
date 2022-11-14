import ketai.camera.*;
KetaiCamera cam;
float gridSize = 20;

void setup() {
  orientation(LANDSCAPE);
  fullScreen();
  cam = new KetaiCamera(this, 1280, 720, 30);                 // 1
  imageMode(CENTER);
  cam.setCameraID(0);
  cam.start();
  output = createImage(1280, 720, RGB);
  stroke(255);
  strokeWeight(3);
  background(0);
}

PImage output;
void draw() {

  if (cam.isStarted()) {

    cam.loadPixels();
    background(0);

    for (int i = 0; i< height; i+=gridSize) {
      for (int j = 0; j< width; j+=gridSize) {

        pushMatrix();
        translate(j+gridSize/2, i+gridSize/2);
        rotate(radians(map(brightness(cam.get(j, i)), 0, 255, 0, 180)));

        line(0, gridSize/2, 0, -gridSize/2);

        popMatrix();
      }
    }
  }
}

void onCameraPreviewEvent() {                                 // 4
  cam.read();                                                 // 5
}
