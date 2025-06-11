class Ball extends A0ForceObject {
  float radius; //<>// //<>//
  Player holdingPlayer;
  int time = millis();
  public Ball(PVector position, double mass, float radius) {
    super(position, mass);
    this.radius = radius;
    this.object = new FCircle(radius * 2);
    object.setPosition(position.x, position.y);
    object.setRestitution(0.6);
    object.setFriction(0.2);
    object.setDensity((float)mass * 100 / (radius * radius));
    object.setGroupIndex(-1);
  }
  public void updateObject() {
    copyPhysicalState();
    println(holdingPlayer);
  }
  public void draw() {
     fill(100, 30, 30);
     circle(pos.x, pos.y, radius * 2);
  }
}
