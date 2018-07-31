float xoff = 0.0;
Wave[] waves = new Wave[4];

void setup() {
  smooth();
  //size(800, 800);
  fullScreen();
  noCursor();
  
  for(int i = 0; i < waves.length; i++) {
    color c = color(0, 105, 148, 90);
    waves[i] = new Wave(c, 0 - (i * 100), 10, 15, 0.75);
  }
  
  frameRate(4);
}

void draw() {
  noStroke();
  fill(237, 201, 175, 32);
  rect(0, 0, width, height);
  
  for(int i = 0; i < waves.length; i++) {
    waves[i].render();
    waves[i].update();
  }
  delay(125);
}

class Wave {
  color c;
  float mag;
  float gap;
  float inc = 0;
  float y = 0;
  float xoff = 0.0;
  String status = "incoming";
  
  Wave(color _c, int _y, float _mag, float _gap, float _inc) {
    c = _c;
    y = _y;
    mag = _mag;
    gap = _gap;
    inc = _inc;
  }
  
  void update() {
    if ( status == "incoming" ) {
      y = y + inc;
    } else {
      y = y - inc;
    }
    
    if ( y >= (height - height/3)) { 
      status = "receding";
    } else if ( y <= 0) {
      status = "incoming";
    }
  }
  
  void render() {
    fill(c);
    beginShape();
    vertex(0, 0);
    stroke(255, 255, 242, 70);
    for(int i = 0; i < width; i += gap) {
      //point(i, y + (noise(xoff) * 100));
      vertex(i, y + (noise(xoff) * 100));
      xoff = xoff + 0.04;
    }
    vertex(width + 100, y);
    vertex(width, 0);
    endShape(CLOSE);
  }
}