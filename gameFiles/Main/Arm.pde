class Arm extends A0ForceObject {
  float armLength, w; // angle is handled in radians for all code
  FCircle hand = new FCircle(90);
  Player player;
  boolean swinging;
  int keyType;
  public Arm(Player attachedPlayer, float armLength, float attachX, float attachY) {
    super(attachedPlayer.pos.copy(), attachedPlayer.mass * 0.2);
    this.w = attachedPlayer.w * 0.5;
    this.player = attachedPlayer;
    this.armLength = armLength;
    this.keyType = attachedPlayer.keyType; // swing & jump sync to the same key.
    
    this.object = new FBox((float)w, (float)armLength);
    object.setDensity(0.1);
    object.setPosition(
      attachedPlayer.object.getX() + attachX, 
      attachedPlayer.object.getY() + attachY + armLength / 2
    );
    object.setGroupIndex(-1);
    
    hand.setSensor(true);
    hand.setRestitution(0);
  }
  void swing() {
    object.setAngularVelocity(8 * (keyType * 2 - 1)); // prev 5
    //if (object.getRotation() > player.object.getRotation() + PI)
      //object.setAngularVelocity(0);
  }
  void updateObject() { // hand positioning
    if (keyTracker[keyType] == true) {
      swing();
    } else if (object.getRotation() < 0.05 && keyType == 0) {
      object.setAngularVelocity(0);
    } else if (object.getRotation() > player.object.getRotation() + 0.05) {
      object.setAngularVelocity(-8 * (keyType * 2 - 1));
    }
    float handX = player.armJoint.getAnchorX() + cos(object.getRotation() + PI / 2) * armLength * 0.75;
    float handY = player.armJoint.getAnchorY() + sin(object.getRotation() + PI / 2) * armLength * 0.75;
    hand.setPosition(handX, handY);
  }
  void draw(){
    pushMatrix();
    translate(object.getX(), object.getY());
    rotate(object.getRotation());
    
    fill(0, 255, 0);
    rectMode(CENTER);
    rect(0, 0, w * 0.6, armLength);
    
    fill(255, 0, 0, 50);
    ellipse(0, armLength * 0.4, 90, 90);
    
    popMatrix();
  }
}
