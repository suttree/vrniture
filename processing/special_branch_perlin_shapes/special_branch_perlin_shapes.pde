 // Give each Layer a noise variable (and change it on reset)
 // Use the noise variable to determine the location and height of the curves
 // - use the constrain function?
 //     constrain(amt, low, high)
 // Next: make a rectangle to fill the screen and draw a contour with the vertexes (anti-clockwise)
 // - test with a square contour first
int gap = 127;

// Color Harmony library: https://github.com/cageehv/ColorHarmony/
import com.cage.colorharmony.*;

// Create a colorharmony instance
ColorHarmony colorHarmony = new ColorHarmony(this);
color[] colors = colorHarmony.Triads();

Layer[] layers = new Layer[8];

void setup() {
  smooth();
  //size(800, 800);
  fullScreen();
  noCursor();
  
  float x = width/2;
  float y = height/2;
  for(int i = 0; i < layers.length; i++) {
    int size = 0;
    int timer = i * gap;
    //color c = color(100 + random(155), random(255), 106);
    color c = colors[(int)random(8)];
    layers[i] = new Layer(x, y, size, size, timer, c);
  }
}

void draw() {
  noStroke();
  fill(5, 32);
  rect(0, 0, width, height);

  for(int i = 0; i < layers.length; i++) {
    layers[i].render();
    layers[i].update();
  }
}

class Layer {
  float x, y, w, h, offset;
  float accel = 0.78;
  float v = random(0.0, 10.0);
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
    accel = accel + sin(v) * 2;
  }

  void update() {
    // Render when we're ready
    if (counter > timer) {
      x = x - accel;
      y = y - accel;
      w = w + (accel * 2) - sin(v) * 2;
      h = h + (accel * 2) - cos(v) * 2;
      
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
      offset = offset + 0.23;
      //println(noise(offset));
      //println(constrain(noise(offset)*10, 0, 8));
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
      w = random(-2, 0) - sin(v);
      h = w;
      counter = timer;
      c = colors[(int)random(8)];
      visible = false;
    }
    
    // Reset colours
    if ( frameCount % 400 == 0 ) {
      colors = colorHarmony.GetRandomPalette();
    }
  }
  
  void render() {
    if (visible) {

      pushMatrix(); 
      translate(width/2, height/2); 
      rotate(radians(frameCount)); 


      //float off1 = constrain(noise(offset)*10, 0, w);
      noFill();
      stroke(c);
      strokeWeight(2 + sin(v));
      beginShape();
      vertex(x, y);
      
      quadraticVertex(x + (w/3), y - (h/8), x + (w/2), y);
      quadraticVertex(x + w - (w/3), y + (h/8), x + w, y);
      vertex(x + w, y);
      
      quadraticVertex(x + w - (w/3), y + h/3, x + w, y + (h/2));
      quadraticVertex(x + w + (w/3), y + h - (h/4), x + w, y + h);
      vertex(x + w + cos(v), y + h + sin(v));
      
      quadraticVertex(x + w - (w/3), y + h - (h/3), x + (w/2), y + h);
      quadraticVertex(x + (w/3), y + h + (h/3), x, y + h);
      vertex(x, y + h);
      
      quadraticVertex(x - (w/3), y + h - (h/3), x, y + (h/2));
      quadraticVertex(x + (w/3), y + (h/3), x, y);
      endShape(CLOSE);
      
      popMatrix(); 
    }
    
    v += 0.1;
  }
}
