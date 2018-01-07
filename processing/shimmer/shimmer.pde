color white, offwhite, navy, offnavy;
float x, y, phase, phaseOffset, speed, size, maxRows, maxCols, numBlocks;

void setup() {
  fullScreen(P3D);
  noStroke();
  
  size = 4;
  maxRows = 52;
  maxCols = 16;
  phase = 0;
  phaseOffset = 0;
  speed = 0.03;
  numBlocks = 2;
  
  white = color(255, 255, 255);
  offwhite = color(255,218,185);
  navy = color(6, 62, 78);
  offnavy = color(10, 15, 68);
}

void draw() {
  noCursor();
  background(navy);
  
  for(int block = 0; block < numBlocks; block++) {
    float startx = map(block, 0, numBlocks, width/2, height/2);
    for(int col = 0; col < maxCols; col++) {
      x = startx + col * size;

      for(int row = 0; row < maxRows; row++) {
        y = (height / 4) + row * size;
        
        
        //phase = frameCount * speed * col * row;
        //phase = frameCount * speed * row;
        phase = frameCount * speed * col;
        phaseOffset = sin(phase) * 2;

        fill(lerpColor(parseInt(white), parseInt(navy), phaseOffset));
        ellipse(x, y, size, size);
      }
    }
  }
}