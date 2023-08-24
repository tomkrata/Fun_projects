int cols, rows;
int scl = 10;
int w = 2000;
int h = 2000;
float off = 0.1;
float flying = 0;
int mountain_range = 300;
float fly_speed = 1.0;
int path_width = 10;

float mouseXOff;
float mouseYOff;
float mouse_diff_x;
float mouse_diff_y;


float[][] terrain;

void setup(){
  if (path_width == 0)
    mountain_range = 100;
  size(1200, 800, P3D);
  cols = w / scl;
  rows = h / scl;
  terrain = new float[cols][rows];
}

void draw(){
  background(255);
  noStroke();
  lights();
  fill(200);
  
  translate(width/2, height/2);
  rotateX(1.4);
  translate(-w/2, -h/2);
  
  flying -= fly_speed;
  float yoff = flying;
   
  for (int y = 0; y < rows - 1; y++){ //<>//
    float xoff = 0;
    float pathX = map(noise(yoff), 0, 1, (w/2 - 150) / scl, (w / 2 + 150) / scl);
    for (int x = 0; x < cols; x++){
        if (x >= pathX && x <= pathX + path_width){
         terrain[x][y] = map(noise(pathX, yoff), 0, 1, -mountain_range,-mountain_range + 1);
         terrain[x][y + 1] = map(noise(pathX, yoff + off), 0, 1, -mountain_range, -mountain_range +1);
        }
        else {
          float range;
         if (path_width == 0)
           range = mountain_range;
         else
           range = map(abs(x - (pathX + pathX + path_width) / 2), path_width / 2, path_width * 8, -mountain_range, mountain_range);
         //println(range);
         terrain[x][y] = map(noise(xoff, yoff), 0, 1, -mountain_range, range);
         terrain[x][y + 1] = map(noise(xoff, yoff + off), 0, 1, -mountain_range, range);
        }
        xoff += off;
    }
    yoff += off;
  }
  
   
  for (int y = 0; y < rows - 1; y++){
    //println(pathX);
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
        if (terrain[x][y] > 0.8 * mountain_range)
          fill(255);
         else
          fill(160,82,45);
       vertex(x * scl, y * scl, terrain[x][y]);
       vertex(x * scl,(y + 1) * scl, terrain[x][y+1]);
    }
    endShape();
  }
}

void keyPressed() {
  switch(key)
  {
    case 'a':
    mountain_range -= 10;
    break;
    case 'd':
    mountain_range += 10;
    break;
    case 'w':
    if (fly_speed == 0)
      fly_speed = 0.1;
    else
      fly_speed = 0;
    break;
    case 's':
    if (fly_speed == 0)
      fly_speed = -0.1;
    else
      fly_speed = 0;
    break;
    
  }
}

void mousePressed() {
  mouseXOff = mouseX; 
  mouseYOff = mouseY; 

}

void mouseDragged() {
    mouse_diff_x = mouseX-mouseXOff; 
    mouse_diff_y = mouseY-mouseYOff;
    mouseXOff = mouseX;
    mouseYOff = mouseY;
    fly_speed =  mouse_diff_y / 100;
}

void mouseReleased() {
  fly_speed = 0;
}
