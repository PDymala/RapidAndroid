//Shows a trace if something moved... 
// still in progress :)

import ketai.camera.*;
KetaiCamera cam;
import java.util.LinkedList;
import java.util.Queue;

void setup() {
  orientation(LANDSCAPE);
  cam = new KetaiCamera(this, 1280, 720, 30);                 // 1
  imageMode(CENTER);
  cam.setCameraID(0);
  cam.start();
  output = createImage(1280, 720, RGB);
   output.loadPixels();//?
}

PImage output;
void draw() {
  if (cam.isStarted()) {
background(0);
    cam.loadPixels();
   
    
  
    
    
    for (int i= 0; i < cam.pixels.length; i++)
    {
    
        
        if (brightness(cam.pixels[i]) / brightness(output.pixels[i]) > 0.6) {
          
          output.pixels[i] = color(255,0,0);
        } else {
          
          output.pixels[i] = cam.pixels[i];
        }
        
        
        
      
      
    }
    output.updatePixels();
    
    image(output, width/2, height/2, width, height);
  }
}

void onCameraPreviewEvent() {                                 // 4
  cam.read();                                                 // 5
}
