int numPoints;
color white, navy;
float x, y, phase, phaseOffset, speed, size;

void setup() {
  fullScreen();
  noStroke();
  
  size = 3;
  phase = 0;
  phaseOffset = 0;
  speed = 0.03;
  numPoints = 20;
  
  white = color(255, 255, 255);
  navy = color(6, 62, 78);
}

void draw() {
  noCursor();
  background(navy);
  
  for(int i = 0; i < numPoints; i++ ) {
    x = (width / 2) + size * i;
    y = (height / 2) + size * i;
    phase = frameCount * speed;
    phaseOffset = sin(phase) * size * i;
    fill(lerpColor(parseInt(white), parseInt(navy), phaseOffset));
    ellipse(x, y, size, size);
  }
}