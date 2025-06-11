class Basket {
  float radius, h;
  FCircle outerBasket;
  boolean isRight;
  PVector position;
  
  public Basket(PVector position, float h, boolean isRight) {
    this.position = position;
    this.h = h;
    this.isRight = isRight;
  }

  public void draw() {
    pushMatrix();
    PImage basketImg = loadImage("../Images/basketballRim.png");

    if (isRight) { // false -> left | true -> right
      scale(-1, 1);
      image(basketImg, -width, height -  h, 100, 100);
    }
    else {
      image(basketImg, 0 , height - h, 100, 100);
    }
    popMatrix();
  }
}
