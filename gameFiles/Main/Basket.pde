class Basket extends A0ForceObject {
  float radius, h;
  FCircle outerBasket;
  FBox innerBasket;
  FCompound object;

  public Basket(PVector position, float radius, float h) {
    super(position, 0);
    this.radius = radius;
    this.h = h;

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
    fill(200, 100, 0); 
    float x = object.getX();
    float y = object.getY();

    ellipse(x, y, radius * 2, radius * 2);
    rectMode(CENTER);
    rect(x, y + h / 2, radius * 2, h); 
  }
}
