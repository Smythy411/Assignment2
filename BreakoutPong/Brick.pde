class Brick extends GameObject
{

  boolean hitDetection = false;

  Brick()
  {
    super(width * 0.3f, height * 0.2f, 40, 20);
  }

  Brick(float xPos, float yPos, int var_width, int var_height)
  {
    this.x = xPos;
    this.y = yPos;
    this.w = var_width;
    this.h = var_height;
  }

  void render()
  {
    stroke(0, 255, 0);
    fill(255);

    rect(this.x, this.y, w, h);
  }
}