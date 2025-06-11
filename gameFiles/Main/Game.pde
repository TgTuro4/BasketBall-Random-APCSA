class Game {
  int[] score;
  Player[] players;
  Basket[] baskets;
  Ball ball;
  Setting setting;
  Modification mod;
  
  public Game(Player player, Player player1, Player player2, Player player3, Ball ball) {
    score = new int[2];
    players = new Player[]{player, player1, player2, player3};
    mod = new Modification(players, ball);
  }
  
  void reset() {
    mod.randomizeMods();
    mod.applyMods();
  }
  
  void score(int team) {
    if (team == 0) {
      score[0]++;
    } else if (team == 1) {
      score[1]++;
    }
  }
}
