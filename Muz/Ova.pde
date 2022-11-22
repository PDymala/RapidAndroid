class Ova {
  float x, y = 0;
  float xoff = 0;
  public Ova(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void draw() {
   
    pushMatrix();
    translate(x, y);

    xoff = xoff + random(.05);
    beginShape();

    for (float i = TWO_PI/numberOfFreqs; i < TWO_PI; i+= TWO_PI/numberOfFreqs) {

      float temp = noise(xoff) * rad;
      vertex(temp * cos(i), temp * sin(i));
    }
    endShape(CLOSE);
    popMatrix();
  }
}
