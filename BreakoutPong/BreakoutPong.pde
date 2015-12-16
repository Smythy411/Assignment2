Paddle paddle;

void setup()
{
  size(1080, 650);
  paddle = new Paddle();
}

boolean[] keys = new boolean[512];

void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}

void draw()
{
  background(0);
  stroke(0, 0, 255);
  line(width * 0.3f, 0, width * 0.3f, height);
  line(width * 0.7f, 0, width * 0.7f, height);
  paddle.update();
  paddle.render();
}