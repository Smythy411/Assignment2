class Ball extends GameObject
{
  PVector location;
  PVector velocity;
  float ballRadius;
  float dirX, dirY;
  float theta;
  float collisionX;
  int brickCollision;
  int score1, score2, score3;
  int lives;
  boolean minusCos;

  Ball()
  {
    super(width * 0.5f, height * 0.5f, 15, 15);
    this.ballRadius = this.w / 2;
    this.dirX = super.speed;
    this.dirY = this.dirX;
    this.theta = radians(180.0f);
    this.collisionX = 0;
    this.brickCollision = 0;
    this.score1 = this.score2 = this.score3 = 0;
    this.lives = 3;
    this.minusCos = true;
    location = new PVector(this.x, this.y);
    velocity = new PVector(this.dirX, this.dirY);
  }

  void update()
  {
    if (minusCos == true)
    {
      velocity.x = sin(theta);
      velocity.y = - cos(theta);
    }
    if (minusCos == false)
    {
      velocity.x = sin(theta);
      velocity.y = cos(theta);
    }

    velocity.mult(speed);
    location.add(velocity);

    if ((location.x > ((width * 0.7f) - ballRadius)) || (location.x < (width * 0.3f) + ballRadius))
    {
      theta = -theta;
    }
    if (location.y < ballRadius)
    {
      if (option == 3)
      {
        minusCos = false;
      } else
      {
        location.y = height / 2;
        score1 ++;
      }
    } else if (location.y > (height - ballRadius) && (option == 1 || option == 2))
    {
      location.y = height / 2;
      score2 ++;
    } else if (location.y > (height - ballRadius) && option == 3)
    {
      location.y = height / 2;
      lives --;
    }

    if (collision("PaddleP1"))
    {
      minusCos = true;
      collisionX = map(location.x, paddleP1.x, paddleP1.x + paddleP1.w, 0, paddleP1.w);
      theta = radians(map(collisionX, 0, paddleP1.w, -45, 45));
    }
    if (collision("PaddleP2"))
    {
      collisionX = map(location.x, paddleP2.x, paddleP2.x + paddleP2.w, 0, paddleP2.w);
      theta = radians(map(collisionX, 0, paddleP2.w, -135, -225));
    }
    if (collision("PaddleAI"))
    {
      collisionX = map(location.x, paddleAI.x, paddleAI.x + paddleAI.w, 0, paddleAI.w);
      theta = radians(map(collisionX, 0, paddleAI.w, -135, -225));
    }
    if (collision("Brick"))
    {
      minusCos = !minusCos;
    }
  }

  boolean collision(String collisionObject)
  {
    boolean value = false;

    if (((location.y >= paddleP1.y) && (location.y <= paddleP1.y + paddleP1.h))
      && ((location.x >= paddleP1.x) && (location.x <= paddleP1.x + paddleP1.w))
      && (collisionObject == "PaddleP1"))
    {
      value = true;
    }

    if (option == 1 && (collisionObject == "PaddleAI"))
    {
      if (((location.y >= paddleAI.y) && (location.y <= paddleAI.y + paddleAI.h))
        && ((location.x >= paddleAI.x) && (location.x <= paddleAI.x + paddleAI.w)))
      {
        value = true;
      }
    }
    if (option == 2 && (collisionObject == "PaddleP2"))
    {
      if (((location.y >= paddleP2.y) && (location.y <= paddleP2.y + paddleP2.h))
        && ((location.x >= paddleP2.x) && (location.x <= paddleP2.x + paddleP2.w)))
      {
        value = true;
      }
    }
    if (option == 3 && (collisionObject == "Brick"))
    {
      for (int i = 0; i < bricks.size (); i++)
      {
        if (((location.y >= bricks.get(i).y) && (location.y <= bricks.get(i).y + bricks.get(i).h))
          && ((location.x >= bricks.get(i).x) && (location.x <= bricks.get(i).x + bricks.get(i).w))
          && (bricks.get(i).hitDetection == false))
        {
          value = true;
          bricks.get(i).hitDetection = true;
          this.brickCollision = i;
          score3 += 10;
        }
      }
    }
    return value;
  }

  void render()
  {

    this.c = color(0, 255, 255);
    stroke(c);
    fill(c);

    ellipse(location.x, location.y, this.w, this.h);
  }
}

