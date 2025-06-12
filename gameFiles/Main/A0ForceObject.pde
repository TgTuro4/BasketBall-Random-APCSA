import fisica.*;
abstract class A0ForceObject {
  FBody object; // handles all physics by default
  PVector pos;
  public A0ForceObject(PVector position) {
    this.pos = position.copy();
  }
  public void copyPhysicalState() {
    pos.set(object.getX(), object.getY());
    object.setAllowSleeping(false);
  }
  abstract void draw();
  abstract void updateObject();
}
