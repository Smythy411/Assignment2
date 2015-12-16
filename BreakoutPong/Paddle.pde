class Paddle extends GameObject
{

  Paddle()
  {
    super(width*0.5f, height * 0.9f, 50, 15);
  }
  
  Paddle(float xPos, float yPos)
  {
    this.x = xPos;
    this.y = yPos;
  }

  void update(char left, char right)
  {
    if (keys[left])
    {
      x = constrain(x - speed, width * 0.3, width * 0.7);
    }
    if (keys[right])
    {
      x = constrain(x + speed, width * 0.3, (width * 0.7) - this.w);
    }
  }

  void render()
  {
    c = (color(255, 0, 255));
    stroke(c);
    rect(x, y, w, h, 10);
  }
}