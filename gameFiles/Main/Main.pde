import fisica.*;

FWorld world;
Player player, player2;
Ball ball;
public boolean[] keyTracker = new boolean[2];
FBox floor;

void setup() {
  size(800, 600);
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

  player = new Player(new PVector(width/1.4, height/1.3), 5.0, 9.8, 60, 120, floor, 1);
  world.add(player.object);
  world.add(player.arm.object);
  player.jointAddition(world);
  
  player2 = new Player(new PVector(width/2, height/1.3), 5.0, 9.8, 60, 120, floor, 0);
  world.add(player2.object);
  world.add(player2.arm.object);
  player2.jointAddition(world);
  
  ball = new Ball(new PVector(100, 100), 1.0, 9.8, 20);
  world.add(ball.object);
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
  }
  else if (keyCode == UP || keyCode == UP) {
    keyTracker[1] = false; 
  }
}

void draw() {
  background(255);
  world.step();
  player.updateObject();
  player2.updateObject();
  ball.updateObject();
  fill(150, 150, 150, 100);
  rectMode(CORNER);
  rect(0, height-40, width, 40);
  rectMode(CENTER);
  player.draw();
  player.arm.draw();
  player2.draw();
  player2.arm.draw();
  ball.draw();
}
