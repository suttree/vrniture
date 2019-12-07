// Color Harmony library: https://github.com/cageehv/ColorHarmony/
import com.cage.colorharmony.*;

// Create a colorharmony instance
ColorHarmony colorHarmony = new ColorHarmony(this);

int numLayers = 8;
int val = round(random(8));
color[] colors = colorHarmony.GetRandomPalette();

float theta = 0.0;
int points = 4;
float dist = width/2;

float t = random(0.0, 2.0);

void setup() {
  fullScreen();
  //size(640, 480, P3D);
  
  noCursor();
  //frameRate(30);
}

void draw() {
  color c = colors[(int)random(numLayers)];
  
  background(0);
  noStroke();
  fill(20, 20, 20, 90);
  rect(0, 0, width, height);

  int shapeWidth = 850;
  int shapeHeight = 850;
  int startx = 0;
  int starty = 0;
  dist = noise(t) * 30;
  translate(width/2, height/2);
  rotate(75);
  
  for(int i = 0; i < numLayers; i++) {
    c = colors[i];
    fill(c, 100 - 25 * 1);
    
    if(i % 2 == 0) {
      stroke(colors[0], 95);
    } else {
      noStroke();
    }

    // Draw the square
    beginShape();
    
    vertex(startx - dist, starty - dist);
    quadraticVertex(startx + dist, starty - dist, startx + shapeWidth, starty);
    
    vertex(startx + shapeWidth, starty);
    quadraticVertex(startx + shapeWidth - dist * 2, starty + dist, startx + shapeWidth, starty + shapeHeight);
  
    vertex(startx + shapeWidth, starty + shapeHeight);
    quadraticVertex(startx + shapeWidth - dist, starty + shapeHeight + dist, startx, starty + shapeHeight);
    
    vertex(startx, starty + shapeHeight);
    quadraticVertex(startx - dist, starty + shapeHeight - dist / 4, startx - dist, starty - dist);

    vertex(startx - dist, starty - dist);
    
    endShape(CLOSE);
    
    shapeWidth = shapeWidth + 45;
    shapeHeight = shapeHeight + 40;
    dist = dist + 25;
    t = t + random(0.0025, 0.045);
    startx = startx - 55;
    starty = starty - 50;
  }
  
  // Change the palette infrequently
  if ( frameCount % 250 == 0 ) {
    int val = round(random(4));
    if(val == 0) {
      colors = colorHarmony.Monochromatic();
    } else if (val == 1) {
      colors = colorHarmony.GetRandomPalette();
    } else if (val == 2) {
      colors = colorHarmony.Complementary();
    } else if (val == 3) {
      colors = colorHarmony.Triads();
    } else {
      // stay the same colour for a while longer...
    }
  }
}
