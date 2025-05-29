class Modification {
  private double mass, gravity, basketHeight;
  private String description;
  
  public Modification() {
    randomizeMods();
  }
  
  public void randomizeMods() {
    mass = random(1.0, 3.5);
    gravity = random(6.0, 12.0);
    basketHeight = random(2.7, 3.7);
    description = String.format("mass: %d\ngravity: %d\nbasket height: %d", mass, gravity, basketHeight);
  }
  
  public String toString() {
    return description;
  }
}
