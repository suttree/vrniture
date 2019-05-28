 // Give each Layer a noise variable (and change it on reset)
 // Use the noise variable to determine the location and height of the curves
 // - use the constrain function?
 //     constrain(amt, low, high)
 // Next: make a rectangle to fill the screen and draw a contour with the vertexes (anti-clockwise)
 // - test with a square contour first
int gap = 100;

Layer[] layers = new Layer[4];

void setup() {
  smooth();
  //size(800, 800, P3D);
  fullScreen(P3D);
  noCursor();
  
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
  float x, y, w, h, offset;
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
    offset = 0.0;
  }

  void update() {
    // Render when we're ready
    if (counter > timer) {
      x = x - accel;
      y = y - accel;
      w = w + (accel * 2);
      h = h + (accel * 2);
      
      /*
      // Move gently or stay the same
      float p = noise(offset) * 12;
      if (p > 8) {
        x = x - (offset/2);
      } else if (p > 6) {
        y = y - (offset/2);
      } else if (p > 4) {
        x = x + (offset/2);
      } else if (p > 2) {
        y = y + (offset/2);
      }
      */
      offset = offset + 0.3;
      println(noise(offset));
      println(constrain(noise(offset)*10, 0, 8));
    } else {
      counter++;
      if (counter > timer) {
        visible = true;
      }
    }
    
    // Loop 
    if (w > width || h > height) {
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
      //float off1 = constrain(noise(offset)*10, 0, w);
      noFill();
      stroke(c);
      beginShape();
      vertex(x, y);
      quadraticVertex(x + (w/3), y - (h/8), x + (w/2), y);
      quadraticVertex(x + w - (w/3), y + (h/8), x + w, y);
      vertex(x + w, y);
      quadraticVertex(x + w - (w/3), y + h/3, x + w, y + (h/2));
      quadraticVertex(x + w + (w/3), y + h - (h/4), x + w, y + h);
      vertex(x + w, y + h);
      quadraticVertex(x + w - (w/3), y + h - (h/3), x + (w/2), y + h);
      quadraticVertex(x + (w/3), y + h + (h/3), x, y + h);
      vertex(x, y + h);
      quadraticVertex(x - (w/3), y + h - (h/3), x, y + (h/2));
      quadraticVertex(x + (w/3), y + (h/3), x, y);
      endShape(CLOSE);
    }
  }
}
