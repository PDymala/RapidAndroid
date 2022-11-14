/**
 5 min app. pop a bubble.
 @Tech Processing.org - Android
 @Author P.Dymala
 */
 import java.util.*;

private ArrayList<Bubble> bubbles;
private int counter;
private int newBubbleSpeed = 100;
private float buttonHeight = 100 * displayDensity;


void setup() {

  fullScreen();
  bubbles = new ArrayList<>();
  textAlign(CENTER,CENTER);
  textFont(createFont("SansSerif", displayDensity * 24));
}


void draw() {

  background(0);
  if (counter == newBubbleSpeed) {
    newBubbleSpeed--;
    counter = 0;
    bubbles.add(new Bubble(random(width), random(height)));
  }

  for (Bubble b : bubbles) {
    if (b.getActive()) {
      b.draw();
      b.dimmUp();
    }
  }
  counter++;
  
  
  rect(0, height - buttonHeight, width, buttonHeight);
  text("Touch this area to clear", 0, height - buttonHeight, width,
  buttonHeight);
  
  
}
void reset(){
  counter = 0;
  newBubbleSpeed = 100;  
  bubbles.clear();
}


void mousePressed() {
  if (height - buttonHeight < mouseY) reset();
  
  for (Bubble b : bubbles) {
    if (b.isInBubble(mouseX, mouseY)) {
      b.changeActive();
    }
  }
}
