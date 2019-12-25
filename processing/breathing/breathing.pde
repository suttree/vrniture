// Color Harmony library: https://github.com/cageehv/ColorHarmony/
import com.cage.colorharmony.*;

// Create a colorharmony instance
ColorHarmony colorHarmony = new ColorHarmony(this);
color[] colors = colorHarmony.Triads();

int numCircles = (int) random(1,6);
Circle[] circles = new Circle[numCircles];

void setup() {
  fullScreen();
  //size(640, 480, P3D);

  noCursor();

  for(int i = 0; i < numCircles; i++) {
    circles[i] = new Circle(width, height, i+1);
  }

  noStroke();
  fill(0);
  rect(0, 0, width, height);

  delay( (int) random(3000, 6000) );
}

void draw() {  
  noStroke();
  fill(0, 20);
  rect(0, 0, width, height);

  // Reset circles (very infrequently)
  if(frameCount > 0 && frameCount % 1000 == 0) {
    numCircles = (int) random(2,7);
    circles = new Circle[numCircles];
    for(int i = 0; i < numCircles; i++) {
      circles[i] = new Circle(width, height, i+1);
    }
  }
  
  // Render
  for(int i = 0; i < circles.length; i++) {
    circles[i].render();
  }

  // Reset colours
  if ( frameCount > 0 && frameCount % 1250 == 0 ) {
    colors = colorHarmony.GetRandomPalette();
  }
  
  delay(125);
}

class Circle {
  float x;
  float y;
  float v; // sin value

  int gap;
  int sizeCounter;

  color colour;
    
  Circle(int width, int height, int sizeCounter) {
    x = width/2 - random(0, 55);
    y = height/3 + random(0, 80);
    colour = colors[(int)random(8)];
  }
  
  void render() {
    fill(colour, 5);

    // From https://www.openprocessing.org/sketch/108563/
    float size = 193 + 220 * sin(v) + 70;
    ellipse(x, y, size, size);
    
    v += 0.126;
  }
}
