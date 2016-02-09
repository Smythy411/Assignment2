class Paddle extends GameObject
{
  boolean AI;

  //Default Paddle constructor
  Paddle()
  {
    super(width * 0.5f, height * 0.9f, 50, 15);
  }

  //Paramaterised Paddle constructor
  Paddle(float xPos, float yPos, boolean AICheck)
  {
    this.x = xPos;
    this.y = yPos;
    this.AI = AICheck;
  }

  //The update method for the Paddle updates the position
  //of the paddle depending on key presses (if player controlled)
  //or by ball location (if AI controlled)
  void update(char left, char right)
  {
    //Checks to see if paddle is AI or player controlled
    if (!AI)
    {
      if (keys[left])
      {
        x = constrain(x - speed, width * 0.3, width * 0.7);
      }//End inner if
      if (keys[right])
      {
        x = constrain(x + speed, width * 0.3, (width * 0.7) - this.w);
      }//End inner if
    }//End if
    else
    {
      if (this.x > ball.location.x)
      {
        while (this.x > ball.location.x)
        {
          if (this.x == (width * 0.3))
          {
            break;
          }//End inner while if
          this.x = constrain(x - speed, width * 0.3, width * 0.7);
        }//End while
      }//End inner if
      if (this.x < ball.location.x)
      {
        while (this.x < ball.location.x - (this.w / 2))
        {
          if (this.x == (width * 0.7) - this.w)
          {
            break;
          }//End inner while if
          this.x = constrain(x + speed, width * 0.3, (width * 0.7) - this.w);
        }//End while
      }//End inner if
    }//End else
  }//End update()

  //Renders the paddle to the screen
  void render()
  {
    c = (color(255, 0, 255));
    stroke(c);
    fill(0, 255, 0);
    rect(x, y, w, h, 10);
  }//End render()
}//End class Paddle