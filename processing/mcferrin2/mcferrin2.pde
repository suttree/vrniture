void setup() {
  //fullScreen();
  size(640, 480, P3D);
  smooth(8);
}

void draw() {
  background(250, 240, 231);
  stroke(34);
  fill(34);
  
  float t = 0.0; 
  float dist = 40.0;
  float startx, endx, x, y, prevx, prevy;
  
  startx = width/2 - 100;
  endx = width/2 - 40;
  prevx = startx;
  prevy = 0;
  
  noStroke();
  beginShape();
  vertex(0, 0);
  vertex(startx, 0);
  int numPoints = 4;
  for (int i = 0; i < numPoints; i++) {
    x = startx + (noise(t) * 90 * i);
    y = height/(numPoints + 1) * (i+1);
    
    if ( i % 2 == 0 ) {
      quadraticVertex(prevx + dist, prevy + dist, x, y);
    } else {
      quadraticVertex(prevx - (dist * 2), prevy + (dist * 2), x, y);
    }
    vertex(x, y);

    prevx = x;
    prevy = y;
  }
  quadraticVertex(prevx + dist, prevy + (dist * 3), endx, height);
  vertex(endx, height);
  vertex(0, height);
  vertex(0,0);
  endShape();
  t = t + 0.05;
}