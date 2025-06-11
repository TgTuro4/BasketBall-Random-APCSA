class Modification {
  private float ballMass, gravity, basketHeight, armLength;
  private String description;
  private Player[] players;
  private Basket[] baskets;
  private Ball ball;
  
  public Modification(Player[] players, Basket[] baskets, Ball ball) {
    this.players = players;
    this.baskets = baskets;
    this.ball = ball;
    randomizeMods();
  }
  
  public void randomizeMods() {
    ballMass = random(1.0, 3.5);
    gravity = random(6.0, 12.0);
    basketHeight = random(2.7, 3.7);
    description = String.format("ball mass: %d\ngravity: %d\nbasket height: %d", ballMass, gravity, basketHeight);
  }
  
  public void applyMods() { 
    for (Player player: players) {
      player.arm.armLength = armLength;
    }
    for (Basket basket: baskets) { 
      basket.h = basketHeight;
    }
    ball.mass = ballMass;
  }
  
  public String toString() {
    return description;
  }
}
