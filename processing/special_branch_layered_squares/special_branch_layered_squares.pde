PFont font;
Layer layer = new Layer(0, 0, 800, 800, 0);
  
void setup() {
  smooth();
  size(800, 800, P3D);
  font = createFont("Arial Bold", 36);
}

void draw() {
  // fps
  textFont(font, 36);
  fill(255);
  text(frameCount, 20, 40);
  
  fill(10, 200, 255, 90);
  rect(0, 0, width, height);
  
  layer.render();
  layer.update();
}

class Layer {
  float x, y, w, h, d;
  float accel = 0.08;
  
  Layer(float _x, float _y, float _w, float _h, float _d) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    d = _d;
  }
  
  void update() {
    x = x + accel;
    y = y + accel;
    w = w - (accel * 2);
    h = h - (accel * 2);
  }
  
  void render() {
    rect(x, y, w, h, d);
  }
}