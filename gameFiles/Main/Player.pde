class Player extends A0ForceObject {
  float w, h;
  Arm arm;
  FRevoluteJoint armJoint;
  FCircle base, head, swayPart; FBox weight, torso;
  FBox floor;
  Ball held, ball;
  int keyType;
  boolean wasGrounded;
  boolean wasPressed;
  int cooldown = 0;
  public Player(PVector position, float w, float h, FBox floor, int keyType, Ball ball) {
    super(position);
    this.w = w;
    this.h = h;
    this.object = new FCompound();
    this.floor = floor;
    this.keyType = keyType;
    this.ball = ball;
    this.held = null;
    this.wasGrounded = false;
    
    torso = new FBox(w * 0.5, h * 0.8); // prev 0.8
    torso.setPosition(0, -h * 0.4);
    torso.setFill(0, 0, 255);
    ((FCompound)object).addBody(torso);
    
    base = new FCircle(w * 0.5); //  prev 0.81
    base.setPosition(0, 0);
    base.setFriction(0.5);
    ((FCompound)object).addBody(base);
    
    head = new FCircle(w * 0.55); // prev 0.9
    head.setPosition(0, -h * 0.9);
    ((FCompound)object).addBody(head);
    
    // Center of mass
    weight = new FBox(w * 2, h * 2);
    weight.setPosition(0, h);
    weight.setDensity(2.0);
    weight.setSensor(true);
    weight.setRestitution(0);
    ((FCompound)object).addBody(weight);
    
    this.arm = new Arm(this, h * 0.7, 0, -h * 0.8);
    
    armJoint = new FRevoluteJoint(this.object, arm.object);
    armJoint.setAnchor(this.object.getX(), this.object.getY() + -h * 0.7); // useful values
    armJoint.setEnableLimit(true);
    
    if (keyType == 0) { // 'w'
       armJoint.setLowerAngle(PI);
       armJoint.setUpperAngle(2 * PI);
    }
    else {
      armJoint.setLowerAngle(0);
      armJoint.setUpperAngle(PI); 
    }
    
    armJoint.setCollideConnected(false);
    armJoint.setMaxMotorTorque(1000);
   
    object.setGroupIndex(-1);
    object.setPosition(position.x, position.y);
  }
  
  public void jointAddition(FWorld world) {
    world.add(this.armJoint);
    world.add(this.swayPart);
  }
  
  public void updateObject() {
    copyPhysicalState();
    boolean isPressed = keyTracker[keyType];
    boolean isGrounded = grounded(); // JUMP
    if (isGrounded) {
      if (keyTracker[keyType] == true) {
        object.setAngularVelocity(0);
        object.addImpulse(25000 * sin(object.getRotation()), -25000 * cos(object.getRotation()));
      }
    }
    
      if (!wasGrounded && isGrounded && (abs(object.getRotation()) < 0.8)) {
        float dir = object.getRotation() > 0 ? -1 : 1;
        object.setAngularVelocity(object.getAngularVelocity() + (dir * random(0.3, 0.5))); // fresh landing angular velocity
    }
    
    wasGrounded = isGrounded; // detects if landing is fresh or persistent, applies sway only when fresh.
    // getting, throwing in other method shoot()
    if (this.arm.hand.isTouchingBody(this.ball.object) && millis() > cooldown && (ball.holdingPlayer != this)) { // picking upAdd commentMore actions
      if (ball.holdingPlayer != null) {
        ball.holdingPlayer.held = null;
        ball.holdingPlayer.cooldown = millis() + 500;
      }
      held = ball;
      ball.holdingPlayer = this;
      ball.object.setVelocity(0,0);
      ball.object.setStatic(true);
      ball.object.setSensor(true);
      ball.object.setPosition(arm.hand.getX(), arm.hand.getY() - 20);
    }
    if (held != null) {
      ball.object.setStatic(true);
      ball.object.setSensor(true);
      held.object.setPosition(arm.hand.getX(), arm.hand.getY() - 20); 
    }
    wasPressed = isPressed;

    arm.updateObject();
  }
  
  public void shoot(PVector target) {
    if ((held != null)) {
      ball.holdingPlayer = null;
      held.object.setStatic(false);
      held.object.setSensor(false);
      PVector origin = new PVector(arm.hand.getX(), arm.hand.getY());
      PVector dir = PVector.sub(target, origin); // change to basket coords
      dir.normalize();
      held.object.setVelocity(dir.x * 1200, dir.y * 1200);
      held = null;
      cooldown = millis() + 500;
    }
  }
  
  boolean grounded() {
    return (object.isTouchingBody(floor)) && (abs(object.getRotation()) < PI * 1/3);
  }
  
  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(object.getRotation());
     
    if (keyType == 0) {
       fill(255, 120, 120); 
    }
    if (keyType == 1) {
       fill(120, 120, 255); 
    }
    rect(0, -h * 0.4, w * 0.5, h * 0.8); // prev 0.8 w
    ellipse(0, -h * 0.9, w * 0.51, w * 0.51);  
  
    if (grounded()) fill(200, 200, 255, 150);//base prev 0.81
    if (!grounded()) fill(255, 100, 100, 200);
    ellipse(0, 0, w * 0.51, w * 0.51);
    
    
    popMatrix();
    arm.draw();
  }
}
