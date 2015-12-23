MenuOption option1;
MenuOption option2;
Paddle paddleP1;
Paddle paddleP2;
Paddle paddleAI;
Ball ball;

int option = 0;

void setup()
{
  size(1080, 650);
  option1 = new MenuOption("1 Player", width * 0.5f, height * 0.3f, width - (width * 0.6f), 100);
  option2 = new MenuOption("2 Player", width * 0.5f, height * 0.5f, width - (width * 0.6f), 100);
  paddleP1 = new Paddle(width * 0.5f, height * 0.9f, false);
  paddleP2 = new Paddle(width * 0.5f, height * 0.1f, false);
  paddleAI = new Paddle(width * 0.5f, height * 0.1f, true);
  ball = new Ball();
}

boolean[] keys = new boolean[512];

void keyPressed()
{
  keys[keyCode] = true;

  if (key >= '0' && key <='3')
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
    option1.drawOption();
    option2.drawOption();

    break;

  case 1:

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
    text("Player 2", width * 0.85f, height * 0.4f);
    text(ball.score2, width * 0.85, height * 0.5f);

    break;
  case 2:

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

    break;
  }
}