/*

just use one brush
draw a long curve with five points
then add in strands
then make it random
- curve length
- number of points
- number of strands
*/

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

float easing = 0.025;
float xoff = random(3.75);

Brush[] brushes = new Brush[1];

void setup() {
  background(48, 48, 48);
  frameRate(12);
  
  fullScreen();
  //size(640, 480);
  noCursor();
  smooth();

  pg = createGraphics(width, height);

  for(int i = 0; i < brushes.length; i++) {
    brushes[i] = new Brush(1);
  }
}

void draw() {
  for(int i = 0; i < brushes.length; i++) {
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
    v = random(-5, 5);
    x = (int) random(24, width - (int) random(5, 50));
    y = (int) random(23, height - (int) random(5, 50));
    
    prevx = x - (int) random(1, 4);
    prevy = y - (int) random(1, 4);

    points = 40;
    iterations = 24;
    lifetime = (int) random(12, 65);

    delay((int) random(2550));
    colors = colorHarmony.Triads(color(0, 0, 0));
 
    // Pick a target, course, and stay with it
    if (x < width/2) {
      left_to_right = true;
      targetx = x + (int) random(100, 200);
    } else {
      left_to_right = false;
      targetx = x - (int) random(100, 200);
    }
    
    if (y < height/2) {
      top_to_bottom = true;
      targety = y + (int) random(100, 200);
    } else {
      top_to_bottom = false;
      targety = y - (int) random(100, 200);
    }

    //println("start");
    //println(x, y, targetx, targety);
  }
   
  void update() {
    prevx = x;
    prevy = y;
    
    // Find our way to the target
    if (left_to_right) {
      //x = x + 2 * sin(v) * noise(xoff);
      dx = targetx - x;
      //println(x, dx);
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
    if (iterations % 5 == 0 && iterations > 1) {
      colors = colorHarmony.GetRandomPalette();
    }

    if (iterations % 12 == 0 && iterations > 1) {
      delay((int) random(1500, 2500));
      background(48, 48, 48);
      pg.beginDraw(); 
      pg.clear();
      pg.endDraw();
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

    if (random(100) > 95) {
      pg.fill(colors[1], 10);
    } else {
      pg.noFill();
    }
    pg.fill(colors[1]); // reset
    pg.stroke(colors[1]);

    // thinner/fatter brushes
    float weight = (int) random(8, 178);
    pg.strokeWeight(weight);

    //println(prevx, prevy, x, y);
    //println("---");


    // TODO: Review https://processing.org/reference/beginShape_.html for different styles
//    pg.beginShape();
//    pg.curveVertex(prevx, prevy);
//    pg.curveVertex(prevx, prevy);
    //rect(prevx, prevy, 2, 2);

    //pg.quadraticVertex(targetx, targety, targetx * sin(v), targety * cos(v));
    //pg.quadraticVertex(prevx, prevy, dx, dy);

    /*
    if (random(0) > 1) {
      pg.quadraticVertex(targetx, targety, targetx * cos(v), targety * sin(v));
      if (random(2) > 1) {
        pg.quadraticVertex(targetx, targety, targetx - noise(xoff), targety - noise(xoff));
      }
    }
    */
    //pg.quadraticVertex(x, y, x * cos(v), y * sin(v));
    //rect(x * cos(v), y * sin(v), 2, 2);
    
    //pg.quadraticVertex(targetx/2, targety/2, x, y);
    //rect(targetx/2, targety/2, 2, 2);
    
    //pg.vertex(x/2, y/2);
    //rect(x/2, y/2, 2, 2);
    
    // TODO: add a curve to the single line
    
    //pg.curveVertex(x+20, y+20);
    //pg.curveVertex(x-20, y-20);
    //rect(x-20, y-20, 4, 4);
    
    //pg.curveVertex(x-5, y);
    
//    if (random(2) > 1) {
//      pg.curveVertex(x - sin(v) * 40, y + cos(v));
//    } else {
//      pg.curveVertex(x + cos(v) * 80, y - sin(v));
//    }
    
    // TODO make the strands, vary the x&y a little, and the hsl
    // Use fill for main strand and noFill() for strands
    
//    pg.curveVertex(x, y);
//    pg.curveVertex(x, y);

/*
      pg.curve(prevx, prevy, prevx, prevy, x - 4, y, x, y - 4);
      pg.curve(prevx, prevy, prevx, prevy, x + 2, y, x, y + 2);
      pg.curve(prevx, prevy, prevx, prevy, x, y, x, y);
*/      
      
      // Curves
      pg.beginShape();
      
      pg.noFill();
      pg.stroke(colors[1]);
      
      //float weight = (int) random(8, 20);
      pg.strokeWeight(weight);
      
      // From https://www.openprocessing.org/sketch/579889
      if (!left_to_right && top_to_bottom) {
        pg.bezier(prevx - cos(v) * 2, prevy + sin(v) * 4, prevx + dx/10, prevy - dx/10, prevx + dx/8 + noise(xoff) * 2, prevy - dx/8 - noise(xoff) * 4, x, y);
      } else {
        pg.bezier(prevx - cos(v) * 2, prevy + sin(v) * 4, prevx + dx/10, prevy - dx/10, prevx + dx/8 + noise(xoff) * 2, prevy - dx/8 - noise(xoff) * 4, x + sin(v) * 2, y - cos(v) * 2);
      }

      //v += 0.31472;
      //xoff += 0.31472;
      
      pg.endShape();

    if (debug) {
      rect(x, y, 2, 2);
    }
    
    pg.endShape(CLOSE);
    
    
    // Use fill for main strand and noFill() for strands
    for(int i = 0; i < strands; i++) {
      pg.beginShape();
       
      pg.noFill();
      pg.stroke(colors[1]);
      pg.strokeWeight((int) random(14, 32));
       
      pg.curveVertex(prevx - i * sin(20), prevy - i * 20);
      pg.curveVertex(prevx - i * 10, prevy - i * 10);
       
      pg.curveVertex(x + 20 * sin(v) * noise(xoff), y + 20 * cos(v) * noise(xoff));
       
      pg.curveVertex(x - i * cos(20), y - i * 20);
      pg.curveVertex(x - i * 10, y - i * 10);
       
      pg.endShape();
    }
    
    
    pg.endDraw();

    image(pg, 0, 0);
    
    //noStroke();
    //rect(x, y, 2, 2);
    
    v += 0.125;
    xoff += 0.125;
    
    delay((int) random(120, 240));
  }
}
