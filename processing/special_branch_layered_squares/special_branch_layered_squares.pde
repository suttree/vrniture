// NEXT: same but with contour?
// NEXT: do this with a PShape and perlin edges
import gifAnimation.*;

PFont font;
Layer[] layers = new Layer[5];

GifMaker gifExport;
int frames = 0;
int totalFrames = 600;

int gap = 100;

void setup() {
  smooth();
  size(800, 800, P3D);
  font = createFont("Arial Bold", 36);
  
  gifExport = new GifMaker(this, "export.gif", 255, 255);
  gifExport.setRepeat(0);
  
  stroke(0);

  for(int i = 0; i < layers.length; i++) {
    int start = 0 - (i * gap);
    layers[i] = new Layer(
      start, 
      start, 
      width + (i * gap * 2), 
      height + (i * gap * 2), 
      color(100 + random(155), random(255), 106)
     );
  }
}

void draw() {
  // fps
  textFont(font, 36);
  fill(255);
  text(frameCount, 20, 40);
  
  fill(10, 200, 255, 90);
  rect(0, 0, width, height);
  
  for(int i = 0; i < layers.length; i++) {
    layers[i].render();
    layers[i].update();
  }
  
  export();
}

void export() {
  if(frames < totalFrames) {
    gifExport.setDelay(30);
    gifExport.addFrame();
    frames++;
  } else {
    gifExport.finish();
    frames++;
    println("gif saved");
    exit();
  }
}

class Layer {
  float x, y, w, h;
  float accel = 0.68;
  color c = color(255, 255, 255);
  
  Layer(float _x, float _y, float _w, float _h, color _c) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    c = _c;
  }
  
  void update() {
    x = x + accel;
    y = y + accel;
    w = w - (accel * 2);
    h = h - (accel * 2);
    
    if (w <= 0) {
      x = 0;
      y = 0;
      w = width;
      h = height;
    }
  }
  
  void render() {
    noFill();
    stroke(c);
    rect(x, y, w, h);
  }
}