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

// Color Harmony library: https://github.com/cageehv/ColorHarmony/
import com.cage.colorharmony.*;

// Create a colorharmony instance
ColorHarmony colorHarmony = new ColorHarmony(this);
color[] colors = colorHarmony.Analogous();

// PG code from the Processing tutorials
PGraphics pg;

float easing = 0.05;
float xoff = random(3.75);

Brush[] brushes = new Brush[1];

void setup() {
  fullScreen();
  //size(640, 480);
  noCursor();
  smooth();

  pg = createGraphics(width, height);

  for(int i = 0; i < brushes.length; i++) {
    brushes[i] = new Brush(1);
  }
  
  background(colors[0]);
  frameRate(25);
}

void draw() {
  for(int i = 0; i < brushes.length; i++) {
    brushes[i].render();
    brushes[i].update();
  }
}

class Brush {
  boolean left_to_right, top_to_bottom;
  int strands, lifetime, points, iterations;
  float v, x, y, dx, dy, prevx, prevy, targetx, targety;
  
  Brush(int _strands) {
    strands = _strands;

    init();
  }

  void init() {
    v = random(-1, 1);
    x = random(50, width);
    y = random(50, height);
    
    prevx = x;
    prevy = y;

    points = 5;
    iterations = 1;
    lifetime = (int) random(30);

    delay(500);
    colors = colorHarmony.GetRandomPalette();
 
    // Pick a target, course, and stay with it
    if (x < width/2) {
      left_to_right = true;
      targetx = x + 200;
    } else {
      left_to_right = false;
      targetx = x - 200;
    }
    
    if (y < height/2) {
      top_to_bottom = true;
      targety = y + 200;
    } else {
      top_to_bottom = false;
      targety = y - 200;
    }

    println("start");
    println(x, y, targetx, targety);
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

    println(left_to_right, top_to_bottom);
    println(x, y, lifetime);

    lifetime--;
    if (lifetime == 0) {
      init();
    }

    iterations++;
    if (iterations % 3 == 0) {
      delay(5000);
    }

    v += v;
  }
  
  void render() {
    pg.beginDraw();
    
    if (random(100) > 99) {
      pg.fill(colors[1]);
    } else {
      pg.noFill();
    }
    pg.stroke(colors[1]);

    // thinner/fatter brushes
    float weight = (int) random(5);
    weight = 3;
    pg.strokeWeight(weight);

    pg.beginShape();
    pg.vertex(prevx, prevy);

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
    
    //pg.quadraticVertex(targetx/2, targety/2, x, y);
    
    pg.vertex(x, y);
    
    pg.endShape();
    pg.endDraw();

    image(pg, 0, 0);
    
    //noStroke();
    //rect(x, y, 2, 2);
    
    delay(1000);
  }
}
