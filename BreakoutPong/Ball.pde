class Ball extends GameObject
{
  float ballRadius;
  float dirX, dirY;
  int score1, score2, score3;
  int lives;

  Ball()
  {
    super(width * 0.5f, height * 0.5f, 15, 15);
    this.ballRadius = this.w / 2;
    this.dirX = super.speed;
    this.dirY = this.dirX;
    this.score1 = this.score2 = this.score3 = 0;
    this.lives = 3;
  }

  void update()
  {
    this.x += dirX;
    this.y += dirY;
    if ((this.x > ((width * 0.7f) - ballRadius)) || (this.x < (width * 0.3f) + ballRadius))
    {
      this.dirX = - dirX;
    }
    if (this.y < ballRadius)
    {
      this.y = height / 2;
      score1 ++;
    } else if (this.y > (height - ballRadius) && (option == 1 || option == 2))
    {
      this.y = height / 2;
      score2 ++;
    } else if (this.y > (height - ballRadius) && option == 3)
    {
      this.y = height / 2;
      lives --;
    }
    if (collision())
    {
      this.dirY = - dirY;
    }
  }

  boolean collision()
  {
    boolean value = false;

    if (((this.y >= paddleP1.y) && (this.y <= paddleP1.y + paddleP1.h))
      && ((this.x >= paddleP1.x) && (this.x <= paddleP1.x + paddleP1.w)))
    {
      value = true;
    }

    if (option == 1)
    {
      if (((this.y >= paddleAI.y) && (this.y <= paddleAI.y + paddleAI.h))
        && ((this.x >= paddleAI.x) && (this.x <= paddleAI.x + paddleAI.w)))
      {
        value = true;
      }
    }
    if (option == 2)
    {
      if (((this.y >= paddleP2.y) && (this.y <= paddleP2.y + paddleP2.h))
        && ((this.x >= paddleP2.x) && (this.x <= paddleP2.x + paddleP2.w)))
      {
        value = true;
      }
    }
    if (option == 3)
    {
      for (int i = 0; i < bricks.size(); i++)
      {
        if (((this.y >= bricks.get(i).y) && (this.y <= bricks.get(i).y + bricks.get(i).h))
          && ((this.x >= bricks.get(i).x) && (this.x <= bricks.get(i).x + bricks.get(i).w))
          && (bricks.get(i).hitDetection == false))
        {
          value = true;
          bricks.get(i).hitDetection = true;
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

    ellipse(this.x, this.y, this.w, this.h);
  }
}