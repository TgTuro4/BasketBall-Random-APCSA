class Ball extends A0ForceObject {
  float radius;
  public Ball(PVector position, double mass, double gravity, float radius) {
    super(position, mass, gravity);
    this.radius = radius;
    this.object = new FCircle(radius * 2);
    object.setPosition(position.x, position.y);
    object.setRestitution(0.8);
  }
  public void updateObject() {
    copyPhysicalState();
    vel.y += gravity;
    pos.add(vel);
    if (pos.y + radius > height - 100) {
      object.setPosition(pos.x, height - 100 - radius);
      object.setVelocity(vel.x, -vel.y * 0.8 * random(0.9, 1.1)); // random bounce elasticity
    }
    if (this.vel.y < 0.15) this.vel.y = 0; // attempt to fix jittering when ball is on the ground, doesn't work.
  }
  public void draw() {
     circle(pos.x, pos.y, radius * 2);
  }
}
