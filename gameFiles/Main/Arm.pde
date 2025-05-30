class Arm extends A0ForceObject {
  double armLength, w, h, angle;
  Player x;
  public Arm(Player attachedPlayer) {
    super(attachedPlayer.pos, attachedPlayer.mass, attachedPlayer.gravity);
    this.w = attachedPlayer.w;
    this.h = attachedPlayer.h / 2;
    this.object = new FBox(10, 30);
    this.copyPhysicalState();
  }
  void swing() {
     // operates using FRevoluteJoint on 
  }
  void draw(){};
}
