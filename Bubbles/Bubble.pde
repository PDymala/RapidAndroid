
class Bubble {
  private float x, y;
  private int dimm = 0;
  private boolean active = true;

  public Bubble(float x, float y) {
    this.x = x;
    this.y = y;
    noStroke();
    fill(random(255),random(255),random(255), 180);
  }


  public void changeActive() {
    active = false;
  }

  public boolean getActive() {
    return active;
  }

  void dimmUp() {
    dimm+=1;
  }

  void draw() {
    ellipse (x, y, dimm, dimm);
  }

  boolean isInBubble(float xC, float yC) {
    if ((xC < x + dimm) && (xC > x - dimm)  &&  ( yC < y + dimm) && (  yC > y - dimm)) {
      return true;
    } else {
      return false;
    }
  }
}
