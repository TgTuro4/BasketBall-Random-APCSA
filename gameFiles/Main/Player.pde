class Player extends A0ForceObject {
  float w, h;
  public Player(PVector position, double mass, double gravity, float w, float h) {
    super(position, mass, gravity);
    this.w = w;
    this.h = h;
    this.object = new FBox(w, h);
    object.setPosition(position.x, position.y);
    /*
      TO DO LIST:
      use FCompound and put a circle + heavy square inside of the bottom so that it gravitates towards standing upright like a mighty bean
    */
  }
  
  public void updateObject() {
    copyPhysicalState();
  }
  
  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(object.getRotation());
   
    rect(0, 0, w, h);
    
    popMatrix();
  }
}
