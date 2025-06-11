class Ball extends A0ForceObject {
  float radius; //<>//
  Player player;
  public Ball(PVector position, double mass, double gravity, float radius) {
    super(position, mass, gravity);
    this.radius = radius;
    this.object = new FCircle(radius * 2);
    object.setPosition(position.x, position.y);
    object.setRestitution(0.6);
    object.setFriction(0.2);
    object.setDensity((float)mass * 100 / (radius * radius));
    object.setGroupIndex(1);
  }
  public void updateObject() {
    copyPhysicalState();
  }
  public void draw() {
     fill(0, 255, 0);
     circle(pos.x, pos.y, radius * 2);
  }
}
