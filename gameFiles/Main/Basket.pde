class Basket extends A0ForceObject {
  float radius, h;
  FCircle outerBasket;
  FBox innerBasket;
  FCompound object;
  boolean isLeft;

  public Basket(PVector position, float radius, float h, boolean isLeft) {
    super(position, 0);
    this.radius = radius;
    this.h = h;
    this.isLeft = isLeft;

    outerBasket = new FCircle(radius * 2);
    outerBasket.setPosition(0, 0);

    innerBasket = new FBox(radius * 2, h);
    innerBasket.setPosition(0, h / 2);

    object = new FCompound();
    object.addBody(outerBasket);
    object.addBody(innerBasket);
    object.setPosition(position.x, position.y);
    object.setStatic(true);
    object.setGroupIndex(1);
  }

  public void updateObject() {
    copyPhysicalState();
  }

  public void draw() {
    fill(150, 75, 0);
    rectMode(CENTER);
    rect(pos.x, pos.y, radius * 4, h);
    if (isLeft) {
      ellipse(pos.x + radius * 6, pos.y - h / 3, radius * 12, radius * 1.5);
    } else {
      ellipse(pos.x - radius * 6, pos.y - h / 3, radius * 12, radius * 1.5);
    }
    rectMode(CORNER);
  }
}
