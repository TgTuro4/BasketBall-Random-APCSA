import fisica.*;

class Modification {
  private float basketHeightChanger, gravity;
  private FWorld world;

  public Modification(FWorld world) {
    this.world = world;
    randomizeMods();
  }

  public void randomizeMods() {
    basketHeightChanger = random(-100, 100);
    gravity = random(800, 1200);
  }

  public void applyMods() {
    heightChanger = basketHeightChanger;
    world.setGravity(0, gravity);
  }

  public String toString() {
    return String.format("Gravity: %f\nBasket height change: %f\n", gravity, basketHeightChanger);
  }
}
