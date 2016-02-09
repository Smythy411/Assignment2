/*
  OOP Assignment 2 - BreakoutPong!
 Author: Eoin Smyth
 c14427202
 Date Started: 17/12/2015
 Date Finished: 09/02/2015
 */

//Imports the Minim library for manipulating sound
import ddf.minim.*;

//Declaring instances of classes
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

//ArrayList of Brick objects
ArrayList<Brick> bricks = new ArrayList<Brick>();

//Declaring global variables
boolean inGame = false;
boolean gamePaused = false;
int tempOption;
int option = 0;

void setup()
{
  size(1080, 650);
  frameRate(60);
  smooth();

  //Constructing Minim objects
  minim = new Minim(this);
  bgMusic = minim.loadFile("background.mp3");
  bgMusic.loop();
  bgMusic.setGain(-10.00);

  //Constructing the Game Objects
  header = new MenuOption("BREAKOUTPONG", width * 0.5f, height * 0.1f, width - (width * 0.6f), 100);
  option1 = new MenuOption("1 Player Pong", width * 0.5f, height * 0.3f, width - (width * 0.6f), 100);
  option2 = new MenuOption("2 Player Pong", width * 0.5f, height * 0.5f, width - (width * 0.6f), 100);
  option3 = new MenuOption("Breakout", width * 0.5f, height * 0.7f, width - (width * 0.6f), 100);
  paddleP1 = new Paddle(width * 0.5f, height * 0.9f, false);
  paddleP2 = new Paddle(width * 0.5f, height * 0.1f, false);
  paddleAI = new Paddle(width * 0.5f, height * 0.1f, true);
  ball = new Ball();

  //Constructing Brick Objects.
  //Constructing them here to avoid having to load them in
  //every time Breakout is chosen
  for (float j = height * 0.2f; j < height * 0.4f; j += 20)
  {
    for (float i = width * 0.3f; i < width * 0.7f; i += 36)
    {
      Brick brick = new Brick(i, j, 36, 20);
      bricks.add(brick);
    }//End inner join
  }//End outer join
}//End setup()

//The following deals with key presses
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
  }//End if
}//End keyPressed()

void keyReleased()
{
  keys[keyCode] = false;
}//End keyReleased()


void draw()
{
  background(0);

  //Borders
  stroke(0, 0, 255);
  line(width * 0.3f, 0, width * 0.3f, height);
  line(width * 0.7f, 0, width * 0.7f, height);

  switch (option)
  {
  case 0:  //Menu

    inGame = false;

    //The following calls the MenuOptions
    //and their methods.
    //Menu options can be selected by either
    //mouse click or keys
    header.drawOption();
    header.textAnimation();
    option1.drawOption();
    if (option1.hoverOver())
    {
      option1.textAnimation();
      if (mousePressed)
      {
        option = 1;
      }//End inner if
    }//End if
    option2.drawOption();
    if (option2.hoverOver())
    {
      option2.textAnimation();
      if (mousePressed)
      {
        option = 2;
      }//End inner if
    }//End if
    option3.drawOption();
    if (option3.hoverOver())
    {
      option3.textAnimation();
      if (mousePressed)
      {
        option = 3;
      }//End inner if
    }//End if

    //The following draws a simple Wavform on the menu
    for (int i = 0; i < bgMusic.bufferSize() - 1; i++)
    {
      line(map(i, 0, bgMusic.bufferSize(), 0, width), 
        height - bgMusic.mix.get(i)*100, 
        map(i + 1, 0, bgMusic.bufferSize(), 0, width), 
        height);
    }//End for

    //Initialising variables
    ball.score1 = ball.score2 = ball.score3 = 0;
    ball.lives = 3;

    //Re-initialises the bricks hit detection,
    //ensuring that they are all reloaded
    //the next time the player decides to play Breakout
    for (int i = bricks.size() - 1; i >= 0; i --)
    {
      Brick b = bricks.get(i);
      b.hitDetection = false;
    }//End for

    break;

  case 1:  //1 Player Pong

    inGame = true;

    if (gamePaused == false)
    {
      //Player1's paddle
      paddleP1.update('A', 'D');
      paddleP1.render();

      //Computer's paddle
      paddleAI.update('J', 'L');
      paddleAI.render();

      //Ball
      ball.update();
      ball.render();

      //The following text displayes the scores
      textSize(32);
      textAlign(CENTER);
      text("Player 1", width * 0.15f, height * 0.4f);
      text(ball.score1, width * 0.15, height * 0.5f);
      text("Computer", width * 0.85f, height * 0.4f);
      text(ball.score2, width * 0.85, height * 0.5f);

      //Returns to menu if the game is over
      if (ball.score1 == 5 || ball.score2 == 5)
      {
        option = 0;
      }//End if
    }//End gamePaused if
    break;
  case 2:  //2 Player Pong

    inGame = true;

    if (gamePaused == false)
    {
      //Player1's paddle
      paddleP1.update('A', 'D');
      paddleP1.render();

      //Player2's paddle
      paddleP2.update('J', 'L');
      paddleP2.render();

      //Ball
      ball.update();
      ball.render();

      //The following text displayes the scores
      textSize(32);
      textAlign(CENTER);
      text("Player 1", width * 0.15f, height * 0.4f);
      text(ball.score1, width * 0.15, height * 0.5f);
      text("Player 2", width * 0.85f, height * 0.4f);
      text(ball.score2, width * 0.85, height * 0.5f);

      //Returns to menu if the game is over
      if (ball.score1 == 5 || ball.score2 == 5)
      {
        option = 0;
      }//End if
    }// End gamePaused if
    break;
  case 3:  //Breakout

    inGame = true;

    if (gamePaused == false)
    {
      //Player1's Paddle
      paddleP1.update('A', 'D');
      paddleP1.render();
    
      //Ball
      ball.update();
      ball.render();

      //Renders bricks to the screen
      for (int i = bricks.size() - 1; i >= 0; i --)
      {
        Brick b = bricks.get(i);
        if (b.hitDetection == false)
        {
          b.render();
        }
      }

      //The following text displayes the scores and lives
      textSize(32);
      textAlign(CENTER);
      text("Player 1", width * 0.15f, height * 0.4f);
      text(ball.score3, width * 0.15, height * 0.5f);
      text("Lives", width * 0.85f, height * 0.4f);
      text(ball.lives, width * 0.85, height * 0.5f);

      //Returns to menu if the game is over
      if (ball.lives == 0 || ball.score3 >= (10 * bricks.size() - 1))
      {
        option = 0;
      }//End if
    }//End gamePaused if
    break;

  case 4:  //Pause Menu

    //The following text displays the pause menu's options
    textSize(32);
    textAlign(CENTER);
    fill(0, 255, 0);
    text("Game Paused", width * 0.5f, height * 0.1f);
    fill(255);
    text("Pause Music: [P]", width * 0.5f, height * 0.3f);
    text("Resume Music: [R]", width * 0.5f, height * 0.5f);
    text("Return to Game: [G]", width * 0.5f, height * 0.7f);
    text("Return to Menu: [M]", width * 0.5f, height * 0.9f);

    //The following checks for key presses and
    //carries out the necessary option
    if (gamePaused == true)
    {
      if (key == 'p' || key == 'P')
      {
        if (bgMusic.isPlaying())
        {
          bgMusic.pause();
        }//End inner inner if
      }//End inner if
      if (key == 'r' || key == 'R')
      {
        if (bgMusic.isPlaying() == false)
        {
          bgMusic.loop();
        }//End inner inner if
      }//End inner if
      if (key == 'm' || key == 'M')
      {
        gamePaused = false;
        option = 0;
      }//End inner if
      if (key == 'g' || key == 'G')
      {
        gamePaused = false;
        option = tempOption;
      }//End inner if
    }//End if
    break;

  default:
    option = 0;
  }//End switch
}//End draw()