//Cuboid c = new Cuboid(100, 100, 100);
Cuboid[] cuboids = new Cuboid[30];

void setup() {
  size(800, 800, P3D);
  smooth();
  
  for(int i = 0; i < cuboids.length; i++) {
     cuboids[i] = new Cuboid(
                   (width / cuboids.length) - 10,
                   (width / cuboids.length) - 10,
                   (width / cuboids.length) - 10,
                   (width/cuboids.length) + (i * 25),
                   (height/3),
                   i
                  );
  }
}

void draw() {
  background(204, 255, 255, 10);
  //camera(mouseX, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);

  for(int i = 0; i < cuboids.length; i++) {
    cuboids[i].update();
    cuboids[i].render();
  }
}

class Cuboid {
  float h, w, d, z, x, y;
  String direction = "up";
  
  Cuboid(float _h, float _w, float _d, float _x, float _y, float _z) {
    h = _h;
    w = _w;
    d = _d;
    x = _x;
    y = _y;
    z = _z;
  }
  
  void update() {
    println(width);
    println(cuboids.length);
    println(width / cuboids.length);
    if (direction == "up") {
      h = h + 3;
      if (h >= 90) {
        direction = "down";
      }
    } else if (direction == "down") {
      h--;
      if (h <= 10) {
        direction = "up";
      }
    }
    //println(h, w, d);
  }
  
  void render() {
    //noFill();
    fill(255, 255, 10, 10);
    
    pushMatrix();
    translate(x, y, z);
    box(w, h, d);
    popMatrix();
  }
}