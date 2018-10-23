void setup() {
  smooth();
  size(800, 800);
  //fullScreen();
  noCursor();
}

void draw() {
  noStroke();
  fill(237, 201, 175, 50);
  rect(0, 0, width, height);

  float t = 0.0; 
  float dist = 40.0;
  float startx, endx, x, y, prevx, prevy;

  for (int j = 0; j < 15; j++) {
    if (j == 0) {
      fill(76, 224, 230);
    } else if (j == 8) {
      fill(233, 178, 0);
    } else if (j == 7) {
      fill(255,255,12);
    } else if (j == 6) {
      fill(55,157,180);
    } else if (j == 5) {
      fill(255,15,80);
    } else if (j == 4) {
      fill(255,105,180);
    } else if (j == 3) {
      fill(255, 255, 255);
    } else if (j == 2) {
      fill(25, 237, 20);
    } else if (j == 1) {
      fill(32, 178, 170);
    } else {
      fill(24, 80);
    }
    
    startx = width/2 - (10 * j);
    endx = width/2 - (40 * j);
    prevx = startx;
    prevy = 0;
  
    noStroke();
    beginShape();
    vertex(0, 0);
    vertex(startx, 0);
    int numPoints = 3;
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
    quadraticVertex(prevx + dist, prevy + (dist * 2.75), endx, height);
    vertex(endx, height);
    vertex(0, height);
    vertex(0, 0);
    endShape();
    t = t + 0.05;
    dist = dist + (8 * cos(dist));
  }
}
