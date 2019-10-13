/*

just use one brush
draw a long curve with five points
then add in strands
then make it random
- curve length
- number of points
- number of strands


draw n lines close to one another
lots of n = long line/thick brush
few n = short line/thin brush
short line = few loops
long line = many loops
vary the shade, use hsl colouring?
pick starting position and colour
random number of points
random directions
+use curve or vertex or shape not line+
+use target destination and easing for a final line at the end of the curve/shape?
repeat several times, moving the starting position slightly
pause
add a transp. layer over the top
repeat from top

3 to 5 strokes from one starting position
pause beteween each
then change colour
find new starting position

lots of short strokes
shorter strokes are thinner
a few long strokes
longer strokes are thinker

Brush.new(strands = 5)
brush.render
*/

// Color Harmony library: https://github.com/cageehv/ColorHarmony/
import com.cage.colorharmony.*;

// Create a colorharmony instance
ColorHarmony colorHarmony = new ColorHarmony(this);
color[] colors = colorHarmony.Analogous();

// PG code from the Processing tutorials
PGraphics pg;

Brush[] brushes = new Brush[1];

void setup() {
  fullScreen();
  //size(640, 480);
  noCursor();
  smooth();

  pg = createGraphics(width, height);

  for(int i = 0; i < brushes.length; i++) {
    brushes[i] = new Brush((int) random(5));
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

/*
draw n lines close to one another
lots of n = long line/thick brush
few n = short line/thin brush
short line = few loops
long line = many loops
vary the shade, use hsl colouring?
pick starting position and colour
random number of points
random directions
+use curve or vertex or shape not line+
+use target destination and easing for a final line at the end of the curve/shape?
repeat several times, moving the starting position slightly
pause
add a transp. layer over the top
repeat from top

3 to 5 strokes from one starting position
pause beteween each
then change colour
find new starting position

lots of short strokes
shorter strokes are thinner
a few long strokes
longer strokes are thinker
*/
class Brush {
  int strands, lifetime, points;
  float v, x, y, prevx, prevy;
  float easing = random(0.5);
  float xoff = random(3.75);
  
  Brush(int _strands) {
    strands = _strands;
    v = random(-1, 1);
    x = random(50, width);
    y = random(50, height);
    
    // don't need both here?
    // thicker brushes are longer?
    lifetime = strands * 50;
    points = lifetime;
  }
  
  void update() {
    prevx = x;
    prevy = y;
    
    x = x + 2 * sin(v) * noise(xoff);
    y = y + 2 * cos(v) * noise(xoff);
    println(x, y, lifetime);
    
    v += v;
    xoff = xoff + 0.125;

    if (lifetime == 0) {
      // pause and reset
      delay(500);
      colors = colorHarmony.GetRandomPalette();
      strands = (int) random(5);
      lifetime = strands * 50;
      x = random(50, width);
      y = random(50, height);
      v = random(-1, 1);
      prevx = x;
      prevy = y;
      println("---");
      println(x, y, prevx, prevy);
    } else {
      lifetime = lifetime - 1;
    }
  }
  
  void render() {
    pg.beginDraw();
    pg.stroke(colors[1]);

    // thinner/fatter brushes
    float weight = map(strands, 0, 5, 0, 4);
    pg.strokeWeight(weight);

    pg.beginShape();
    pg.curveVertex(prevx, prevy);

    for(int i = 0; i < strands; i++) {
      // shift the x and y
      //float _x = x + (i * sin(v));
      //float _y = y - (i * cos(v));
      float _x = x + i * 2 * cos(v);
      float _y = y - i * 2 * sin(v);
      
      pg.stroke(colors[3], 10 * i);
      pg.curveVertex(_x, _y);
      //println(_x, _y);
    }

    pg.stroke(colors[1]);
    pg.curveVertex(x + (x * easing)/2, y + (y * easing)/2);
    pg.curveVertex(x, y);

    pg.endShape();
    pg.endDraw();

    image(pg, 0, 0);
    
    //noStroke();
    //rect(x, y, 2, 2);
    
    delay(200);
  }
}
