class Arm extends A0ForceObject {
  float armLength, w, angle; // angle is handled in radians for all code
  FCircle hand = new FCircle(20);
  Player player;
  boolean swinging;

  public Arm(Player attachedPlayer, float armLength, float attachX, float attachY) {
    super(attachedPlayer.pos.copy(), attachedPlayer.mass * 0.2, 0);
    this.w = attachedPlayer.w * 0.6;
    this.player = attachedPlayer;
    this.armLength = armLength;
    
    this.object = new FBox((float)w, (float)armLength);
    object.setPosition(
      attachedPlayer.object.getX() + attachX, 
      attachedPlayer.object.getY() + attachY + armLength / 2
    );
    
    hand.setSensor(true);
    hand.setRestitution(0);
  }
  
  void swing() {
    object.setAngularVelocity(5);
    if (object.getRotation() > player.object.getRotation() + PI)
      object.setAngularVelocity(0);
  }

  void updateObject() { // hand positioning
    if (keyPressed == true && key == 'w') {
      swing();
    } else if (object.getRotation() == player.object.getRotation()) {
      object.setAngularVelocity(0);
    } else {
      object.setAngularVelocity(-5);
    }
    float handX = object.getX() + cos(object.getRotation()) * armLength * 0.4;
    float handY = object.getY() + sin(object.getRotation()) * armLength * 0.4;
    hand.setPosition(handX, handY);
  }

  void draw(){
    pushMatrix();
    translate(object.getX(), object.getY());
    rotate(object.getRotation());
    
    fill(0, 255, 0);
    rectMode(CENTER);
    rect(0, 0, w, armLength);
    
    fill(255, 0, 0, 50);
    ellipse(0, armLength * 0.4, w*1.5, w*1.5);
    
    popMatrix();
  }
}
