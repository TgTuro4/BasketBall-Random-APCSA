import fisica.*;


FWorld world;
Player player;
Ball ball;

void setup() {
  size(800, 600);
  Fisica.init(this);

  world = new FWorld();
  world.setGravity(0, 1000);
  
  FBox floor = new FBox(width, 40);
  floor.setPosition(width/2, height - 20);
  floor.setStatic(true);
  //floor.setFriction(0.3);
  fill(0,200,200);
  floor.setRestitution(0.4);
  floor.setNoStroke();
  world.add(floor);

  player = new Player(new PVector(width/2, height/2), 5.0, 9.8, 60, 120);
  world.add(player.object);
  world.add(player.arm.object);
  player.armJointAddition(world);
  
  ball = new Ball(new PVector(100, 100), 1.0, 9.8, 20);
  world.add(ball.object);
}

void draw() {
  background(255);
  world.step();
  player.updateObject();
  ball.updateObject();
  fill(150, 150, 150, 100);
  rectMode(CORNER);
  rect(0, height-40, width, 40);
  rectMode(CENTER);
  player.draw();
  // player.arm.draw();
  ball.draw();
}
