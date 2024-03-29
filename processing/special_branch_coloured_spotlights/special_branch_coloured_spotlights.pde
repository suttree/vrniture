// Color Harmony library: https://github.com/cageehv/ColorHarmony/
import com.cage.colorharmony.*;

// Create a colorharmony instance
ColorHarmony colorHarmony = new ColorHarmony(this);
color[] colors = colorHarmony.GetRandomPalette();
color c;

int numSpots = 8;
Spot[] spots = new Spot[numSpots];

void setup() {
  fullScreen();
  //size(640, 480, P3D);

  noCursor();

  for(int i = 0; i < numSpots; i++) {
    spots[i] = new Spot(width, height);
  }
}

void draw() {  
  blendMode(BLEND);
  noStroke();
  fill(7, 75);
  rect(0, 0, width, height);
  blendMode(ADD);

  //stroke(27);
  fill(255);
  
  if(frameCount % 18 == 0) {
    spots = new Spot[numSpots];
    for(int i = 0; i < numSpots; i++) {
      spots[i] = new Spot(width, height);
    }
  }

  for(int i = 0; i < spots.length; i++) {
    float cX1 = spots[i].x;
    float cY1 = spots[i].y;
    int cSize1 = spots[i].size;

    for(int j = i+1; j < spots.length; j++) {
      float cX2 = spots[j].x;
      float cY2 = spots[j].y;
      int cSize2 = spots[j].size;
        
      boolean hit = circleCircle(cX1, cY1, cSize1, cX2, cY2, cSize2);
      
      if (hit) {
        //spots[i].stroke = spots[i].colour;
        spots[i].fill = spots[i].colour;
      } else {
        //spots[j].stroke = spots[i].colour;
        spots[j].fill = 225;
      }
    }
  }
  
  for(int i = 0; i < spots.length; i++) {
    spots[i].render();
  }

  if ( frameCount % 250 == 0 ) {
    colors = colorHarmony.GetRandomPalette();
  }
  
  delay(125);
}

class Spot {
  float x;
  float y;
  int size;
  int stroke = 18;
  int fill = 255;
  color colour;
    
  Spot(int width, int height) {
    x = random(40, width);
    y = random(40, height);
    size = (width > height) ? (int)random(1, width - 100) : (int)random(1, height - 100);
    colour = colors[(int)random(8)];
  }
  
  void render() {
    strokeWeight(2);
    stroke(stroke);
    fill(fill);
    ellipse(x, y, size, size);
  }
}

// From https://happycoding.io/tutorials/processing/collision-detection#circle-circle-collision:w
boolean circleCircle(float cX1, float cY1, int cSize1, float cX2, float cY2, int cSize2) {
  if( dist(cX1, cY1, cX2, cY2) < cSize1 + cSize2 ) {
    return true;
  }
  return false;
}
