float phase, speed, maxCircleSize, numRows, numCols, numStrands, colorA, colorB;

void setup() {
  fullScreen();
  noStroke();
  
  phase = 0;
  speed = 0.03;
  maxCircleSize = 20;
  numRows = 10;
  numCols = 16;
  numStrands = 2;
  
  colorA = color(253, 174, 120);
  colorB = color(226, 129, 161);
}

void draw() {
  background(4, 58, 74);
  phase = frameCount * speed;
  
  for(int strand = 0; strand < numStrands; strand += 1) {
    float strandPhase = phase + map(strand, 0, numStrands, 0, TWO_PI);
    
    for(int col = 0; col < numCols; col += 1) {
      float colOffset = map(col, 0, numCols, 0, TWO_PI);
      float x = map(col, 0, numCols, 50, width - 50);
      
      for(int row = 0; row < numRows; row += 1) {
        float y = height/2 + row * 10 + sin(strandPhase + colOffset) * 50;
        float sizeOffset = (cos(strandPhase - (row / numRows) + colOffset) + 1) * 0.5;
        float circleSize = sizeOffset * maxCircleSize;
        
        fill(lerpColor(parseInt(colorA), parseInt(colorB), row / numRows));
        ellipse(x, y, circleSize, circleSize);
      }
    }
  }
}