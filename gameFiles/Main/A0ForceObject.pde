import fisica.*;
abstract class A0ForceObject {
  FBody object; // handles all physics by default
  PVector vel, pos, accel, force;
  double gravity, mass;
  public A0ForceObject(PVector position, double mass, double gravity) {
    this.pos = position.copy();
    this.mass = mass;
    this.gravity = gravity;
    this.vel = new PVector(0,0);
    this.accel = new PVector(0,0);
    this.force = new PVector(0,0);
  }
  public void applyForce(PVector force) {
    this.force.add(force);
  }
  public void setGravity(double newGravity) {
    this.gravity = newGravity;
  }
  public void copyPhysicalState() {
    pos.set(object.getX(), object.getY());
    vel.set(object.getVelocityX(), object.getVelocityY());
  }
  abstract void draw();
  abstract void updateObject();
}
