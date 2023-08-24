import processing.sound.*;
SoundFile file;

Box small;
Box large;
int y;
long touches = 0;
long timeStaps = 10000;
int digits = 6;

void setup()
{
  file = new SoundFile(this, "clack.mp3");
  size(1300, 600);
  small = new Box(100, 30, 0, 1);
  double largeMass = pow(100, digits - 1);
  large = new Box(300, 30 * digits, (double)-2 / timeStaps, largeMass);
  y = height - height / 3;
}
void draw()
{
  background(255);
  stroke(0);
  fill(0);
  rect(0, y, width, 20);
  boolean touched = false;
  for (long i = 0; i < timeStaps; i++)
  {
    small.update();
    large.update();
    if (large.collide(small)) {
      touches++;
      double largeV = large.bounce(small);
      double smallV = small.bounce(large);
      small.v = smallV;
      large.v = largeV;
      touched = true;
    }
    if (small.wallHit()) {
      small.v *= -1;
      touches++;
      touched = true;
    }
  }
  if (touched)
    file.play();
  if (large.v >= 0 && small.v >= 0 && small.v <= large.v)
  {
    //println("end");
    fill(255, 0, 0);
  }
  text(touches, 100, 100);
  small.show(y);
  large.show(y);
}
