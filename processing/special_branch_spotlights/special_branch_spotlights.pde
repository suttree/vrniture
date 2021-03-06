int numSpots = (int) random(2, 3);
Spot[] spots = new Spot[numSpots];

void setup() {
  fullScreen();
  //size(640, 480, P3D);

  noCursor();

  for (int i = 0; i < numSpots; i++) {
    spots[i] = new Spot(width, height);
  }

  //frameRate(32);
}

void draw() {  
  noStroke();
  fill(7, 85);
  rect(0, 0, width, height);

  //stroke(27);
  fill(255);

  if (frameCount % 18 == 0) {
    numSpots = (int) random(2, 3);
    spots = new Spot[numSpots];
    for (int i = 0; i < numSpots; i++) {
      spots[i] = new Spot(width, height);
    }
  }

  for (int i = 0; i < spots.length; i++) {
    float cX1 = spots[i].x;
    float cY1 = spots[i].y;
    int cSize1 = spots[i].size;

    for (int j = i+1; j < spots.length; j++) {
      float cX2 = spots[j].x;
      float cY2 = spots[j].y;
      int cSize2 = spots[j].size;

      boolean hit = circleCircle(cX1, cY1, cSize1, cX2, cY2, cSize2);

      /*
      if (hit) {
        spots[i].stroke = 255;
        spots[i].fill = 255;
        spots[i].transp = 0;

        spots[j].stroke = 0;
        spots[j].fill = 0;
        spots[j].transp = 0;
      }
      */
    }
  }

  for (int i = 0; i < spots.length; i++) {
    spots[i].render();
  }

  delay( (int) random(825, 8625) );
}

class Spot {
  float x;
  float y;
  int size;
  int stroke = 255;
  int fill = 255;
  //float transp = random(5, 100);
  float transp = 100;

  Spot(int width, int height) {
    x = random(-180, width + 160);
    y = random(-160, height + 180);
    //size = (width > height) ? (int)random(260, width + 180) : (int)random(260, height + 180);
    size = (width > height) ? (int)random(1, width - 100) : (int)random(1, height - 100);
  }

  void render() {
    fill(fill, transp);
    ellipse(x, y, size, size);

    //if (transp < 70) {
      //tint(0, 153, 204, 126);
    //}
  }
}

// From https://happycoding.io/tutorials/processing/collision-detection#circle-circle-collision:w
boolean circleCircle(float cX1, float cY1, int cSize1, float cX2, float cY2, int cSize2) {
  if ( dist(cX1, cY1, cX2, cY2) < cSize1 + cSize2 ) {
    return true;
  }
  return false;
}
