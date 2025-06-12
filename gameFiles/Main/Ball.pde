class Ball extends A0ForceObject {
  float radius;
  Player holdingPlayer;
  int time = millis();
  public Ball(PVector position, float radius) {
    super(position);
    this.radius = radius;
    this.object = new FCircle(radius * 2);
    object.setPosition(position.x, position.y);
    object.setRestitution(0.6);
    object.setFriction(0.2);
    object.setGroupIndex(1);
  }

  public void updateDensity(float mass) {
    object.setDensity(mass * 100 / (radius * radius));
  }

  public void updateObject() {
    copyPhysicalState();
    //println(holdingPlayer);
  }
  public void draw() {
     fill(100, 30, 30);
     circle(pos.x, pos.y, radius * 2);
  }
}
