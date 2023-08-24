float r1 = 230;
float r2 = 200;
float m1 = 20;
float m2 = 20;
float a1 = PI * 0.999;
float a2 = PI;
float a1_v = 0;
float a2_v = 0;
float a1_a = 0;
float a2_a = 0;
float prevX = 0;
float prevY = 0;
float g = 0.8;

boolean visible = true;

PGraphics canvas;

void setup(){
  size(1300, 1100);
  canvas = createGraphics(width, height);
  canvas.beginDraw();
  canvas.background(0);
  canvas.endDraw();
}

void keyPressed() {
  switch(keyCode) {
    case ENTER:
      visible = !visible;
      break;
    case UP:
      a1_v += 0.05;
      break;
  }
}

void draw() {
  background(0);
  image(canvas, 0, 0);
  translate(width / 2, 500);
  fill(255, 255, 0);
  stroke(255, 255, 0);
  
  a1_a = (-g*(2*m1+m2)*sin(a1)-m2*g*sin(a1-2*a2)-
          2*sin(a1-a2)*m2*(a2_v*a2_v*r2+a1_v*a1_v*r1*
          cos(a1-a2)))/(r1*(2*m1+m2-m2*cos(2*a1-2*a2)));
  a2_a = (2*sin(a1-a2)*(a1_v*a1_v*r1*(m1+m2)+g*(m1+m2)*
          cos(a1)+a2_v*a2_v*r2*m2*cos(a1-a2)))/(r2*(2*
          m1+m2-m2*cos(2*a1-2*a2)));
  if (!mousePressed) {
  }
  else{
    a1_a = 0;
    a1_v = 0;
    a2_a = (-g / r2) * sin(a2);
  }
  
  a1_v += a1_a;
  a2_v += a2_a;
  a1 += a1_v;
  a2 += a2_v;
  /*
  a1_v *= 0.9;
  a2_v *= 0.9;
  */
  float x1 = r1 * sin(a1);
  float y1 = r1 * cos(a1);
  float x2 = x1 + r2 * sin(a2);
  float y2 = y1 + r2 * cos(a2);
  if (visible) {
    line(0, 0, x1, y1);
    circle(x1, y1, m1);
    line(x1, y1, x2, y2);
    circle(x2, y2, m2);
  }
  canvas.beginDraw();
  canvas.translate(width / 2, 500);
  canvas.stroke(255, 0, 0);
  if (frameCount > 1)
    canvas.line(prevX, prevY, x2, y2);
  prevX = x2;
  prevY = y2;
  canvas.endDraw();
}
