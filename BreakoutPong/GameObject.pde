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
  
  GameObject(float x, float y, float w, float h)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
}