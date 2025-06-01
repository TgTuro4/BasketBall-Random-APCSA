class Ball extends A0ForceObject {
  float radius;
  public Ball(PVector position, double mass, double gravity, float radius) {
    super(position, mass, gravity);
    this.radius = radius;
    this.object = new FCircle(radius * 2);
    object.setPosition(position.x, position.y);
    object.setRestitution(0.6);
    object.setFriction(0.2);
    object.setDensity((float)mass * 100 / (radius * radius));
  }
  public void updateObject() {
    copyPhysicalState();
    if (this.vel.y < 0.15) this.vel.y = 0; // attempt to fix jittering when ball is on the ground, doesn't work.
  }
  public void draw() {
     fill(0, 255, 0);
     circle(pos.x, pos.y, radius * 2);
  }
}
