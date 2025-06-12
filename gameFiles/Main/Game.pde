import fisica.*;

class Game {
  public int[] score;
  private Modification mod;

  public Game(FWorld world) {
    score = new int[2];
    mod = new Modification(world);
  }
  
  public void reset() {
    mod.randomizeMods();
    mod.applyMods();
  }
  
  public void score(int team) {
    if (team == 0) {
      score[0]++;
    } else if (team == 1) {
      score[1]++;
    }
  }
}
