int numSpots = 8;
Spot[] spots = new Spot[numSpots];

int frames = 0;
int totalFrames = 440;

void setup() {
  fullScreen();
  noCursor();

  for(int i = 0; i < numSpots; i++) {
    spots[i] = new Spot(width, height);
  }
}

void draw() {  
  noStroke();
  fill(7, 75);
  rect(0, 0, width, height);
  
  stroke(27);
  fill(255);
  
  if(frameCount % 12 == 0) {
    spots = new Spot[numSpots];
    for(int i = 0; i < numSpots; i++) {
      spots[i] = new Spot(width, height);
    }
  }

  for(int i = 0; i < spots.length; i++) {
    float cX1 = spots[i].x;
    float cY1 = spots[i].y;
    float cSize1 = spots[i].size;

    for(int j = i+1; j < spots.length; j++) {
      float cX2 = spots[j].x;
      float cY2 = spots[j].y;
      float cSize2 = spots[j].size;
        
      boolean hit = circleCircle(cX1, cY1, cSize1, cX2, cY2, CSize2);
      
      if (hit) {
        spots[i].stroke = 215;
        spots[i].fill = 215;

        spots[j].stroke = 215;
        spots[j].fill = 215;
      }
    }
  }
  
  for(int i = 0; i < spots.length; i++) {
    spots[i].render();
  }

  delay(125);
}

class Spot {
    float x;
    float y;
    int size;
    int stroke = 250;
    int fill = 255;
    
  Spot(int width, int height) {
    x = random(40, width);
    y = random(40, height);
    size = (width > height) ? width : height;
  }
  
  void render() {
    stroke(stroke);
    fill(fill);
    circle(x, y, size);
  }
}

# From https://happycoding.io/tutorials/processing/collision-detection#circle-circle-collision:w
boolean circleCircle(float cX1, float cY1, int cSize1, float cX2, float cY2, int cSize2) {
  if( dist(cX1, cY1, cX2, cY2) < cSize1 + cSize2 ) {
    return true;
  }
  return false;
}
