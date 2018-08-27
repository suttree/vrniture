int numRects = 8;
Rectangle[] rectangles = new Rectangle[numRects];

int frames = 0;
int totalFrames = 440;

void setup() {
  //size(640, 480);
  fullScreen();
  noCursor();

  for(int i = 0; i < numRects; i++) {
    rectangles[i] = new Rectangle(width, height);
  }
}

void draw() {  
  noStroke();
  fill(7, 75);
  rect(0, 0, width, height);
  
  stroke(27);
  fill(255);
  
  if(frameCount % 12 == 0) {
    rectangles = new Rectangle[numRects];
    for(int i = 0; i < numRects; i++) {
      rectangles[i] = new Rectangle(width, height);
    }
  }

  for(int i = 0; i < rectangles.length; i++) {
    float rX1 = rectangles[i].x;
    float rY1 = rectangles[i].y;
    float rW1 = rectangles[i].w;
    float rH1 = rectangles[i].h;

    for(int j = i+1; j < rectangles.length; j++) {
      float rX2 = rectangles[j].x;
      float rY2 = rectangles[j].y;
      float rW2 = rectangles[j].w;
      float rH2 = rectangles[j].h;
      
      boolean hit = rectRect(rX1, rY1, rW1, rH1, rX2, rY2, rW2, rH2);
      
      if (hit) {
        rectangles[i].stroke = 225;
        rectangles[i].fill = 225;
        rectangles[j].stroke = 225;
        rectangles[j].fill = 225;
      }
    }
  }
  
  for(int i = 0; i < rectangles.length; i++) {
    rectangles[i].render();
  }

  delay(125);
  
  //saveFrame("line-######.png");
}

class Rectangle {
    float x;
    float y;
    float w;
    float h;
    int stroke = 250;
    int fill = 255;
    
  Rectangle(int width, int height) {
    x = random(40, width);
    y = random(40, height);
    w = random(40, width/2);
    h = random(40, height/2);
  }
  
  void render() {
    stroke(stroke);
    fill(fill);
    rect(x, y, w, h);
  }
}

// From http://www.jeffreythompson.org/collision-detection/rect-rect.php
boolean rectRect(float r1x, float r1y, float r1w, float r1h, float r2x, float r2y, float r2w, float r2h) {
  // are the sides of one rectangle touching the other?
  if (r1x + r1w >= r2x &&    // r1 right edge past r2 left
      r1x <= r2x + r2w &&    // r1 left edge past r2 right
      r1y + r1h >= r2y &&    // r1 top edge past r2 bottom
      r1y <= r2y + r2h) {    // r1 bottom edge past r2 top
        return true;
  }
  return false;
}
