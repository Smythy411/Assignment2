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
      this.dirY = - dirY;
    }
  }

  void render()
  {

    this.c = color(0, 255, 255);
    stroke(c);
    fill(c);

    ellipse(this.x, this.y, this.w, this.h);
  }
}