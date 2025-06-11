class Basket {
  float radius, h;
  FCircle outerBasket;
  boolean isRight;
  PVector position;
  
  public Basket(float h, boolean isRight) {
    this.h = h;
    this.isRight = isRight;
    if (isRight) {
      position = new PVector(width - 50, height - h + 25);
    }
    else {
      position = new PVector(50, height - h + 25); 
    }
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
    ellipse(position.x, position.y, 20, 20);
  }
}
