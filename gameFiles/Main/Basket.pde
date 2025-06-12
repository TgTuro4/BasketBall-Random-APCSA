class Basket {
  private float h;
  private FCircle outerBasket;
  private boolean isRight;
  private PVector position;
  
  public Basket(float h, boolean isRight) {
    this.h = h;
    this.isRight = isRight;
    if (isRight) {
      position = new PVector(width - 50, height - h + 25);
    }
    else {
      position = new PVector(50, height - h + 25); 
    }
    outerBasket = new FCircle(20.0);
    if (isRight) {
      outerBasket.setPosition(position.x - 40, position.y - 12);
    }
    else {
      outerBasket.setPosition(position.x + 40, position.y - 12); 
    }
    outerBasket.setStatic(true);
    outerBasket.setRestitution(0.15);
    outerBasket.setGroupIndex(1);
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
