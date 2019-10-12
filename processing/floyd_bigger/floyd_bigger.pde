// Color Harmony library: https://github.com/cageehv/ColorHarmony/
import com.cage.colorharmony.*;

// Create a colorharmony instance
ColorHarmony colorHarmony = new ColorHarmony(this);
color[] colors = colorHarmony.GetRandomPalette();
color[] colors2 = colorHarmony.Analogous();

int numTriangles = 5;
Triangle[] triangles = new Triangle[numTriangles];

int size = 512;
int biggifier = (height > width ? height + 1550 : width + 1550);

int[] rotations = { 6, 45, 80, 69, 70, 12, 44, 99, 118, 161, 225, 256, 294, 359, 745 };
int rotation = rotations[ int(random(rotations.length)) ];


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
  
  println(rotation);
  
  x1 = width/2 - size*4;
  y1 = biggifier + height - size*2;
  x2 = width/2;
  y2 = -biggifier + size*2;
  x3 = width/2 + size*4;
  y3 = biggifier + height - size*2;
  
  triangles[0] = new Triangle(x1, y1, x2, y2, x3, y3);
  triangles[1] = new Triangle(x1 + 40, y1 - 20, x2, y2 + 40, x3 - 40, y3 - 20);
  triangles[2] = new Triangle(x1 + 80, y1 - 40, x2, y2 + 80, x3 - 80, y3 - 40);
  triangles[3] = new Triangle(x1 + 90, y1 - 50, x2, y2 + 90, x3 - 90, y3 - 50);
  triangles[4] = new Triangle(x1 + 100, y1 - 60, x2, y2 + 100, x3 - 100, y3 - 60);
  
  frameRate(10);
  delay(25);
}

void draw() {
  blendMode(BLEND);
  noStroke();
  fill(colors[0], 24);
  rect(0, 0, width, height);
  blendMode(ADD);

  for(int i = 0; i < triangles.length; i++) {
    triangles[i].render();
  }

  // Reset colours
  if ( frameCount % 280 == 0 ) {
    colors = colorHarmony.GetRandomPalette();
  }
 
  if ( frameCount % 100 == 0 ) {
    int val = round(random(5));                                                                      
    if(val == 0) {
      colors2 = colorHarmony.Monochromatic();
    } else if (val == 1) {
      colors2 = colorHarmony.Analogous();
    } else if (val == 2) {
      colors2 = colorHarmony.Complementary();
    } else if (val == 3) {
      colors2 = colorHarmony.Triads();
    } else if (val == 4) {
      colors2 = colorHarmony.GetRandomPalette();
    } else {
      // stay the same colour for a while longer...
    }
  }
  
  if ( frameCount % 320 == 0 ) {
    triangles[0].changeColour();
  }
  
  if ( frameCount % 240 == 0 ) {
    triangles[1].changeColour();
  }
  
  if ( frameCount % 180 == 0 ) {
    triangles[2].changeColour();
  }
  
  if ( frameCount % 160 == 0 ) {
    triangles[3].changeColour();
  }
  
  if ( frameCount % 140 == 0 ) {
    triangles[4].changeColour();
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
    colour = colors2[(int)random(colors2.length)];
  }
  
  void render() {
    fill(colour, 9);
    stroke(colour, 22);
    strokeWeight(1.75 + sin(v));

    rotate( rotation );
    triangle(x1, y1, x2, y2, x3, y3);
    
    v += 0.0915;
  }
}
