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

float easing = 0.25;
float xoff = random(3.75);

Brush[] brushes = new Brush[1];

void setup() {
  //fullScreen();
  size(640, 480);
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
      targetx = x + (int) random(100, 300);
    } else {
      left_to_right = false;
      targetx = x - (int) random(100, 300);
    }

    if (y < height/2) {
      top_to_bottom = true;
      targety = y + (int) random(100, 300);
    } else {
      top_to_bottom = false;
      targety = y - (int) random(100, 300);
    }

    // huh
    /*
    x = 10;
    y = 10;
    targetx = 210;
    targety = 210;
    left_to_right = true;
    top_to_bottom = true;

    println("start");
    println(x, y, targetx, targety);
    */
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

    println(left_to_right, top_to_bottom);
    println(x, y, dx, dy, lifetime);

    lifetime--;
    if (lifetime <= 0) {
      init();
    }

    iterations++;
    if (iterations % 3 == 0) {
      //delay(5000);
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

    /*
    if (random(100) > 99) {
     pg.fill(colors[1]);
     } else {
     pg.noFill();
     }
     */

    if (1 == 2 ) {
      // Straight line
      pg.fill(colors[1]); // reset
      pg.stroke(colors[1]);

      // thinner/fatter brushes
      float weight = (int) random(7);
      //weight = 3;
      pg.strokeWeight(weight);

      //println(prevx, prevy, x, y);
      //println("---");


      // REFACTOR
      // THIS IS THE CODE FOR BRUSH LINES
      // NOW WRITE THE CODE FOR BRUSH CURVES

      // TODO: Review https://processing.org/reference/beginShape_.html for different styles
      pg.beginShape();
      pg.curveVertex(prevx, prevy);
      pg.curveVertex(prevx, prevy);
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
    } else {
      pg.fill(colors[1]);
      pg.stroke(colors[1]);

      // thinner/fatter brushes
      float weight = (int) random(7);
      pg.strokeWeight(weight);

      pg.noFill();
      pg.strokeWeight(5);

      //println(prevx, prevy, x, y);
      //println("---");

      //pg.curve(5, 26, 5, 26, 73, 24, 73, 61);

      /*
      // This is a nice brush
       pg.curve(prevx, prevy, prevx, prevy, x - 4, y, x, y - 4);
       pg.curve(prevx, prevy, prevx, prevy, x + 2, y, x, y + 2);
       pg.curve(prevx, prevy, prevx, prevy, x, y, x, y);
       */

      /*
      // This is slanted lines
       pg.curve(prevx, prevy, prevx, prevy, x - dx/lifetime, y - dy/lifetime, x, y);
       */

      /*
      if (!left_to_right && top_to_bottom) {
       pg.curve(prevx, prevy, prevx, prevy, x + dx/lifetime, y + dy/lifetime, prevx + sin(v) + 10, y + cos(v) + 10);
       } else if (left_to_right && !top_to_bottom) {
       pg.curve(prevx, prevy, prevx, prevy, x + dx/lifetime, y + dy/lifetime, prevx + sin(v) - lifetime/2, y + cos(v) - lifetime/2);
       } else {
       pg.curve(prevx, prevy, prevx, prevy, x - dx/lifetime, y - dy/lifetime, prevx + sin(v) + 10, y + cos(v) + 10);
       }
       */

      /*
      pg.beginShape();
       //pg.stroke(255, 255, 242, 70);
       //pg.vertex(prevx, prevy);
       //pg.vertex(prevx, prevy);
       //pg.vertex(prevx - dx, prevy - dy);
       
       // Sort of dots....?
       pg.noStroke();
       pg.fill(colors[1]);
       pg.rect(prevx, prevy, 4, 4);
       
       println(dx, dy);
       
       if (left_to_right && top_to_bottom) {
       //pg.rect(prevx + (noise(xoff) * 20), prevy + (noise(xoff) * 50), 2, 2);
       pg.rect(targetx - dx/lifetime*10, y, 2, 2);
       xoff = xoff + 0.314;
       }
       pg.rect(x, y, 4, 4);
       
       //for(int i = 0; i < points; i ++) {
       //  pg.vertex(prevx, prevy + (noise(xoff) * 2));
       //  xoff = xoff + 0.04;
       //}
       //pg.vertex(x, y);
       pg.endShape();
       */

      /*
       pg.beginShape();
       pg.vertex(prevx, prevy);
       pg.vertex(targetx - dx/lifetime*10, y);
       pg.vertex(targetx - dx/lifetime*9, y+1);
       pg.vertex(targetx - dx/lifetime*8, y+2);
       pg.vertex(x, y);
       pg.endShape();
       */

      // Scribbles / hatching for ltf/ttb only
      /*
      float gap = 5;
      pg.noFill();
      pg.stroke(colors[1]);
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
      */
      
      float gap = 8;
      pg.beginShape();
      pg.noFill();
      pg.stroke(colors[1]);
      //pg.bezier(prevx, prevy, prevx + 10, prevy - 20, prevx + 12, prevy - 22, x, y);
      
      if (!left_to_right && top_to_bottom) {
        println("here");
        pg.bezier(prevx - cos(v) * 2, prevy + sin(v) * 2, prevx + dx/10, prevy - dx/10, prevx + dx/8 + noise(xoff) * 2, prevy - dx/8 - noise(xoff) * 2, x, y);
      } else {
        pg.bezier(prevx - cos(v) * 2, prevy + sin(v) * 2, prevx + dx/10, prevy - dx/10, prevx + dx/8 + noise(xoff) * 2, prevy - dx/8 - noise(xoff) * 2, x + sin(v) * 2, y - cos(v) * 2);
      }

      v += 0.31472;
      xoff += 0.31472;
      
      pg.endShape();

      // TODO: Review https://processing.org/reference/beginShape_.html for different styles
      //      pg.beginShape();
      //      pg.vertex(prevx, prevy);
      //rect(prevx, prevy, 2, 2);

      //pg.vertex(20, 20);
      //pg.quadraticVertex(prevx, prevy + 60, prevx + 60, prevy + 60);
      //pg.quadraticVertex(prevx + 40, prevy, prevx + 30, prevy + 30);
      //pg.quadraticVertex(prevx + 40, prevy, x, y);
      //pg.vertex(80, 60);

      /*
      //pg.curveVertex(x-sin(v), y);
       pg.quadraticVertex(prevx, prevy, prevx + 2, y);
       pg.quadraticVertex(prevx, prevy, prevx + 4, y);
       pg.quadraticVertex(prevx, prevy, prevx + 6, y);
       pg.quadraticVertex(prevx, prevy, prevx + 8, y);
       //pg.quadraticVertex(prevx, prevy, x-30, y);
       */

      //prevx = prevx - 20;

      //pg.vertex(x, y);

      if (debug) {
        rect(x, y, 2, 2);
      }
    }
    /*
     pg.noFill();
     pg.strokeWeight(4);
     pg.beginShape();
     pg.vertex(20, 20);
     pg.quadraticVertex(80, 20, 50, 50);
     pg.quadraticVertex(20, 80, 80, 80);
     pg.vertex(80, 60);
     pg.endShape();
     */

    /*
    // TODO make the strands, vary the x&y a little, and the hsl
     // Use fill for main strand and noFill() for strands
     for(int i = 0; i < strands; i++) {
     pg.beginShape();
     
     pg.noFill();
     pg.strokeWeight((int) random(3));
     
     pg.curveVertex(prevx - i * 2, prevy - i * 2);
     pg.curveVertex(prevx - i * 2, prevy - i * 2);
     
     pg.curveVertex(x + 2 * sin(v) * noise(xoff), y + 2 * cos(v) * noise(xoff));
     
     pg.curveVertex(x - i * 2, y - i * 2);
     pg.curveVertex(x - i * 2, y - i * 2);
     
     pg.endShape();
     }
     */

    pg.endDraw();

    image(pg, 0, 0);

    //noStroke();
    //rect(x, y, 2, 2);

    delay(1000);
  }
}
