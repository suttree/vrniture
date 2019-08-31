// Color Harmony library: https://github.com/cageehv/ColorHarmony/
import com.cage.colorharmony.*;

// Create a colorharmony instance
ColorHarmony colorHarmony = new ColorHarmony(this);
color[] colors = colorHarmony.Triads();

int numTriangles = 2;
Triangle[] triangles = new Triangle[numTriangles];

int size = 75;

float x1;
float y1;
float x2;
float y2;
float x3;
float y3;

void setup() {
  fullScreen();
  //size(640, 480, P3D);

  noCursor();
  
  x1 = width/2 - size*2;
  y1 = height - size;
  x2 = width/2;
  y2 = 0 + size;
  x3 = width/2 + size*2;
  y3 = height - size;
  
  triangles[0] = new Triangle(x1, y1, x2, y2, x3, y3);
  triangles[1] = new Triangle(x1 + 10, y1 - 5, x2, y2 + 10, x3 - 10, y3 - 5);

  /*
  for(int i = 0; i < numTriangles; i++) {
    triangles[i] = new Triangle(x1, y1, x2, y2, x3, y3);
  }
  */
}

void draw() {  
  noStroke();
  fill(colors[0], 25);
  rect(0, 0, width, height);

  for(int i = 0; i < triangles.length; i++) {
    triangles[i].render();
  }

  // Reset colours
  if ( frameCount % 600 == 0 ) {
    colors = colorHarmony.GetRandomPalette();
  }
  
  //delay(125);
}

class Triangle {
  float x1;
  float y1;
  float x2;
  float y2;
  float x3;
  float y3;
  float v; // sin value

  color colour;
    
  Triangle(float _x1, float _y1, float _x2, float _y2, float _x3, float _y3) {
    x1 = _x1;
    y1 = _y1;
    x2 = _x2;
    y2 = _y2;
    x3 = _x3;
    y3 = _y3;
    
    colour = colors[(int)random(8)];
  }
  
  void render() {
    noFill();
    stroke(colour, 15);
    strokeWeight(3.0 + sin(v));

    triangle(x1, y1, x2, y2, x3, y3);
    
    v += 0.314159;
  }
}
