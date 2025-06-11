import fisica.*;


FWorld world;
Player player, player2;
Ball ball;
public boolean[] keyTracker = new boolean[2];
FBox floor;

void setup() {
  size(1000, 600); // 800 600
  Fisica.init(this);

  world = new FWorld();
  world.setGravity(0, 1000);
  
  floor = new FBox(width, 40);
  floor.setPosition(width/2, height - 20);
  floor.setStatic(true);
  floor.setFriction(0.5);
  fill(0,200,200);
  floor.setRestitution(0);
  floor.setNoStroke();
  floor.setGroupIndex(0);
  floor.setGrabbable(false);
  world.add(floor);

  ball = new Ball(new PVector(width/2, 100), 1, 20.0); // ball b4 players
  world.add(ball.object);

  player = new Player(new PVector(width/1.4, height/1.3), 5.0, 60, 120, floor, 1, ball);
  world.add(player.object);
  world.add(player.arm.object);
  world.add(player.arm.hand);
  player.jointAddition(world);
  
  player2 = new Player(new PVector(width - width/1.4, height/1.3), 5.0, 60, 120, floor, 0, ball);
  world.add(player2.object);
  world.add(player2.arm.object);
  world.add(player2.arm.hand);
  player2.jointAddition(world);
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
    player2.shoot(new PVector(200, 200));
  }
  else if (keyCode == UP || keyCode == UP) {
    keyTracker[1] = false; 
    player.shoot(new PVector(200, 200));
  }
}

void draw() {
  background(135, 135, 200);
  world.step();
  player.updateObject();
  player2.updateObject();
  ball.updateObject();
  fill(150, 150, 150, 100);
  rectMode(CORNER);
  rect(0, height-40, width, 40);
  rectMode(CENTER);
  player.draw();
  player2.draw();
  ball.draw();
}
