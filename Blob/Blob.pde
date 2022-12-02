/**
 5 min app. Just a blob
 @Tech Processing.org - Android
 @Author P.Dymala
 */
void setup() {
  background(0);
  stroke(0, 255, 0);
  fullScreen();
  noFill();
}
float phase = 0;
float zoff = 0;
int numberOfFreqs = 36;
float rad = width/3;

void draw() {
  background(0);

  pushMatrix();
  translate(width/2, height/2);


  beginShape();

  for (float i = TWO_PI/numberOfFreqs; i < TWO_PI; i+= TWO_PI/numberOfFreqs) {


    float xoff = map(cos(i + phase), -1, 1, 0, 30);
    float yoff = map(sin(i + phase), -1, 1, 0, 30);
    float r = map(noise(xoff, yoff, zoff), 0, 1, 50, height / 3);
    float x = r * cos(i);
    float y = r * sin(i);
    vertex(x, y);
  }
  endShape(CLOSE);
  popMatrix();

  phase += 0.003;
  zoff += 0.01;
}
