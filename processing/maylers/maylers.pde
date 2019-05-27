int[][] colours = {
  {233, 178, 0},
  {32, 178, 170},
  {25, 237, 20},
  {255, 140, 0},
  {34, 139, 34, 20},
  {25, 237, 20},
  {76, 224, 230}
};
  
void setup() {
  //size(640, 480, P3D);
  fullScreen();
  
  noCursor();
  smooth(8);
  frameRate(2);
}

void draw() {
  background(250, 240, random(84,231));
  stroke(34);

  float t = random(0,1);
  float dist = 20.0;
  float startx, endx, x, y, prevx, prevy;

  for (int j = 0; j < 15; j++) {
    if (j == 0) {
      int rand = (int) random(colours.length);
      int[] c = colours[rand];
      fill(c[0], c[1], c[2]);
    } else if (j == 1) {
      int rand = (int) random(colours.length);
      int[] c = colours[rand];
      fill(c[0], c[1], c[2]);
    } else if (j < 7) {
      int rand = (int) random(colours.length);
      int[] c = colours[rand];
      fill(c[0], c[1], c[2]);
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

    //int numPoints = 4;
    int numPoints = 3;

    for (int i = 0; i < numPoints; i++) {
      x = startx + (noise(t) * 90 * i);
      y = height/(numPoints + 1) * (i+1);

      dist = dist + noise(t);
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

    t = t + 0.5;
    dist = dist + (8 * cos(dist));
  }
}
