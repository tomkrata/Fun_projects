int points = 150;
float factor = 0;
float r;
short[] rgb;
void setup() {
   size(600, 600);
   r = width / 2 - 20;
   rgb = new short[3];
   rgb[0] = 255;
   rgb[1] = 255;
   rgb[2] = 255;
}

PVector getPointByIndex(float index) {
   float angle = map(index % points, 0, points, TWO_PI, 0);
   return new PVector(r * cos(angle), r * sin(angle));
}

void draw() {
   background(0);
   noFill();
   stroke(rgb[0], rgb[1], rgb[2], 100);
   factor += 0.01;
   translate(width / 2, height / 2);
   circle(0, 0, r * 2);
   for (int i = 0; i < points; i++) {
       PVector v = getPointByIndex(i);
       PVector vNext = getPointByIndex(i * factor);
       line(v.x, v.y, vNext.x, vNext.y);
   }
}
