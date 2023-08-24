
class Box
{
  double x;
  double v;
  int size;
  double mass;
  Box(double x, int size, double v, double mass)
  {
   this.x = x;
   this.v = v;
   this.size = size;
   this.mass = mass; 
  }
  
  void update()
  {
   this.x += v;
  }
  
  boolean wallHit()
  {
   return x <= 0; 
  }
  
  double bounce(Box b)
  {
    double massSum = b.mass + this.mass;
    return (this.mass - b.mass)/massSum * this.v + 2*b.mass/massSum*b.v;
  }
  
  boolean collide(Box b)
  {
    return !(this.x + this.size < b.x || this.x > b.x + b.size);
  }
  
  void show(int y)
  {
   fill(255, 0, 0);
    y -= this.size;
    rect((float)this.x, y, size, size);
  }
}
