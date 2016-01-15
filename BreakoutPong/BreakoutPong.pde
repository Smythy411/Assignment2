MenuOption option1;
MenuOption option2;
MenuOption option3;
Paddle paddleP1;
Paddle paddleP2;
Paddle paddleAI;
Ball ball;
ArrayList<Brick> bricks = new ArrayList<Brick>();

boolean inGame = false;
int option = 0;

void setup()
{
  size(1080, 650);
  frameRate(60);
  smooth();
  option1 = new MenuOption("1 Player Pong", width * 0.5f, height * 0.3f, width - (width * 0.6f), 100);
  option2 = new MenuOption("2 Player Pong", width * 0.5f, height * 0.5f, width - (width * 0.6f), 100);
  option3 = new MenuOption("Breakout", width * 0.5f, height * 0.7f, width - (width * 0.6f), 100);
  paddleP1 = new Paddle(width * 0.5f, height * 0.9f, false);
  paddleP2 = new Paddle(width * 0.5f, height * 0.1f, false);
  paddleAI = new Paddle(width * 0.5f, height * 0.1f, true);
  ball = new Ball();

  for (float j = height * 0.2f; j < height * 0.4f; j += 20)
  {
    for (float i = width * 0.3f; i < width * 0.7f; i += 36)
    {
      Brick brick = new Brick(i, j, 36, 20);
      bricks.add(brick);
    }
  }
}

boolean[] keys = new boolean[512];

void keyPressed()
{
  keys[keyCode] = true;

  if (key >= '0' && key <='3' && inGame == false)
  {
    option = key - '0';
  }//End if
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

  switch (option)
  {
  case 0:

    inGame = false;

    option1.drawOption();
    option2.drawOption();
    option3.drawOption();

    ball.score1 = ball.score2 = ball.score3 = 0;
    ball.lives = 3;

    break;

  case 1:

    inGame = true;

    paddleP1.update('A', 'D');
    paddleP1.render();

    paddleAI.update('J', 'L');
    paddleAI.render();

    ball.update();
    ball.render();

    textSize(32);
    textAlign(CENTER);
    text("Player 1", width * 0.15f, height * 0.4f);
    text(ball.score1, width * 0.15, height * 0.5f);
    text("Computer", width * 0.85f, height * 0.4f);
    text(ball.score2, width * 0.85, height * 0.5f);

    if (ball.score1 == 10 || ball.score2 == 10)
    {
      option = 0;
    }

    break;
  case 2:

    inGame = true;

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

    if (ball.score1 == 10 || ball.score2 == 10)
    {
      option = 0;
    }

    break;
  case 3:

    paddleP1.update('A', 'D');
    paddleP1.render();

    ball.update();
    ball.render();

    for (int i = bricks.size() - 1; i >= 0; i --)
    {
      Brick b = bricks.get(i);
      if (b.hitDetection == false)
      {
        b.render();
      }
    }

    textSize(32);
    textAlign(CENTER);
    text("Player 1", width * 0.15f, height * 0.4f);
    text(ball.score3, width * 0.15, height * 0.5f);
    text("Lives", width * 0.85f, height * 0.4f);
    text(ball.lives, width * 0.85, height * 0.5f);
    
    if (ball.lives == 0 || ball.score3 == (10 * bricks.size() - 1))
    {
      option = 0;
    }

    break;
  default:
    option = 0;
  }
}