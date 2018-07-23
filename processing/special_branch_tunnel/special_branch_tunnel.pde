// Reverse the animation, squares grow towards us

import gifAnimation.*;

PFont font;
Layer[] layers = new Layer[4];

GifMaker gifExport;
int frames = 0;
int totalFrames = 440;

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
  noStroke();
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
    xoff = 0.0;
  }
  
  void update() {
    x = x + accel;
    y = y + accel;
    w = w - (accel * 2);
    h = h - (accel * 2);
    
    println(noise(xoff) * 10);
    if (noise(xoff) * 10 > 6) {
      println(1);
      x = x - noise(xoff);
    } else if (noise(xoff) * 10 > 2) {
      println(2);
      x = x + noise(xoff);
    } else {
      println(3);
      // stay the same
    }
/*
    println(xoff);
    println(noise(xoff));
*/
    println("--");
    /*
    if (w <= 0) {
      status = "repeating";
      accel = 0 - accel;
    } else if (w > width && status == "repeating") {
      accel = 0.98;
      c = color(100 + random(155), random(255), 160);
    }
    */
    
    if (w <= 0) {
      x = 0;
      y = 0;
      w = width;
      h = height;
      c = color(100 + random(155), random(255), 160);
    }
  }
  
  void render() {
    noFill();
    stroke(c);
    //rect(x, y, w, h);
    beginShape();
    
    vertex(x, y);
    /*
    curveVertex(x, y);
    curveVertex(x + 10, y - 10);
    curveVertex((x + w) / 2, y);
    curveVertex(x + w, y);
    */
    vertex(x + w, y);
    
    vertex(x + w, y + h);
    vertex(x, y + h);
    endShape(CLOSE);

    //quadraticVertex(x, y, x + (xoff * w), y - (xoff * h/2));
    //quadraticVertex(x, y, x + w/4, y + h/8);
    //quadraticVertex(x + w/4, y + h/8, x + w/2, y);

    xoff = xoff + .04;
  }
}