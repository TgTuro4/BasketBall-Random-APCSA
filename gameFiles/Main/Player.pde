class Player extends A0ForceObject {
  float w, h;
  Arm arm;
  FRevoluteJoint armJoint;
  public Player(PVector position, double mass, double gravity, float w, float h) {
    super(position, mass, gravity);
    this.w = w;
    this.h = h;
    this.object = new FCompound();
    
    FBox torso = new FBox(w * 0.8, h * 0.8); //
    torso.setPosition(0, -h * 0.4);
    torso.setDensity((float)mass * 0.2 / (w * h));
    torso.setFill(0, 0, 255);
    ((FCompound)object).addBody(torso);
    
    FCircle base = new FCircle(w * 0.81); // 
    base.setPosition(0, 0);
    base.setDensity((float)mass * 0.1 / (PI * w * w));
    ((FCompound)object).addBody(base);
    
    FCircle head = new FCircle(w * 0.9);
    head.setPosition(0, -h * 0.9);
    head.setDensity((float)mass * 0.1 / (PI * w * w));
    ((FCompound)object).addBody(base);
    
    FBox weight = new FBox(w * 0.4, h * 0.4); // ** outside of and below the player, heavy to make the player balance. NOTE: balances somewhat slowly when within 30 degrees of standing upright.
    weight.setPosition(0, h * 5);
    weight.setDensity(500.0);
    weight.setSensor(true);
    weight.setRestitution(0);
    ((FCompound)object).addBody(weight);
    
    this.arm = new Arm(this, h * 0.7, 0, -h * 0.8); //
    ((FCompound)object).addBody(arm.object);
    
    armJoint = new FRevoluteJoint(this.object, arm.object);
    armJoint.setAnchor(this.object.getX(), this.object.getY() + -h * 0.7);
    armJoint.setEnableLimit(true);
    
    armJoint.setLowerAngle(0);
    armJoint.setUpperAngle(PI);
    
    armJoint.setCollideConnected(false);
    armJoint.setMaxMotorTorque(1000); // could be useful later
   
    torso.setGroupIndex(-1); base.setGroupIndex(-1); weight.setGroupIndex(-1); head.setGroupIndex(-1); // no self-collision
   
   
    object.setPosition(position.x, position.y);
  }
  
  public void armJointAddition(FWorld world) {
    world.add(this.armJoint); 
  }
  
  public void updateObject() {
    copyPhysicalState();
    arm.updateObject(); // **
  }
  
  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(object.getRotation());
   
    fill(0, 0, 255, 150); //torso
    rect(0, -h * 0.4, w * 0.8, h * 0.8);
    
    fill(200, 200, 255, 150);//base
    ellipse(0, 0, w * 0.81, w * 0.81);
    
    fill(180, 180, 240, 200); // head
    ellipse(0, -h * 0.9, w * 0.9, w * 0.9);
    
    fill(50, 50, 50); //weight
    rect(0, h * 5, w * 0.1, h * 0.05);
    popMatrix();
    arm.draw();

    PImage shirtSheet = loadImage("../imgs/tshirt-sheet0scaled.png");
    PImage shirt = shirtSheet.get(0, 440, 60, 110);

    PImage shortSheet = loadImage("../imgs/rightshort-sheet0scaled.png");
    PImage shorts = shortSheet.get(0,130,60,130);



    image(shirt, 50, 50);
    image(shorts, 50, 160);







  }
}
