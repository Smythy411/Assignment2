class Brick extends GameObject
{

  boolean hitDetection = false;

  //Default Brick constructor
  Brick()
  {
    super(width * 0.3f, height * 0.2f, 40, 20);
  }//End Brick

  //Paramaterised Brick constructor
  Brick(float xPos, float yPos, int var_width, int var_height)
  {
    this.x = xPos;
    this.y = yPos;
    this.w = var_width;
    this.h = var_height;
  }//End Brick

  //Renders the bricks to the screen
  void render()
  {
    stroke(0, 255, 0);
    fill(255);
    rect(this.x, this.y, w, h);
  }//End render()
}//End class Brick