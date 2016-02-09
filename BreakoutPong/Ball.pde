class Ball extends GameObject
{
  //The ball object handles next to all the collision 
  //detection and, as a result, has the most code of all the objects
  PVector location;
  PVector velocity;
  float ballRadius;
  float dirX, dirY;
  float theta;
  float collisionX;
  float baseSpeed;
  int score1, score2, score3;
  int lives;
  boolean minusCos, minusSin;
  AudioSample brickBreak, paddleHit, lifeLost;

  //Default Ball constructor
  Ball()
  {
    super(width * 0.5f, height * 0.5f, 15, 15);
    this.ballRadius = this.w / 2;
    this.dirX = super.speed;
    this.dirY = this.dirX;
    this.theta = radians(180.0f);
    this.collisionX = 0;
    this.baseSpeed = this.speed;
    this.score1 = this.score2 = this.score3 = 0;
    this.lives = 3;
    this.minusCos = true;
    this.minusSin = false;
    location = new PVector(this.x, this.y);
    velocity = new PVector(this.dirX, this.dirY);

    //Constructing Minim objects for sound effects
    brickBreak = minim.loadSample("brickBreak.mp3");
    paddleHit = minim.loadSample("paddleHit.wav");
    lifeLost = minim.loadSample("lifeLost.mp3");
  }

  //The update() method for the ball updates its
  //position on the screen
  void update()
  {
    //The following code handles which direction
    //the ball is travelling
    if (minusCos == true && minusSin == false)
    {
      velocity.x = sin(theta);
      velocity.y = - cos(theta);
    }//End if
    if (minusCos == false && minusSin == false)
    {
      velocity.x = sin(theta);
      velocity.y = cos(theta);
    }//End if
    if (minusSin == true && minusCos == false)
    {
      velocity.x = -sin(theta);
      velocity.y = cos(theta);
    }//End if
    if (minusCos == true && minusSin == true)
    {
      velocity.x = -sin(theta);
      velocity.y = -cos(theta);
    }//End if

    velocity.mult(speed);
    location.add(velocity);

    //The following code ensures boundary detecion/collison
    //and will preform the appropriate situation (bounce ball,
    //remove live, increase score, etc.)
    if ((location.x > ((width * 0.7f) - ballRadius)) || (location.x < (width * 0.3f) + ballRadius))
    {
      minusSin = !minusSin;
    }//End if
    if (location.y < ballRadius)
    {
      if (option == 3)
      {
        minusCos = !minusCos;
      }//End inner if
      else
      {
        location.y = height / 2;
        score1 ++;
        this.speed = baseSpeed;
      }//End inner else
    }//End if
    else if (location.y > (height - ballRadius) && (option == 1 || option == 2))
    {
      location.y = height / 2;
      score2 ++;
      this.speed = baseSpeed;
    }//End else if
    else if (location.y > (height - ballRadius) && (option == 3 || option == 4))
    {
      location.y = height / 2;
      lives --;
      this.speed = baseSpeed;
      lifeLost.trigger();
    }//End else if

    //The following code checks for collision and updates
    //the direction of the ball accordingly
    if (collision("PaddleP1"))
    {
      minusCos = true;
      minusSin = false;
      collisionX = map(location.x, paddleP1.x, paddleP1.x + paddleP1.w, 0, paddleP1.w);
      theta = radians(map(collisionX, 0, paddleP1.w, -45, 45));
    }//End if
    if (collision("PaddleP2"))
    {
      minusCos = true;
      minusSin = false;
      collisionX = map(location.x, paddleP2.x, paddleP2.x + paddleP2.w, 0, paddleP2.w);
      theta = radians(map(collisionX, 0, paddleP2.w, -135, -225));
    }//End if
    if (collision("PaddleAI"))
    {
      minusCos = true;
      minusSin = false;
      collisionX = map(location.x, paddleAI.x, paddleAI.x + paddleAI.w, 0, paddleAI.w);
      theta = radians(map(collisionX, 0, paddleAI.w, -135, -225));
    }//End if
    if (collision("Brick_Tops"))
    {
      minusCos = !minusCos;
    }//End if
    if (collision("Brick_Sides"))
    {
      minusSin = !minusSin;
    }//End if
  }//End update()

  //The collision() method checks if the ball has come into
  //contact with any of the paddle or brick objects
  boolean collision(String collisionObject)
  {
    boolean value = false;

    //Checking collision with Player1's paddle
    if (((location.y >= paddleP1.y) && (location.y <= paddleP1.y + paddleP1.h))
      && ((location.x >= paddleP1.x) && (location.x <= paddleP1.x + paddleP1.w))
      && (collisionObject == "PaddleP1"))
    {
      value = true;
      paddleHit.trigger();
    }//End if

    //Checking collision with Computer's paddle
    if ((option == 1) && (collisionObject == "PaddleAI"))
    {
      if (((location.y >= paddleAI.y) && (location.y <= paddleAI.y + paddleAI.h))
        && ((location.x >= paddleAI.x) && (location.x <= paddleAI.x + paddleAI.w)))
      {
        value = true;
        paddleHit.trigger();
      }//End inner if
    }//End if

    //Checking collision with Player2's paddle
    if (option == 2 && (collisionObject == "PaddleP2"))
    {
      if (((location.y >= paddleP2.y) && (location.y <= paddleP2.y + paddleP2.h))
        && ((location.x >= paddleP2.x) && (location.x <= paddleP2.x + paddleP2.w)))
      {
        value = true;
        paddleHit.trigger();
      }//End inner if
    }//End if

    //Checking collision with bricks
    if (option == 3)
    {
      for (int i = 0; i < bricks.size (); i++)
      {
        //Checking for collision with sides of bricks
        if ((collisionObject == "Brick_Sides") 
          && (location.x + ballRadius >= bricks.get(i).x) && (location.x - ballRadius <= bricks.get(i).x + bricks.get(i).w))
        {
          if ((location.y + ballRadius>= bricks.get(i).y) && (location.y  - ballRadius <= bricks.get(i).y + bricks.get(i).h))
          {
            if (bricks.get(i).hitDetection == false)
            {
              value = true;
              bricks.get(i).hitDetection = true;
              score3 += 10;

              brickBreak.trigger();
            }//End inner inner inner for if
          }//End inner inner for if
        }//End inner for if
        //Checking for collision with tops of bricks
        if (( (collisionObject == "Brick_Tops")) 
          && (location.y + ballRadius >= bricks.get(i).y) && (location.y - ballRadius <= bricks.get(i).y + bricks.get(i).h))
        {
          if ((location.x >= bricks.get(i).x) && (location.x <= bricks.get(i).x + bricks.get(i).w))
          {
            if (bricks.get(i).hitDetection == false)
            {
              value = true;
              bricks.get(i).hitDetection = true;
              score3 += 10;

              brickBreak.trigger();
            }//End inner inner inner for if
          }//End inner inner for if
        }//End inner for if
      }//End for
    }//End if
    if (value == true)
    {
      //Increases ball speed on collision
      this.speed += 0.05f;
    }//End if
    return value;
  }//End collision()

  //Renders the ball to the screen
  void render()
  {
    this.c = color(0, 255, 255);
    stroke(c);
    fill(c);
    ellipse(location.x, location.y, this.w, this.h);
  }//End render()
}//End class Ball