class Game {
  int round;
  int[] score;
  Player[] players;
  Setting setting;
  Ball ball;
  AnimationHandler animHandler;
  Modification mod;
  
  void tick() {
    for (Player p: players) {
      p.updateObject();
      p.draw();
    }
    ball.updateObject();
    ball.draw();
  }

  void generateNewRound() {
    mod.randomizeMods();
  }

  void reset() {
    generateNewRound();
  }
  void score() {
  }
}
