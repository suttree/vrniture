// Color Harmony library: https://github.com/cageehv/ColorHarmony/
import com.cage.colorharmony.*;
//import colorharmony.*;

// Create a colorharmony instance
ColorHarmony colorHarmony = new ColorHarmony(this);
color[] colors = colorHarmony.Triads();
color bg;
color c;

float y = -10;
float head = 0.0;
float rotate = random(-0.002, 0.002);

void setup() {
  fullScreen();
  //size(640, 480);
  noCursor();
}

void draw() {
  bg = colors[0];
  noStroke();
  fill(bg, 1);
  rect(0, 0, width, height);
 
  c = colors[1];
  stroke(c);
  strokeWeight( random(10, 30) );

  pushMatrix();
  rotate( rotate );
  line(-100, y, width + 100, (y + noise(y) * 25) );
  popMatrix();
  
  y = y + random(-1, 3);
  
  if (y > height) {
    y = random(-10, -4);
    colors = colorHarmony.Triads();
  }
}
