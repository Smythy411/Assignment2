class MenuOption extends GameObject
{
  String optionText;
  float textSize;
  MenuOption()
  {
    super(width * 0.5f, height * 0.1f, width - (width * 0.6f), 100);
  }

  MenuOption(String oText, float xPos, float yPos, float var_width, float var_height)
  {
    this.optionText = oText;
    this.x = xPos;
    this.y = yPos;
    this.w = var_width;
    this.h = var_height;
    this.textSize = 32;
  }

void textAnimation()
{
  if (frameCount % 2 == 0 && sizeConstraint == false)
  {
    this.textSize += 0.5f;
    if (this.textSize >= 35)
    {
      sizeConstraint = true;
    }
  }
  if (frameCount % 2 == 0 && sizeConstraint == true)
  {
    this.textSize -= 0.5f;
    if (this.textSize <= 30)
    {
      sizeConstraint = false;
    }
  }
  if (frameCount % 10 == 0)
  {
    fill(color(0, 255, 255));
  }
}

  void drawOption()
  {
    fill(255, 0, 0);
    textSize(this.textSize);
    textAlign(CENTER);
    text(optionText, this.x, this.y);
  }
}