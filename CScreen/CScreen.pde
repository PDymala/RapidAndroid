import ketai.camera.*;
KetaiCamera cam;


void setup() {
  orientation(LANDSCAPE);
  cam = new KetaiCamera(this, 1280, 720, 30);                 // 1
  imageMode(CENTER);
  cam.setCameraID(0);
  cam.start();
  output = createImage(1280, 720, RGB);
}

PImage output;
void draw() {
  if (cam.isStarted()) {

    cam.loadPixels();
    background(0);
    output.loadPixels();
    for (int i= 0; i < cam.pixels.length; i++)
    {
      color c = color(red(cam.pixels[i]), 0, 0);
      output.pixels[i] = c;
    }
    output.updatePixels();
    image(output, width/2, height/2, width, height);
  }
}

void onCameraPreviewEvent() {                                 // 4
  cam.read();                                                 // 5
}
