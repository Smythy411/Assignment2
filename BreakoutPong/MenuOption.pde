class MenuOption extends GameObject
{
  String optionText;
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
  }

  void drawOption()
  {
    fill(255, 0, 0);
    textSize(32);
    textAlign(CENTER);
    text(optionText, this.x, this.y);
  }
}