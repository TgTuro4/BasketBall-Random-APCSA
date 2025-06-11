class Modification {
  private float ballMass, basketHeightChanger, armLengthChanger;
  private String description;
  private Player[] players;
  private Ball ball;
  
  public Modification(Player[] players, Ball ball) {
    this.players = players;
    this.ball = ball;
    randomizeMods();
  }
  
  public void randomizeMods() {
    ballMass = random(1.0, 3.5);
    basketHeightChanger = random(-200, 200);
    armLengthChanger = random(0.6,0.8);
    description = String.format("ball mass: %f\nbasket height change: %f\n arm length: %f", ballMass, basketHeightChanger, armLengthChanger);
  }
  
  public void applyMods() { 
    for (Player player: players) {
      player.arm.armLength = player.arm.armLength * armLengthChanger;
    }
    heightChanger = basketHeightChanger;
    ball.mass = ballMass;
  }
  
  public String toString() {
    return description;
  }
}
