import ddf.minim.*;

Minim minim;
AudioPlayer bgMusic;

MenuOption header;
MenuOption option1;
MenuOption option2;
MenuOption option3;
Paddle paddleP1;
Paddle paddleP2;
Paddle paddleAI;
Ball ball;

ArrayList<Brick> bricks = new ArrayList<Brick>();

boolean inGame = false;
boolean gamePaused = false;
int tempOption;
int option = 0;

void setup()
{
  size(1080, 650);
  frameRate(60);
  smooth();

  minim = new Minim(this);

  bgMusic = minim.loadFile("background.mp3");
  bgMusic.loop();
  bgMusic.setGain(-10.00);

  header = new MenuOption("BREAKOUTPONG", width * 0.5f, height * 0.1f, width - (width * 0.6f), 100);
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

  if (key >= '0' && key <= '3' && inGame == false)
  {
    option = key - '0';
  }//End if

  if ((inGame == true) && (key == ENTER))
  {
    gamePaused = true;
    tempOption = option;
    option = 4;
  }
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

    header.drawOption();
    header.textAnimation();
    option1.drawOption();
    if (option1.hoverOver())
    {
      option1.textAnimation();
      if (mousePressed)
      {
        option = 1;
      }
    }
    option2.drawOption();
    if (option2.hoverOver())
    {
      option2.textAnimation();
      if (mousePressed)
      {
        option = 2;
      }
    }
    option3.drawOption();
    if (option3.hoverOver())
    {
      option3.textAnimation();
      if (mousePressed)
      {
        option = 3;
      }
    }

    for (int i = 0; i < bgMusic.bufferSize() - 1; i++)
    {
      line(map(i, 0, bgMusic.bufferSize(), 0, width), 
        height - bgMusic.mix.get(i)*100, 
        map(i + 1, 0, bgMusic.bufferSize(), 0, width), 
        height - bgMusic.mix.get(i+1));
    }

    ball.score1 = ball.score2 = ball.score3 = 0;
    ball.lives = 3;

    for (int i = bricks.size() - 1; i >= 0; i --)
    {
      Brick b = bricks.get(i);
      b.hitDetection = false;
    }

    break;

  case 1:

    inGame = true;

    if (gamePaused == false)
    {
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
    }
    break;
  case 2:

    inGame = true;

    if (gamePaused == false)
    {
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
    }
    break;
  case 3:

    inGame = true;

    if (gamePaused == false)
    {
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

      if (ball.lives == 0 || ball.score3 >= (10 * bricks.size() - 1))
      {
        option = 0;
      }
    }
    break;

  case 4:

    textSize(32);
    textAlign(CENTER);
    fill(0, 255, 0);
    text("Game Paused", width * 0.5f, height * 0.1f);
    fill(255);
    text("Pause Music: [P]", width * 0.5f, height * 0.3f);
    text("Resume Music: [R]", width * 0.5f, height * 0.5f);
    text("Return to Game: [G]", width * 0.5f, height * 0.7f);
    text("Return to Menu: [M]", width * 0.5f, height * 0.9f);

    if (gamePaused == true)
    {
      if (key == 'p' || key == 'P')
      {
        if (bgMusic.isPlaying())
        {
          bgMusic.pause();
        }
      }
      if (key == 'r' || key == 'R')
      {
        if (bgMusic.isPlaying() == false)
        {
          bgMusic.loop();
        }
      }
      if (key == 'm' || key == 'M')
      {
        gamePaused = false;
        option = 0;
      }
      if (key == 'g' || key == 'G')
      {
        gamePaused = false;
        option = tempOption;
      }
    }
    break;

  default:
    option = 0;
  }
}