class MenuOption extends GameObject
{
  String optionText;
  boolean sizeConstraint;
  float textSize;
  
  //Default MenuOption constructor
  MenuOption()
  {
    super(width * 0.5f, height * 0.1f, width - (width * 0.6f), 100);
  }//End MenuOption()

  //Paramaterised MenuOption constructor
  MenuOption(String oText, float xPos, float yPos, float var_width, float var_height)
  {
    this.optionText = oText;
    this.x = xPos;
    this.y = yPos;
    this.w = var_width;
    this.h = var_height;
    this.sizeConstraint = false;
    this.textSize = 32;
  }//End MenuOption()

  //textAnimation() Provides a simple animation for
  //the menu options
  void textAnimation()
  {
    //Sets the text size to increase to a given amount
    if (frameCount % 1 == 0 && this.sizeConstraint == false)
    {
      this.textSize += 0.2f;
      if (this.textSize >= 35)
      {
        this.sizeConstraint = true;
      }//End inner if
    }//End if
    //Sets the text size to decrease to a given amount
    if (frameCount % 1 == 0 && this.sizeConstraint == true)
    {
      this.textSize -= 0.5f;
      if (this.textSize <= 30)
      {
        this.sizeConstraint = false;
      }//End inner if
    }//End if
  }// End textAnimation()

  //hoverOver() checks to see if the mouse
  //is over one of the menu options
  boolean hoverOver()
  {
    if ((mouseX > (width * 0.4f) && mouseX < width * 0.6f)
    && (mouseY < this.y) && (mouseY > this.y - this.h))
    {
      return true;
    }//End if
    else
    {
      return false;
    }//End else
  }//End hoverOver()

  //drawOption() draws the menu option to the screen
  void drawOption()
  {
    fill(255, 0, 0);
    textSize(this.textSize);
    textAlign(CENTER);
    text(optionText, this.x, this.y);
  }//End drawOption()
}//End class MenuOption