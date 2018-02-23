float t = 0;
float gap = 2;
int offset = 6;
int boxSize = 100;
int boxLayers = 3;

void setup() {
  //fullScreen();
  size(640, 480, P3D);
  smooth();
}

void draw() {
  background(49, 54, 57);
  
  // draw a line of rects
  for(int i = 0; i < (width/boxSize) + 2; i++ ) {
    stroke(34);
    fill(245, 195, 72);
    rect((i * boxSize - boxSize/3) + (i * gap), (height/2 - boxSize/2), boxSize, boxSize, 0);
    
    noStroke();
    for(int j = 0; j < boxLayers; j++) {
      t = t + 0.01;
      fill(245, 195, 72, noise(t)*100 * j);
      rect((i * boxSize - boxSize/3) + (i * gap) + (offset * j) + 1, (height/2 - boxSize/2) - (offset * j) - 1, boxSize, boxSize, 0);
    }
  }
  fill(69, 74, 77, 49);
  rect(0, 0, width, height);
  
  t = t + 0.02;
}