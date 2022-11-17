
float xoff = 0.0;

void setup() {
  fullScreen();
  background(0);
}

int numberOfFreqs = 36;
float rad = 200;

void draw() {
  background(0);
  translate(width/2, height/2);
  background(0);
  stroke(255);
  noFill();
  xoff = xoff + .01;
  beginShape();
  for (float i = TWO_PI/numberOfFreqs; i < TWO_PI; i+= TWO_PI/numberOfFreqs) {
     
    float temp = noise(xoff) * rad;
    vertex(temp * cos(i), temp * sin(i));
  }
  endShape(CLOSE);
}
