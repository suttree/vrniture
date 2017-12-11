TriangleShape[] triangles = new TriangleShape[20];

void setup() {
  smooth();
  noStroke();
  size(640,480);

  for (int i = 0; i < triangles.length; i++) {
    triangles[i] = new TriangleShape(); 
  }
}

void draw() {
  fill(50);
  background(0);
  fill(255, 95); // semi-transparent white
  rect(0, 0, width, height);

  // draw the triangle
  for (int i = 0; i < triangles.length; i++) {
    triangles[i].update();
    triangles[i].checkEdges();
    triangles[i].render();
  }
}

class TriangleShape {
  PVector location;
  PVector velocity;
  PVector shape;

  TriangleShape() {
    int i = (int) Math.floor(Math.random() * 8.0);
    int x = (int) Math.random() * width;
    int y = (int) Math.random() * height;
    
    if (i < 2) {
      x = (int) Math.floor(Math.random() * -20);
      y = (int) Math.floor(Math.random() * height);
    } else if (i < 4) {
      x = (int) Math.floor(Math.random() * width);
      y = (int) Math.floor(Math.random() * -20);
    } else if (i < 6) {
      x = (int) Math.floor(Math.random() * 20);
      y = (int) Math.floor(Math.random() * height);
    } else if (i < 8) {
      x = (int) Math.floor(Math.random() * width);
      y = (int) Math.floor(Math.random() * 20);
    } else {
      x = (int) Math.random() * width;
      y = (int) Math.random() * height;
    }

    location = new PVector(int(x), int(y));
    velocity = new PVector((int) (Math.random() * 4) - 2, (int) (Math.random() * 3) - 1);
    shape = new PVector((int) Math.floor(Math.random() * 202) - 101, (int) Math.floor(Math.random() * 202) - 101);
  }

  void update() {
    location.add(velocity);
  }

  void checkEdges() {
    if (location.x > width + 40) {
      location.x = -40;
    } else if (location.x < 0 - 40) {
      location.x = width + 40;
    } else if (location.y > height + 40) {
      location.y = -40;
    } else if (location.y < 0 - 40) {
      location.y = height + 40;
    }
  }

  void render() {
    stroke(10);

    triangle(
      location.x,
      location.y,
      location.x + shape.x,
      location.y,
      location.x,
      location.y + shape.y
    );
  }
}