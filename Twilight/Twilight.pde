/**
 5 min app. brightness sensor. Draws percentage and an icon on how bright it is in the room.
 Warning, not every phone/camera allows to disable autoadjustment. In camy cases, the camera will try to adjust to around 60%.
 
 @Tech Processing.org - Android
 @Author P.Dymala
 */
 import ketai.camera.*;
import java.util.Arrays;

KetaiCamera cam;

void setup() {
  fullScreen();

  cam = new KetaiCamera(this, 10, 10, 30);
  cam.manualSettings();
  cam.setCameraID(0);
  cam.start();

  textFont(createFont("SansSerif", displayDensity * 24));
  textAlign(CENTER, CENTER);
  imageMode(CENTER);
}


void draw() {
  background(0);
  if (cam.isStarted()) {
    cam.loadPixels();
    int brightness = (int)(findAverageBrightness(cam.pixels));
    int percent = (int) (brightness*100 / 255);
    fill(brightness);
    circle(width/2, height/2, 400);
    fill(255-brightness);
    text(percent+"%", width/2, height/2);
  }
}
public  double findAverageBrightness(int[] array) {
  double sum = 0;
  for (int i = 0; i < array.length; i++) {
    sum += brightness(array[i]);
  }

  return  sum / array.length;
}
void onCameraPreviewEvent() {                                 // 4
  cam.read();                                                 // 5
}
