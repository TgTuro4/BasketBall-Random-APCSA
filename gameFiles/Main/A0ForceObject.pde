import fisica.*;
abstract class A0ForceObject {
  FBody object; // handles all physics by default
  PVector pos;
  double mass, gravity;
  public A0ForceObject(PVector position, double mass, double gravity) {
    this.pos = position.copy();
    this.mass = mass;
    this.gravity = gravity;
  }
  public void setGravity(double newGravity) {
    this.gravity = newGravity;
  }
  public void copyPhysicalState() {
    pos.set(object.getX(), object.getY());
  }
  abstract void draw();
  abstract void updateObject();
}
