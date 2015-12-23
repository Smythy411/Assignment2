class Paddle extends GameObject
{
  boolean AI;

  Paddle()
  {
    super(width * 0.5f, height * 0.9f, 50, 15);
  }

  Paddle(float xPos, float yPos, boolean AICheck)
  {
    this.x = xPos;
    this.y = yPos;
    this.AI = AICheck;
  }

  void update(char left, char right)
  {
    if (!AI)
    {
      if (keys[left])
      {
        x = constrain(x - speed, width * 0.3, width * 0.7);
      }
      if (keys[right])
      {
        x = constrain(x + speed, width * 0.3, (width * 0.7) - this.w);
      }
    } else
    {
      if (this.x > ball.x)
      {
        while (this.x > ball.x)
        {
          if (this.x == (width * 0.3))
          {
            break;
          }
          this.x = constrain(x - speed, width * 0.3, width * 0.7);
        }
      }
      if (this.x < ball.x)
      {
        while (this.x < ball.x - (this.w / 2))
        {
          if (this.x == (width * 0.7) - this.w)
          {
            break;
          }
          this.x = constrain(x + speed, width * 0.3, (width * 0.7) - this.w);
        }
      }
    }
  }

  void render()
  {
    c = (color(255, 0, 255));
    stroke(c);
    fill(0, 255, 0);
    rect(x, y, w, h, 10);
  }
}