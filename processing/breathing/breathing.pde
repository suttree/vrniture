// Color Harmony library: https://github.com/cageehv/ColorHarmony/
import com.cage.colorharmony.*;

// Create a colorharmony instance
ColorHarmony colorHarmony = new ColorHarmony(this);
color[] colors = colorHarmony.GetRandomPalette();

int numCircles = 4;
Circle[] circles = new Circle[numCircles];

void setup() {
  fullScreen();
  //size(640, 480, P3D);

  noCursor();

  for(int i = 0; i < numCircles; i++) {
    circles[i] = new Circle(width, height, i+1);
  }
}

void draw() {  
  noStroke();
  fill(0, 20);
  rect(0, 0, width, height);

  // Reset circles (very infrequently)
  if(frameCount % 1000 == 0) {
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
  if ( frameCount % 250 == 0 ) {
    colors = colorHarmony.GetRandomPalette();
  }
  
  delay(125);
}

class Circle {
  float x;
  float y;
  float easing = 0.05;

  int gap;
  int size;
  int sizeCounter;
  int maxSize;

  color colour;
    
  Circle(int width, int height, int sizeCounter) {
    x = width/2 - random(0, 25);
    y = height/3 + random(0, 25);
    
    size = (width > height) ? (int)random(10, width/2 - 500/sizeCounter) : (int)random(10, height/2 - 200/sizeCounter);
    maxSize = size + (int)random(size/4, size/3);

    colour = colors[(int)random(8)];
  }
  
  void render() {
    fill(colour, 5);

    // TODO
    // modify size to emulate breathing
    // use easing functions from here: http://processingjs.org/learning/basic/easing/
    // inhale/exhale for the count of three
    gap = maxSize - size;
    if (size > maxSize || size > 0) {
      size -= gap * easing;
    } else {
      size += gap * easing;
    }

    ellipse(x, y, size, size);
  }
}
