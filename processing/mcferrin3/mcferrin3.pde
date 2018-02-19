StarShape[] stars = new StarShape[10];

void setup() {
  //fullScreen();
  size(640, 480, P3D);
  smooth(8);
  
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new StarShape(); 
  }
}

void draw() {
  background(250, 240, 231);
  stroke(34);

  float t = 0.0; 
  float dist = 20.0;
  float startx, endx, x, y, prevx, prevy;

  for (int j = 0; j < 15; j++) {
    /*
    fill(233, 178, 0);
    fill(32, 178, 170);
    fill(25, 237, 20);
    fill(255, 140, 0);
    fill(34, 139, 34, 20);
    */
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
    quadraticVertex(prevx + dist, prevy + (dist * 2.75), endx, height);
    vertex(endx, height);
    vertex(0, height);
    vertex(0, 0);
    endShape();
    t = t + 0.05;
    dist = dist + (8 * cos(dist));
    
    // starfield
    for (int i = 0; i < stars.length; i++) {
      stars[i].update();
      stars[i].checkEdges();
      stars[i].render();
    }
  }
}

class StarShape {
  PVector location;
  PVector velocity;
  PVector shape;

  StarShape() {
    int i = (int) Math.floor(Math.random() * 8.0);
    int x = (int) (0 - Math.random() * width/2);
    int y = (int) Math.random() * height;
    println(x, y);

    location = new PVector(int(x), int(y));
    velocity = new PVector((int) (Math.random() * 4) - 2, (int) (Math.random() * 3) - 1);
  }

  void update() {
    location.add(velocity);
  }

  void checkEdges() {
    if (location.x > width/2 + 40) {
      location.x = -40;
    } else if (location.y > height + 40) {
      location.y = -40;
    }
  }

  void render() {
    fill(238, 233, 233);
    rect(location.x, location.y, 2, 2, 90);
  }
}