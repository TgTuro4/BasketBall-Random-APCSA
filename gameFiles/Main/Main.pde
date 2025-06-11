import fisica.*;

FWorld world;
Game game;
Player player, player0, player1, player2;
Player[] players = new Player[4];
Ball ball;
public boolean[] keyTracker = new boolean[2];
FBox floor;
Basket leftBasket, rightBasket;
Setting setting;
PVector leftPos, leftTarget;
PVector rightPos, rightTarget;
float heightChanger = 0;

void setup() {
  size(1200, 800); // 800 600
  Fisica.init(this);

  world = new FWorld();
  world.setGravity(0, 1000);


  ball = new Ball(new PVector(width/2, 100), 1, 20.0); // ball b4 players
  game = new Game(players, ball);
  
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
  world.add(ball.object);

  player = new Player(new PVector(width/1.2, height-300), 5.0, 60, 120, floor, 1, ball);
  players[0] = player;
  world.add(player.object);
  world.add(player.arm.object);
  world.add(player.arm.hand);
  player.jointAddition(world);
  
  player0 = new Player(new PVector(width/1.4, height-300), 5.0, 60, 120, floor, 1, ball);
  players[1] = player0;
  world.add(player0.object);
  world.add(player0.arm.object);
  world.add(player0.arm.hand);
  player0.jointAddition(world);
  
  player1 = new Player(new PVector(width - width/1.2, height-300), 5.0, 60, 120, floor, 0, ball);
  players[2] = player1;
  world.add(player1.object);
  world.add(player1.arm.object);
  world.add(player1.arm.hand);
  player1.jointAddition(world);
  
  player2 = new Player(new PVector(width - width/1.4, height-300), 5.0, 60, 120, floor, 0, ball);
  players[3] = player2;
  world.add(player2.object);
  world.add(player2.arm.object);
  world.add(player2.arm.hand);
  player2.jointAddition(world);
  
  PVector leftPos = new PVector(0,-600 + heightChanger);
  PVector rightPos = new PVector(width, -600 + heightChanger);
  leftBasket = new Basket(600 + heightChanger, false);
  rightBasket = new Basket(600 + heightChanger, true);
  leftTarget = new PVector(leftPos.x, leftPos.y + 70);
  rightTarget = new PVector(rightPos.x, rightPos.y + 70);
  
  game.mod.applyMods();
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
    world.remove(world.left); world.remove(world.right); world.remove(world.top); world.remove(world.bottom);
    world.remove(ball.object);
    for (Player selectedPlayer : players) {
      world.remove(selectedPlayer.arm.hand);
      world.remove(selectedPlayer.arm.object);
      world.remove(selectedPlayer.object);
    }
    creation();
    world.setEdges();
  }
  game.score(returnVal);
}

void keyPressed() {
  if (keyCode == 'w' || keyCode == 'W') {
    keyTracker[0] = true;
  }
  else if (keyCode == UP || keyCode == UP) {
    keyTracker[1] = true; 
  }
}
void keyReleased() {
  if (keyCode == 'w' || keyCode == 'W') {
    keyTracker[0] = false;
    player1.shoot(rightTarget);
    player2.shoot(rightTarget);
  }
  else if (keyCode == UP || keyCode == UP) {
    keyTracker[1] = false; 
    player.shoot(leftTarget);
    player0.shoot(leftTarget);
  }
}

void draw() {
  setting.draw();
  world.step();
  player.updateObject();
  player0.updateObject();
  player1.updateObject();
  player2.updateObject();
  ball.updateObject();
  checkBasket();
  fill(150, 150, 150, 100);
  rectMode(CENTER);
  player.draw();
  player0.draw();
  player1.draw();
  player2.draw();
  ball.draw();
  leftBasket.draw();
  rightBasket.draw();
  
  fill(255);
  textSize(32);
  textAlign(LEFT, TOP);
  text("Score: " + game.score[0] + " - " + game.score[1], 10, 10);
  text("Active Modifications: " + game.mod, 10, 40);
}
