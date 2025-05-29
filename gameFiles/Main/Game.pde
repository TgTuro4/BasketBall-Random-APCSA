class Game {
  int round;
  int[] score;
  Player[] players;
  Setting setting;
  Ball ball;
  AnimationHandler animHandler;
  Modification mod;

  final HashMap<String, String> bgrImgs = new HashMap<>();
  // add background images to hashmap...
  // hashMap.put("","");

  void tick() {
    for (Player p: players) {
      p.updateObject();
      p.draw();
    }
    ball.updateObject();
    ball.draw();
  }

  void generateNewRound() {
    String randBgr = bgrImgs.values().stream().skip((int) (random(bgrImgs.size()))).findFirst().orElse(null);
    setting.applySetting(randBgr);
    setting.draw();
    mod.randomizeMods();
  }

  void reset() {
    generateNewRound();
  }
  void score() {
  }
}
