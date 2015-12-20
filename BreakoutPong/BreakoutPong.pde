Paddle paddleP1;
Paddle paddleP2;
Ball ball;

void setup()
{
  size(1080, 650);
  paddleP1 = new Paddle(width * 0.5f, height * 0.9f);
  paddleP2 = new Paddle(width * 0.5f, height * 0.1f);
  ball = new Ball();
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

  paddleP1.update('A', 'D');
  paddleP1.render();

  paddleP2.update('J', 'L');
  paddleP2.render();

  ball.update();
  ball.render();

  textSize(32);
  textAlign(CENTER);
  text("Player 1", width * 0.15f, height * 0.4f);
  text(ball.score1, width * 0.15, height * 0.5f);
  text("Player 2", width * 0.85f, height * 0.4f);
  text(ball.score2, width * 0.85, height * 0.5f);
}