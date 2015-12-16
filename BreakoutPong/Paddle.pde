class Paddle extends GameObject
{
  
  Paddle()
  {
    super(width*0.5f, height * 0.9f, 50, 15);
  }
  
  void update()
  {
    if (keyPressed)
    {
      if (key == 'a')
      {
        x = constrain(x - speed, width * 0.3, width * 0.7);
      }
      if (key == 'd')
      {
        x = constrain(x + speed, width * 0.3, (width * 0.7) - this.w);
      }
    }
  }
  
  void render()
  {
    c = (color(255, 0, 255));
    stroke(c);
    rect(x, y, w, h, 10);
  }
}