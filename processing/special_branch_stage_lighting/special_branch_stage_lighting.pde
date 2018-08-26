int numRects = 8;
Rectangle[] rectangles = new Rectangle[numRects];

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
    for(int j = 1; j < rectangles.length-1; j++) {
      float rX1 = rectangles[i].x;
      float rY1 = rectangles[i].y;
      float rW1 = rectangles[i].w;
      float rH1 = rectangles[i].h;
      
      float rX2 = rectangles[j+1].x;
      float rY2 = rectangles[j+1].y;
      float rW2 = rectangles[j+1].w;
      float rH2 = rectangles[j+1].h;
      
      if (rectRectIntersect(rX1, rY1, rX1+rW1, rY1+rH1, rX2, rY2, rX2+rW2, rY2+rH2) == true) {
        //rectangles[i].render();
      } else {
        rectangles[j].render();
      }
    }
  }

  delay(125);
}

class Rectangle {
    float x;
    float y;
    float w;
    float h;
    int stroke = 27;
    int fill = 255;
    
  Rectangle(int width, int height) {
    x = random(width);
    y = random(height);
    w = random(0, width/2);
    h = random(0, height/2);
  }
  
  void render() {
    stroke(stroke);
    fill(fill);
    rect(x, y, w, h);
  }
}

boolean rectRectIntersect(float left, float top, float right, float bottom, 
                          float otherLeft, float otherTop, float otherRight, float otherBottom) {
  return !(left > otherRight || right < otherLeft || top > otherBottom || bottom < otherTop);
}
