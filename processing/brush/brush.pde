// Color Harmony library: https://github.com/cageehv/ColorHarmony/
import com.cage.colorharmony.*;

// Create a colorharmony instance
ColorHarmony colorHarmony = new ColorHarmony(this);
color[] colors = colorHarmony.Analogous();

// PG code from the Processing tutorials
PGraphics pg;

IntList dirs;

int corner, dir;
float easing = 0.05;
float xoff = random(3.75);
float t, x, y, prevx, prevy;

void setup() {
  fullScreen();
  //size(640, 480);
  noCursor();

  pg = createGraphics(width, height);

  dirs = new IntList(0,1,2,3);
  
  // Choose a corner
  /*
  corner = (int) random(3);
  
  if (corner == 0) {
    x = 0;
    y = 0;
  } else if (corner == 1) {
    x = width;
    y = 0;
  } else if (corner == 2) {
    x = width;
    y = height;
  } else if (corner == 3) {
    x = 0;
    y = height;
  }
  */
  x = -10;
  y = -10;
  prevx = x;
  prevy = y;
  
  dir = (int) random(4);
  //frameRate(10);
  //delay(25);
}

void draw() {
  background(colors[0]);

  pg.beginDraw();
  pg.stroke(colors[3]);
  pg.strokeWeight(2);
  /*
  //pg.line(prevx + prevx * easing, prevy + prevy * easing, x, y);
  pg.line(prevx, prevy, x, y);
  //println(prevx, prevy, x + prevx * easing, y + prevy * easing);
  //println(prevx + prevx * easing, prevy + prevy * easing, x, y);
  
//  vertex(i, y + (noise(xoff) * 100));
//      xoff = xoff + 0.04;
  pg.line(prevx + (noise(xoff) * 100), prevy + (noise(xoff) * 100), x, y);
  */
  pg.beginShape();
  pg.vertex(prevx, prevy);
  
  if (frameCount % 100 == 0) {
    dirs.remove(dir); // remove current direction
    dirs.shuffle();
    dir = dirs.get(0);
    println(dir);
    dirs = new IntList(0,1,2,3);
  }

  
  int dist = 2;
  /*
  //dir =1;
  if (dir == 0) {
    // +x, +y
    x = x + (noise(xoff) * dist * easing);
    y = y + (noise(xoff) * dist * easing);
  } else {
    // -x, -y
    x = x - noise(xoff) * dist;
    y = y - (noise(xoff) * dist * easing);
    println(x);
    println(x - noise(xoff) * dist);
    println("---");
  }
  */
  if (dir == 0) {
    // +x, +y
    x = x + noise(xoff) * dist;
    y = y + noise(xoff) * dist;
  } else if (dir == 1) {
    // + x, -y
    x = x + noise(xoff) * dist;
    y = y - noise(xoff) * dist;
  } else if (dir == 2) {
    // -x, +y
    x = x - noise(xoff) * dist;
    y = y + noise(xoff) * dist;
  } else if (dir == 3) {
    // -x, -y
    x = x - noise(xoff) * dist;
    y = y - noise(xoff) * dist;
  }
  pg.vertex(x, y);
  
  pg.endShape();
  pg.endDraw();

  image(pg, 0, 0);

  // draw brush marker
  //stroke(colors[1]);
  noStroke();
  rect(x, y, 2, 2);
  
  x = x + noise(t)*2;
  y = y + noise(t)*2;
  t = t + 0.176;
  
  if (x > width || x < 0) {
    x = (int) random(width);
  }
  
  if ( y > height || y < 0) {
    y = (int) random(height);
  }
  prevx = x;
  prevy = y;
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

Brush.new(strands = 5)
brush.render

*/
