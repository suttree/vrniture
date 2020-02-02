// Color Harmony library: https://github.com/cageehv/ColorHarmony/
import com.cage.colorharmony.*;

// Create a colorharmony instance
ColorHarmony colorHarmony = new ColorHarmony(this);
color[] colors = colorHarmony.Analogous();

// PG code from the Processing tutorials
PGraphics pg;

Brush[] brushes = new Brush[5];

void setup() {
  fullScreen();
  //size(640, 480);
  noCursor();

  background(48, 48, 48);
  frameRate( (int) random(6, 12) );

  pg = createGraphics(width, height);

  for(int i = 0; i < brushes.length; i++) {
    brushes[i] = new Brush((int) random(5));
  }
}

void draw() {
  for(int i = 0; i < brushes.length; i++) {
    brushes[i].render();
    brushes[i].update();
  }
}

class Brush {
  int strands, lifetime, points;
  float v, x, y, prevx, prevy;
  float easing = random(0.5);
  float xoff = random(3.75);
  
  Brush(int _strands) {
    strands = _strands;
    v = random(-1, 1);
    x = random(width);
    y = random(height);
    
    // don't need both here?
    // thicker brushes are longer?
    lifetime = strands * 3;
    points = lifetime;
  }
  
  void update() {
    prevx = x;
    prevy = y;
    
    //x = x + sin(x);
    //y = y - 1;
    
    v += v;
    xoff = xoff + 0.125;

    if (lifetime == 0) {
      // pause and reset
      delay(125 * 2);
      colors = colorHarmony.Triads();
      strands = (int) random(5);
      x = random(width);
      y = random(height);
    } else {
      lifetime = lifetime - 1;
    }
  }
  
  void render() {
    pg.beginDraw();
    pg.stroke(colors[3], 60);

    // thinner/fatter brushes
    float weight = map(strands, 0, 5, 0, 3);
    pg.strokeWeight(weight);

    for(int i = 0; i < strands; i++) {
      // shift the x and y
      float _x = x + (i * sin(v) * 4);
      float _y = y - (i * cos(v) * 4);
      pg.vertex(_x, _y);
    }
    
    pg.beginShape();
    pg.vertex(prevx, prevy);
    pg.endShape();
    pg.endDraw();

    image(pg, 0, 0);
    
    noStroke();
    rect(x, y, 2, 2);
    
    delay((int) random(120, 240));
  }
}
