// layers should grow towards you from nothing in the middle
int gap = 100;

Layer[] layers = new Layer[4];

void setup() {
  smooth();
  size(800, 800, P3D);
  
  float x = width/2;
  float y = height/2;
  for(int i = 0; i < layers.length; i++) {
    int size = 0;
    int timer = i * gap;
    color c = color(100 + random(155), random(255), 106);
    layers[i] = new Layer(x, y, size, size, timer, c);
  }
}

void draw() {
  noStroke();
  fill(0, 32);
  rect(0, 0, width, height);

  for(int i = 0; i < layers.length; i++) {
    layers[i].render();
    layers[i].update();
  }
}

class Layer {
  float x, y, w, h, xoff;
  float accel = 0.98;
  int counter = 0;
  int timer;
  boolean visible = false;
  color c = color(255, 255, 255);
  
  Layer(float _x, float _y, float _w, float _h, int _timer, color _c) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    timer = _timer;
    c = _c;
    xoff = noise(0.0);
  }

  void update() {
    if (counter > timer) {
      x = x - accel;
      y = y - accel;
      w = w + (accel * 2);
      h = h + (accel * 2);
      xoff = xoff + 0.4;
    } else {
      counter++;
      if (counter > timer) {
        visible = true;
      }
    }
    
    if (w > width) {
      x = width/2;
      y = height/2;
      w = 0;
      h = 0;
      counter = timer;
      c = color(100 + random(155), random(255), 106);
      visible = false;
    }
  }
  
  void render() {
    if (visible) {
      noFill();
      stroke(c);
      beginShape();
      vertex(x, y);
      vertex(x + w, y);
      vertex(x + w, y + h);
      vertex(x, y + h);
      endShape(CLOSE);
    }
  }
}