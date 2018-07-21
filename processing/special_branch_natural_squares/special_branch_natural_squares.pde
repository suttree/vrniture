// NEXT: same but with contour?
// NEXT: do this with a PShape and perlin edges
import gifAnimation.*;

PFont font;
Layer[] layers = new Layer[5];

GifMaker gifExport;
int frames = 0;
int totalFrames = 824;

int gap = 100;

void setup() {
  smooth();
  size(800, 800, P3D);
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
      color(100 + random(155), random(255), 106),
      random(10)
     );
  }
}

void draw() {
  // fps
  /*
  fill(255);
  textFont(font, 36);
  text(frameCount, 20, 40);
  */
  
  //fill(10, 200, 255, 85);
  fill(0, 32);
  rect(0, 0, width, height);
 
  for(int i = 0; i < layers.length; i++) {
    layers[i].render();
    layers[i].update();
  }
  
  //export();
}

void export() {
  if(frames < totalFrames) {
    gifExport.setDelay(60);
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
  float x, y, w, h, xoff;
  float accel = 0.98;
  color c = color(255, 255, 255);
  String status = "ready";
  
  Layer(float _x, float _y, float _w, float _h, color _c, float _xoff) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    c = _c;
    xoff = noise(_xoff);
    
  }
  
  void update() {
    x = x + accel;
    y = y + accel;
    w = w - (accel * 2);
    h = h - (accel * 2);
    
    if (w <= 0) {
      status = "repeating";
      accel = 0 - accel;
    } else if (w > width && status == "repeating") {
      accel = 0.98;
      c = color(100 + random(155), random(255), 160);
    }
  }
  
  void render() {
    noFill();
    stroke(c);
    //rect(x, y, w, h);
    beginShape();
    vertex(x, y);
    //quadraticVertex(x, y, x + (xoff * w), y - (xoff * h/2));
    for(int i = 0; i < 2; i++) {
      float qx = x + (xoff * 90 * i);
      float qy = height/(2 + 1) * (i+1);
      println(qx, qy);
      quadraticVertex(qx, qx, x, y);
    }
    
    vertex(x + w, y);
    vertex(x + w, y + h);
    //vertex(x, y + h);
    endShape();
    
    xoff = xoff + .05;
  }
}