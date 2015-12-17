class Ball extends GameObject
{
  float ballRadius;
  float dirX, dirY;

  Ball()
  {
    super(width * 0.5f, height * 0.5f, 15, 15);
    this.ballRadius = this.w / 2;
    this.dirX = super.speed;
    this.dirY = this.dirX;
  }

  void update()
  {
    this.x += dirX;
    this.y += dirY;
    if ((this.x > ((width * 0.7f) - ballRadius)) || (this.x < (width * 0.3f) + ballRadius))
    {
      this.dirX = - dirX;
    }
    if ((this.y > (height - ballRadius)) || (this.y < ballRadius))
    {
      this.y = height / 2;
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
    if (((this.y >= paddleP2.y) && (this.y <= paddleP2.y +paddleP2.h))
      && ((this.x >= paddleP2.x) && (this.x <= paddleP2.x + paddleP2.w)))
    {
      value = true;
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