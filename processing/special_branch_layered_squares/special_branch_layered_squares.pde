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
  noSmooth();
  size(800, 800);
  font = createFont("Arial Bold", 36);
  
  gifExport = new GifMaker(this, "export.gif", 255, 255);
  gifExport.setRepeat(0);

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
  
  //background(10, 200, 255, 65);
  fill(10, 200, 255, 65);
  rect(0, 0, width, height);
 
  for(int i = 0; i < layers.length; i++) {
    layers[i].render();
    layers[i].update();
  }
  
  //export();
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
  float accel = 0.98;
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
    //rect(x, y, w, h);

    beginShape();
    vertex(x, y);
    vertex(x + w, y);
    vertex(x + w, y + h);
    vertex(x, y + h);
    
    float cx, cy, cw, ch;
    cw = w/3;
    ch = h/3;
    cx = width/2 + w/2;
    cy = height/2 + h/2;
    cx = x + cw;
    cy = y + ch;
    
    beginContour();
    vertex(cx, cy);
    vertex(cx + cw, cy);
    vertex(cx + cw, cy + ch);
    vertex(cx, cy + ch);
    endContour();
    
    endShape(CLOSE);
  }
}