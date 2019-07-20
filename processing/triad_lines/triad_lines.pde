// Color Harmony library: https://github.com/cageehv/ColorHarmony/
import com.cage.colorharmony.*;

// Create a colorharmony instance
ColorHarmony colorHarmony = new ColorHarmony(this);
color[] colors = colorHarmony.Triads();
color bg = colors[0];
color c;

int x = 10;
int y = 0;
int x2 = x;
int gap = 10;
float t = random(0.0, 1.0);
float dist = 0.0;

void setup() {
  fullScreen();
  //size(640, 480);
  noCursor();
  rotate(45);
}

void draw() {
  noStroke();
  fill(bg, 2);
  rect(0, 0, width, height);
 
  dist = noise(t) * 6;
  
  // Draw the next line
  if (y > height - gap * 2  - dist) {
    y = x;
    x = x + gap * (int)dist;
    x2 = y;
  }
  
  // Reset the line to the left
  if (x > width) {
    x = gap/2;
    colors = colorHarmony.Triads();
    bg = colors[0];
  }

  // Two tone effect
  if (x > width/2) {
    c = colors[1];
  } else {
    c = colors[2];
  }

  stroke(c);
  strokeWeight(7);
  line(x, x2, x, y + dist);
    
  // Increment vars
  y = y + gap;
  dist = dist + random(5,25);
  t = t + random(0.0025, 0.125);
}
