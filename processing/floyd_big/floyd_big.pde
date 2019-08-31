// Color Harmony library: https://github.com/cageehv/ColorHarmony/
import com.cage.colorharmony.*;

// Create a colorharmony instance
ColorHarmony colorHarmony = new ColorHarmony(this);
color[] colors = colorHarmony.GetRandomPalette();
color[] colors2 = colorHarmony.GetRandomPalette();

int numTriangles = 2;
Triangle[] triangles = new Triangle[numTriangles];

int size = 155;
int biggifier = (height > width ? height + 550 : width + 550);

float x1;
float y1;
float x2;
float y2;
float x3;
float y3;

void setup() {
  fullScreen();
  //size(640, 480);

  noCursor();
  
  x1 = width/2 - size*4;
  y1 = biggifier + height - size*2;
  x2 = width/2;
  y2 = -biggifier + size*2;
  x3 = width/2 + size*4;
  y3 = biggifier + height - size*2;
  
  triangles[0] = new Triangle(x1, y1, x2, y2, x3, y3);
  triangles[1] = new Triangle(x1 + 20, y1 - 10, x2, y2 + 20, x3 - 20, y3 - 10);

  /*
  for(int i = 0; i < numTriangles; i++) {
    triangles[i] = new Triangle(x1, y1, x2, y2, x3, y3);
  }
  */
}

void draw() {  
  noStroke();
  fill(colors[0], 5);
  rect(0, 0, width, height);

  for(int i = 0; i < triangles.length; i++) {
    triangles[i].render();
  }

  // Reset colours
  if ( frameCount % 500 == 0 ) {
    colors = colorHarmony.GetRandomPalette();
  }
  
  if ( frameCount % 180 == 0 ) {  
    for(int i = 0; i < triangles.length; i++) {
      triangles[i].changeColour();
    }
  }
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

    changeColour();
  }
  
  void changeColour() {
    colour = colors2[(int)random(8)];
  }
  
  void render() {
    //noFill();
    fill(colour, 7);
    stroke(colour, 6);
    strokeWeight(1 + sin(v));

    triangle(x1, y1, x2, y2, x3, y3);
    
    v += 0.2;
  }
}
