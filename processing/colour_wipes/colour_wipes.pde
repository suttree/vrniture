// Color Harmony library: https://github.com/cageehv/ColorHarmony/
import com.cage.colorharmony.*;

// Create a colorharmony instance
ColorHarmony colorHarmony = new ColorHarmony(this);
color[] colors = colorHarmony.Triads();
color bg;
color c;

int y = -2;
int head = 0;

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
  strokeWeight(4);
  pushMatrix();
  rotate(0);
  line(0, y, head, y);
  popMatrix();
  head = head + 5;
  
  if (head > width) {
    y = y + 2;
  }
  
  if (y > height) {
    y = 0;
    colors = colorHarmony.Triads();
  }
}
