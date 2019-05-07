// Create something circular with this code via https://plaxdev.wordpress.com/2017/05/04/procedurally-generating-islands/
void setup() {
  size(800,600);
  noCursor();
  smooth();
}

void draw() {
  float angle = 0;
  float radius = 200;
  int maxRadius = 200;
  float[][] array;
  float centerX = width/2;
  float centerY = height/2;
  
  while(radius > 0) {
      while(angle < 360) {
          float x = centerX + radius * Math.cos(angle);
          float y = centerY + radius * Math.sin(angle);
          array[int(x)][int(y)] = maxRadius - radius;
          angle++;
      }
      angle = 0;
      radius--;
  }
}
