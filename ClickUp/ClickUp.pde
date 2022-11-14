/**
 5 min app. Can you click fast to make the screen white?
 @Tech Processing.org - Android
 @Author P.Dymala
 */

private float bg = 0;
private float decreseSpeed = 1;
private float additionPerMousePressed = 15;

void setup() {
  fullScreen();
  background(0);
  textFont(createFont("SansSerif", displayDensity * 24));
  textAlign(CENTER, CENTER);
}

void draw() {
  background(bg, bg, bg);

  //prevents bg from building up outer color range
  if (bg > 0) {
    bg -=decreseSpeed;
  }

  text("click me!", width/2, height/2);
}

void mousePressed() {
  //prevents bg from building up outer color range
  if (bg < 255) {
    bg+=additionPerMousePressed;
  }
}
