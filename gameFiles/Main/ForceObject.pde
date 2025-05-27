abstract class ForceObject {
  PVector vel, pos, accel, force, topLeft, bottomRight;
  double gravity, mass;
  public ForceObject(PVector velocity, PVector position, PVector acceleration, PVector force, double gravity, double mass, PVector topLeft, PVector bottomRight) {
    this.vel = velocity;
    this.pos = position;
    this.accel = acceleration;
    this.mass = mass;
    this.force = force;
    this.gravity = gravity;
  }
  public void applyForce(PVector force) {
    this.force.add(force);
  }
  private void setGravity(double newGravity) {
    this.gravity = newGravity;
  }
  /* 
    COLLISION METHODS ASSUME THAT OTHER OBJECT IS A RECTANGLE.
  */
  private boolean checkCollisionRectangle(PVector topLeft, PVector bottomRight, ForceObject other) {
    //
  }
  private boolean checkCollisionCircle(double radius, PVector center, ForceObject other) {
    // 
  }
  public void drawObject() {
    //
  }
}
