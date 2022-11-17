/**
 5 min app. Stroboscope on screen
 @Tech Processing.org - Android
 @Author P.Dymala
 */

void setup() {
  fullScreen();
  background(0);
  textFont(createFont("SansSerif", displayDensity * 24));
  textAlign(CENTER, CENTER);
}

int x, y = 0;
int maxDelay = 800;

int xDelay, yDelay = maxDelay;
boolean isLight = true;

void draw() {
  try {
    if (isLight) {
      background(255);
      isLight = false;
      fill(0);
      UI();
      Thread.sleep(xDelay);
    } else {
      background(0);
      isLight = true;
      fill(255);
      UI();
      Thread.sleep(yDelay);
    }
  }
  catch (InterruptedException e) {
    print("thread error");
  }
}

void UI(){
      text("<- dark duration ->", width/2, height-35);
      pushMatrix();
      translate(width, height/2);
      rotate(radians(-90));
      text("<-- light duration -->", 0, -35);
      popMatrix();
  
}

void mousePressed() {

  xDelay = int( map(mouseX, 0, width, 0, maxDelay));
  yDelay =  int(map(mouseY, 0, height, 0, maxDelay));
}
