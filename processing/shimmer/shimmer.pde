color white, offwhite, gold, navy;
int numPoints;
float x, y, phase, phaseOffset, speed, size, maxRows, maxCols;

void setup() {
  fullScreen(P3D);
  noStroke();
  
  size = 7;
  maxRows = 25;
  maxCols = 10;
  phase = 0;
  phaseOffset = 0;
  speed = 0.03;
  numPoints = 20;
  
  white = color(255, 255, 255);
  offwhite = color(255,218,185);
  gold = color(254,166,33);
  navy = color(6, 62, 78);
}

void draw() {
  noCursor();
  background(navy);
  
  for(int col = 1; col < maxCols; col++) {
    x = (width / 2) + col * size;
    for(int row = 0; row < maxRows; row++) {
      y = (height / 2) + row * size;
      
      
      //phase = frameCount * speed * col * row;
      //phase = frameCount * speed * row;
      phase = frameCount * speed * col;
      
      
      phaseOffset = sin(phase) * 2;
      fill(lerpColor(parseInt(white), parseInt(navy), phaseOffset));
      ellipse(x, y, size, size);
    }
  }
}