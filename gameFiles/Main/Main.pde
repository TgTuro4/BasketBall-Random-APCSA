import fisica.*;

FWorld world;
Game game;
Player[] players = new Player[4];
Ball ball;
public boolean[] keyTracker = new boolean[2];
FBox floor;
Basket leftBasket, rightBasket;
Setting setting;
PVector leftPos, leftTarget;
PVector rightPos, rightTarget;
float heightChanger = 0;
int cur;

void setup() {
  size(1200, 800);
  Fisica.init(this);

  world = new FWorld();
  world.setGravity(0, 1000);

  game = new Game(players, world);
  
  setting = new Setting("../Images/courtBackground.png");
  
  floor = new FBox(width, 100);
  floor.setPosition(width/2, height - 100);
  floor.setStatic(true);
  floor.setFriction(0.5);
  fill(0,200,200);
  floor.setRestitution(0);
  floor.setNoStroke();
  floor.setGroupIndex(0);
  floor.setGrabbable(false);
  world.add(floor);
  creation();
  world.setEdges();
  world.top.setGroupIndex(-1);
}

void creation() {
  ball = new Ball(new PVector(width/2, 100), 20.0);
  world.add(ball.object);

  // Define player positions and teams
  PVector[] positions = {
    new PVector(width/1.2, height-300),
    new PVector(width/1.4, height-300),
    new PVector(width - width/1.2, height-300),
    new PVector(width - width/1.4, height-300)
  };
  int[] teams = {1, 1, 0, 0};

  for (int i = 0; i < 4; i++) {
    players[i] = new Player(positions[i], 60, 120, floor, teams[i], ball);
    world.add(players[i].object);
    world.add(players[i].arm.object);
    world.add(players[i].arm.hand);
    players[i].jointAddition(world);
  }
  
  PVector leftPos = new PVector(0,-600 + heightChanger);
  PVector rightPos = new PVector(width, -600 + heightChanger);
  leftBasket = new Basket(600 + heightChanger, false);
  rightBasket = new Basket(600 + heightChanger, true);
  leftTarget = new PVector(leftPos.x, leftPos.y + 70);
  rightTarget = new PVector(rightPos.x, rightPos.y + 70);

  game.reset();
}

void reset() {
  world.remove(world.left); world.remove(world.right); world.remove(world.top); world.remove(world.bottom);
  world.remove(ball.object);
  for (Player selectedPlayer : players) {
    world.remove(selectedPlayer.arm.hand);
    world.remove(selectedPlayer.arm.object);
    world.remove(selectedPlayer.object);
  }
  creation();
  world.setEdges();
  world.remove(world.top);

  cur = millis();
}


void checkBasket() {
  int returnVal = -1;
  if (ball.pos.dist(leftBasket.position) < 23 && ball.object.getVelocityY() > 0) {
    println("right scored");
    returnVal = 1;
  }
  if (ball.pos.dist(rightBasket.position) < 23 && ball.object.getVelocityY() > 0) {
    println("left scored");
    returnVal = 0;
  }
  if (returnVal != -1) {
    reset();
  }
  game.score(returnVal);
}

void keyPressed() {
  if (keyCode == 'w' || keyCode == 'W') {
    keyTracker[0] = true;
  }
  else if (keyCode == UP) {
    keyTracker[1] = true;
  }
}

void keyReleased() {
  if (keyCode == 'w' || keyCode == 'W') {
    keyTracker[0] = false;
    players[2].shoot(rightTarget);
    players[3].shoot(rightTarget);
  }
  else if (keyCode == UP) {
    keyTracker[1] = false; 
    players[0].shoot(leftTarget);
    players[1].shoot(leftTarget);
  }
}

void draw() {
  setting.draw();
  world.step();

  for (Player player : players) {
    player.updateObject();
  }
  ball.updateObject();
  checkBasket();
  fill(150, 150, 150, 100);
  rectMode(CENTER);

  for (Player player : players) {
    player.draw();
  }
  ball.draw();
  leftBasket.draw();
  rightBasket.draw();
  
  fill(255);
  textSize(32);
  textAlign(LEFT, TOP);
  text("Score: " + game.score[0] + " - " + game.score[1], 10, 10);
  text("Active Modifications: " + game.mod, 10, 40);

  if (millis() - cur < 3000) {
    background(0, 0, 0);
    fill(255, 0, 0, 100);
    textSize(64);
    textAlign(CENTER, CENTER);
    text("Score: " + game.score[0] + " - " + game.score[1], width/2, height/2);
  }
}
