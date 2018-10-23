// The same but with sound waves emerging from the center (more tech, less beach)

Wave[] waves = new Wave[10];

void setup() {
  smooth();
  //size(800, 800);
  fullScreen();
  noCursor();
  
  for(int i = 0; i < waves.length; i++) {
    color c = color(0, 105, 148, 95 - (i * 10));
    waves[i] = new Wave(c, width - width/3 - (i * 120), random(20, 75), random(5.5));
  }
  
  frameRate(4);
}

void draw() {
  noStroke();
  fill(237, 201, 175, 50);
  rect(0, 0, width, height);
  
  for(int i = 0; i < waves.length; i++) {
    waves[i].render();
    waves[i].update();
  }
  
  // now draw layeres on the right hand side
  // pick a dark colour and draw it from about half way
  float t = 0.0; 
  float dist = 40.0;
  float startx, endx, x, y, prevx, prevy;
  
  for (int j = 0; j < 15; j++) {
    if (j == 0) {
      fill(76, 224, 230);
    } else if (j == 3) {
      fill(233, 178, 0);
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

  delay(125);
  //saveFrame("line-######.png");
}

class Wave {
  color c;
  float gap;
  float inc;
  float x;
  float xoff = random(3.75);
  
  Wave(color _c, int _x, float _gap, float _inc) {
    c = _c;
    x = _x;
    gap = _gap;
    inc = _inc;
  }
  
  void update() {
    x = x + inc;
    if ( x >= (width + 100)) { 
      x = 0 - gap;
    }
  }
  
  void render() {
    fill(c);
    stroke(255, 255, 255, 70);
    beginShape();
    vertex(-10, -10);
    for(int y = 0; y < height*10; y += gap) {
      vertex(x + (noise(xoff) * 100), y);
      xoff = xoff + 0.04;
    }
    vertex(-10, height + 10);
    endShape(CLOSE);
  }
}
