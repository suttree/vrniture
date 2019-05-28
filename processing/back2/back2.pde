Cuboid c = new Cuboid(100, 100, 100);

void setup() {
  //size(800, 800, P3D);
  fullScreen();
  noCursor();
  smooth();
}

void draw() {
  background(204, 255, 255, 10);
  camera(mouseX, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);

  c.update();
  c.render();
}

class Cuboid {
  float h, w, d;
  String direction = "up";
  
  Cuboid(int _h, int _w, int _d) {
    h = _h;
    w = _w;
    d = _d;
  }
  
  void update() {
    if (direction == "up") {
      h++;
      if (h >= 200) {
        direction = "down";
      }
    } else if (direction == "down") {
      h--;
      if (h <= 0) {
        direction = "up";
      }
    }
    //println(h, w, d);
  }
  
  void render() {
    pushMatrix();
    translate(width/2,height/2, 0);
    box(w, h, d);
    popMatrix();
  }
}
