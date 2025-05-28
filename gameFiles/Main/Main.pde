import fisica.*;

FWorld world;
void setup() {
  size(1300, 600);
  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0, 2500);
  
  Ball ball = new Ball(new PVector(150, 150), 1.0, 9.8, 20);
  Player player = new Player(new PVector(400, 500), 5.0, 0, 80, 20);
  FBox floor = new FBox(width, 30);
  floor.setStatic(true);
  floor.setPosition(width / 2, height - 15);
  world.add(floor);
  world.add(ball.object);
  world.add(player.object);
}

void draw() {
  background(150, 150, 255);
  world.step();
  world.draw();
}
