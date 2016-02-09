class MenuOption extends GameObject
{
  String optionText;
  boolean sizeConstraint;
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
    this.sizeConstraint = false;
    this.textSize = 32;
  }

  void textAnimation()
  {
    if (frameCount % 1 == 0 && this.sizeConstraint == false)
    {
      this.textSize += 0.5f;
      if (this.textSize >= 35)
      {
        this.sizeConstraint = true;
      }
    }
    if (frameCount % 1 == 0 && this.sizeConstraint == true)
    {
      this.textSize -= 0.5f;
      if (this.textSize <= 30)
      {
        this.sizeConstraint = false;
      }
    }
  }

  boolean hoverOver()
  {
    if ((mouseX > (width * 0.4f) && mouseX < width * 0.6f)
    && (mouseY < this.y) && (mouseY > this.y - this.h))
    {
      return true;
    }
    else
    {
      return false;
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