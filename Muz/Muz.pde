/**
 5 min app. Click for a suspicious rhythm...
 @Tech Processing.org - Android
 @Author P.Dymala
 */

import java.util.ArrayList;

int numberOfFreqs = 36;
float rad = 200;
ArrayList<Ova> ov = new ArrayList<Ova>();

void setup() {
  fullScreen();
  background(0);
  stroke(255);
  noFill();
}


void draw() {
  background(0);

  if (ov.size() > 0) {
    for (Ova o : ov) {
      o.draw();
    }
  }
}
void mousePressed() {

  ov.add(new Ova(mouseX, mouseY));
}
