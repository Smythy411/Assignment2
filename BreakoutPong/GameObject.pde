//Base Class Game Object
class GameObject
{
  float x, y;
  float w, h;
  float speed = 5.0f;
  color c;
  
  GameObject()
  {
    this(width * 0.5f, height * 0.5f, 50, 15);
  }
  
  GameObject(float xPos, float yPos, float var_width, float var_height)
  {
    this.x = xPos;
    this.y = yPos;
    this.w = var_width;
    this.h = var_height;
  }
}