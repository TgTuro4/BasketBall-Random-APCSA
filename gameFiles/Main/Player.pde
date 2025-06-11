class Player extends A0ForceObject {
  float w, h;
  Arm arm;
  FRevoluteJoint armJoint, swayPartJoint;
  FCircle base, head, swayPart; FBox weight, torso;
  FBox floor;
  Ball held, ball;
  int keyType;
  boolean wasGrounded;
  boolean wasPressed;
  int cooldown = 0;
  public Player(PVector position, double mass, float w, float h, FBox floor, int keyType, Ball ball) {
    super(position, mass);
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
    torso.setDensity((float)mass * 0.2 / (w * h));
    torso.setFill(0, 0, 255);
    ((FCompound)object).addBody(torso);
    
    base = new FCircle(w * 0.5); //  prev 0.81
    base.setPosition(0, 0);
    base.setDensity((float)mass * 0.1 / (PI * w * w));
    base.setFriction(0.5);
    ((FCompound)object).addBody(base);
    
    head = new FCircle(w * 0.55); // prev 0.9
    head.setPosition(0, -h * 0.9);
    head.setDensity((float)mass * 0.1 / (PI * w * w));
    ((FCompound)object).addBody(head);

    for (FBody obj: new FBody[] {torso,base,head}) {
      obj.setDensity(0);
    }
    
    weight = new FBox(w * 2, h * 2); // ** outside of and below the player, heavy to make the player balance. NOTE: balances somewhat slowly when within 30 degrees of standing upright. 0.4 0.4
    weight.setPosition(0, h);
    weight.setDensity(2.0);
    weight.setSensor(true);
    weight.setRestitution(0);
    ((FCompound)object).addBody(weight);
    
    this.arm = new Arm(this, h * 0.7, 0, -h * 0.8); //
    
    armJoint = new FRevoluteJoint(this.object, arm.object); //
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
   
    // // //
   
    swayPart = new FCircle(5);
    swayPart.setPosition(position.x, position.y - h * 0.9);
    swayPart.setDensity(0.01);
    swayPartJoint = new FRevoluteJoint(swayPart, object);
    swayPartJoint.setAnchor(position.x, position.y -h * 0.9);
    swayPartJoint.setEnableLimit(true);
    swayPartJoint.setLowerAngle(-0.1);
    swayPartJoint.setUpperAngle(0.1);
    swayPartJoint.setCollideConnected(false);
   
   
   // // //
   object.setGroupIndex(-1);
    object.setPosition(position.x, position.y);
  }
  
  public void jointAddition(FWorld world) {
    world.add(this.armJoint);
    world.add(this.swayPart);
    world.add(this.swayPartJoint);
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
    
      if (!wasGrounded && isGrounded) {
        float dir = object.getRotation() > 0 ? -1 : 1;
        if (abs(object.getRotation()) < 0.8)
          object.addTorque(dir * 30000);
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
    // debug
    //float d = dist(arm.hand.getX(), arm.hand.getY(), ball.object.getX(), ball.object.getY());
    //println("Distance to ball:", d);
    //println(held);
    //print(held);
    arm.updateObject();
  }
  
  public void shoot(PVector target) {
    if ((held != null)) {
      print("threw");
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
    return (object.isTouchingBody(floor)) && (object.getRotation() % (2 * PI) < PI * 1/4) && (object.getRotation() % (2 * PI) > PI * -1/4);
  }
  
  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(object.getRotation());
     
    fill(0, 0, 255, 150); //torso
    rect(0, -h * 0.4, w * 0.5, h * 0.8); // prev 0.8 w
    
    if (grounded()) fill(200, 200, 255, 150);//base prev 0.81
    if (!grounded()) fill(255, 100, 100, 200);
    ellipse(0, 0, w * 0.51, w * 0.51);
    
    fill(180, 180, 240, 200); // head prev 0.9
    ellipse(0, -h * 0.9, w * 0.51, w * 0.51);
    
    popMatrix();
    arm.draw();
  }
}
