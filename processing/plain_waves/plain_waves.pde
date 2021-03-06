Wave[] waves = new Wave[6];

// Color Harmony library: https://github.com/cageehv/ColorHarmony/
import com.cage.colorharmony.*;

// Create a colorharmony instance
ColorHarmony colorHarmony = new ColorHarmony(this);

// Fetch a random palette
color[] colors = colorHarmony.GetRandomPalette();
color bg = colors[0];

float _style = random(1, 5);

void setup() {
  //size(800, 800);
  fullScreen();

  noCursor();
  smooth();
  
  for(int i = 0; i < waves.length; i++) {
    color c = color(colors[(int)random(8)], 95 - (i * 10));
    waves[i] = new Wave(c, 0 - (i * 120), random(10), 15, random(1.5));
  }
  
  frameRate(4);
}

void draw() {
  noStroke();
  fill(bg, 60);
  rect(0, 0, width, height);
  
  for(int i = 0; i < waves.length; i++) {
    waves[i].render();
    waves[i].update();
  }
  delay(125);
}

class Wave {
  color c;
  float mag;
  float gap;
  float inc = 0;
  float x = 0;
  float xoff = random(3.75);
  float _rw = random(width);
  float _rh = random(height);
  
  Wave(color _c, int _x, float _mag, float _gap, float _inc) {
    c = _c;
    x = _x;
    mag = _mag;
    gap = _gap;
    inc = _inc;
    
    if (_style == 1) {
      // set one random vertex only
    } else if (_style == 2) {
      // reset random vertex on instantion
      _rw = random(width);
      _rh = random(height);
    }else if (_style == 3) {
      // we'll randomise on each nth render
    } else if (_style == 4) {
      // don't use the extra vertex
    }
  }
  
  void update() {
    if (_style == 3 && frameCount % 12 == 0) {
      _rw = random(width);
      _rh = random(height);
    }
    
    x = x + inc;
    if (x >= (width + gap)) { 
      x = 0 - gap * 3;
    }
  }
  
  void render() {
    fill(c);
    noStroke();

    beginShape();
    vertex(-10, -10);

    for(int i = 0; i < height; i += gap) {
      vertex(x + (noise(xoff) * 100), i);
    }

    if (_style != 4) {
      vertex(_rw, _rh);
    }
    
    vertex(width + 100, x + 10);
    vertex(width + 10, -10);

    endShape(CLOSE);
  }
}
