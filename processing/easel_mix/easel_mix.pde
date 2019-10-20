// TODO: https://bjango.com/articles/processingperfectloops/
/*
float timeLoop(float totalframes, float offset) {
 return (frameCount + offset) % totalframes / totalframes;
}
 
float tri(float t) {
 return t < 0.5 ? t * 2 : 2 - (t * 2);
}
 
float inOutSin(float t) {
 return 0.5 - cos(PI * t) / 2;
}
*/

boolean debug = false;

// Color Harmony library: https://github.com/cageehv/ColorHarmony/
import com.cage.colorharmony.*;

// Create a colorharmony instance
ColorHarmony colorHarmony = new ColorHarmony(this);
color[] colors = colorHarmony.Analogous();

// PG code from the Processing tutorials
PGraphics pg;

float easing = 0.25;
float xoff = random(3.75);

Brush[] brushes = new Brush[1];

void setup() {
  fullScreen();
  //size(640, 480);
  noCursor();
  smooth();

  pg = createGraphics(width, height);

  for (int i = 0; i < brushes.length; i++) {
    brushes[i] = new Brush(4);
  }

  background(colors[0]);
  frameRate( (int) random(5, 25) );
}

void draw() {
  for (int i = 0; i < brushes.length; i++) {
    brushes[i].render();
    brushes[i].update();
  }
}

class Brush {
  boolean left_to_right, top_to_bottom;
  int strands, lifetime, points, iterations, x, y, targetx, targety;
  float v, dx, dy, prevx, prevy;

  Brush(int _strands) {
    strands = _strands;
    init();
  }

  void init() {
    v = random(-1, 1);
    x = (int) random(25, width - 25);
    y = (int) random(25, height - 25);

    prevx = x;
    prevy = y;

    points = 5;
    iterations = 0;
    lifetime = (int) random(30);

    delay(500);
    colors = colorHarmony.GetRandomPalette();

    // Pick a target, course, and stay with it
    if (x < width/2) {
      left_to_right = true;
      targetx = x + (int) random(100, width - 25 - x);
    } else {
      left_to_right = false;
      targetx = x - (int) random(100, width - 25 - x);
    }

    if (y < height/2) {
      top_to_bottom = true;
      if (random(2) > 1) {
        targety = y + (int) random(100);
      } else {
        targety = y + (int) random(100, height - 25 - y);
      }
    } else {
      top_to_bottom = false;
      if (random(2) > 1) {
        targety = y - (int) random(100, height - 25 - y);
      } else {
        targety = y - (int) random(75);
      }
    }
  }

  void update() {
    prevx = x;
    prevy = y;

    // Find our way to the target
    if (left_to_right) {
      //x = x + 2 * sin(v) * noise(xoff);
      dx = targetx - x;
      x += dx * easing;
    } else {
      dx = x - targetx;
      x -= dx * easing;
    }

    if (top_to_bottom) {
      //y = y + 2 * cos(v) * noise(xoff);
      dy = targety - y;
      y += dy * easing;
    } else {
      dy = y - targety;
      y -= dy * easing;
    }

    if (debug) {
      rect(x, y, 5, 5);
    }

    //println(left_to_right, top_to_bottom);
    //println(x, y, dx, dy, lifetime);

    lifetime--;
    if (lifetime <= 0) {
      init();
    }

    iterations++;
    if (iterations % 3 == 0) {
      delay(2500);
    }

    v += v;
  }

  void render() {
    pg.beginDraw();

    if (debug) {
      fill(0);
      rect(x, y, 15, 15);
      fill(255);
      rect(targetx, targety, 15, 15);
    }

    int style = (int) random(18);
    println(style);
    if (style <= 2) {
      // Straight line
      pg.fill(colors[1]);
      pg.stroke(colors[1]);

      // thinner/fatter brushes
      float weight = (int) random(6, 16);
      pg.strokeWeight(weight);

      // TODO: Review https://processing.org/reference/beginShape_.html for different styles
      pg.beginShape();
      pg.curveVertex(prevx, prevy);
      pg.curveVertex(prevx, prevy);
      //rect(prevx, prevy, 2, 2);

      if (random(2) > 1) {
        pg.curveVertex(x - sin(v) * 10, y + cos(v));
      } else {
        pg.curveVertex(x + cos(v) * 10, y - sin(v));
      }

      pg.curveVertex(x, y);
      pg.curveVertex(x, y);

      if (debug) {
        pg.rect(x, y, 2, 2);
      }

      pg.endShape();
    } else if (style <= 4) {
      pg.fill(colors[1]);
      pg.stroke(colors[1]);

      // thinner/fatter brushes
      float weight = (int) random(8, 18);
      pg.strokeWeight(weight);

      pg.noFill();

      // This is a nice brush
      pg.curve(prevx, prevy, prevx, prevy, x - 4, y, x, y - 4);
      pg.curve(prevx, prevy, prevx, prevy, x + 2, y, x, y + 2);
      pg.curve(prevx, prevy, prevx, prevy, x, y, x, y);
    } else if (style <= 6) {
      pg.fill(colors[1]);
      pg.stroke(colors[1]);

      // thinner/fatter brushes
      float weight = (int) random(4, 10);
      pg.strokeWeight(weight);

      pg.noFill();

      // This is slanted lines
       pg.curve(prevx, prevy, prevx, prevy, x - dx/lifetime, y - dy/lifetime, x, y);
    } else if (style <= 8) {
      // Curves
      pg.beginShape();
      
      pg.noFill();
      pg.stroke(colors[1]);
      
      float weight = (int) random(8, 20);
      pg.strokeWeight(weight);
      
      if (!left_to_right && top_to_bottom) {
        pg.bezier(prevx - cos(v) * 2, prevy + sin(v) * 2, prevx + dx/10, prevy - dx/10, prevx + dx/8 + noise(xoff) * 2, prevy - dx/8 - noise(xoff) * 2, x, y);
      } else {
        pg.bezier(prevx - cos(v) * 2, prevy + sin(v) * 2, prevx + dx/10, prevy - dx/10, prevx + dx/8 + noise(xoff) * 2, prevy - dx/8 - noise(xoff) * 2, x + sin(v) * 2, y - cos(v) * 2);
      }

      v += 0.31472;
      xoff += 0.31472;
      
      pg.endShape();
    } else if (style <= 10) {
      // Scribbles / hatching for ltf/ttb only
      float gap = 5;
      pg.noFill();
      pg.stroke(colors[1]);
      
      float weight = (int) random(8);
      pg.strokeWeight(weight);
      
      pg.beginShape();
      pg.vertex(prevx, prevy);
      pg.stroke(255, 255, 242, 70);
      for (float i = prevx; i < x; i += gap) {
        for (float j = prevy; j < y; j += gap) {
          pg.vertex(i, j - (noise(xoff) * 100));
          xoff = xoff + 0.31472;
        }
      }
      pg.vertex(x - sin(xoff), y + cos(xoff));
      pg.endShape();
    }

    if (debug) {
      rect(x, y, 2, 2);
    }

    // Use fill for main strand and noFill() for strands
    for(int i = 0; i < strands; i++) {
      pg.beginShape();
       
      pg.noFill();
      pg.stroke(colors[1]);
      pg.strokeWeight((int) random(4));
       
      pg.curveVertex(prevx - i * 2, prevy - i * 2);
      pg.curveVertex(prevx - i * 2, prevy - i * 2);
       
      pg.curveVertex(x + 2 * sin(v) * noise(xoff), y + 2 * cos(v) * noise(xoff));
       
      pg.curveVertex(x - i * 2, y - i * 2);
      pg.curveVertex(x - i * 2, y - i * 2);
       
      pg.endShape();
    }

    pg.endDraw();

    image(pg, 0, 0);

    //noStroke();
    //rect(x, y, 2, 2);
    
    v += 0.125;
    xoff += 0.125;

    delay(500);
  }
}
