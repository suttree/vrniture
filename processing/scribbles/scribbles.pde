Layer[] layers = new Layer[(int)random(3,8)];


int gap = width/layers.length;

void setup() {
  smooth();
  size(800, 800, P3D);
  //fullScreen();
  noCursor();

  for(int i = 0; i < layers.length; i++) {
    int start = 0 - (i * gap);
    layers[i] = new Layer(
      start, 
      0 + height/5, 
      width + (i * gap * 2), 
      127, 
      color(100 + random(175), random(255), 126),
      random(12)
     );
  }
}

void draw() {
  noStroke();
  fill(10, 200, 255, 38);
  rect(0, 0, width, height);
 
  for(int i = 0; i < layers.length; i++) {
    layers[i].render();
    layers[i].update();
  }
}

class Layer {
  float x, y, w, h, xoff;
  float accel = random(0.50, 1.70);
  color c = color(255, 0, 255);
  int strokeWeight;
  
  Layer(float _x, float _y, float _w, float _h, color _c, float _xoff) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    c = _c;
    xoff = noise(_xoff);
    strokeWeight((int)random(1,3));
  }
  
  void update() {
    x = x + accel;
    w = w - (accel * 2);
    if (w <= 0 || h <=0) {
      x = 0 + xoff;
      y = 127 + xoff;
    } else if (w > width) {
      accel = 1.78;
    }
  }
  
  void render() {
    c = color(100 + random(175), random(255), 126);
    fill(c, 10);
    stroke(c);
    strokeWeight(strokeWeight);
    beginShape();
    
    vertex(x, y);
    
    curveVertex(x, y);
    curveVertex(x + random(10,width/2) + xoff, y - random(10,20) - xoff);
    curveVertex((x + w) / 2, y);
    curveVertex(x + w, y);
    
    vertex(x + w, y);
    vertex(x + w, y + h);
    vertex(x, y + h);
    
    endShape();

    xoff = xoff + 0.0374;
  }
}
