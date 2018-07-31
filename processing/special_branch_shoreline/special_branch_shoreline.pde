float xoff = 0.0;
Wave[] waves = new Wave[2];

void setup() {
  smooth();
  size(800, 800);
  //fullScreen();
  noCursor();
  
  for(int i = 0; i < waves.length; i++) {
    color c = color(100 + random(155), random(255), 106);
    waves[i] = new Wave(c, 10, 10);
  }
}

void draw() {
  noStroke();
  fill(0, 32);
  rect(0, 0, width, height);
  stroke(132, 155, 201);
  
  if (frameCount % 2 == 0) {
    for(int i = 0; i < waves.length; i++) {
      waves[i].render();
      waves[i].update();
    }
  }
}

class Wave {
  color c;
  float y = 0;
  float mag;
  float gap;
  float xoff = 0.0;
  String status = "incoming";
  
  Wave(color _c, float _mag, float _gap) {
    c = _c;
    mag = _mag;
    gap = _gap;
  }
  
  void update() {
    if ( status == "incoming" ) {
      y = y + gap;
    } else {
      y = y - gap;
    }
    
    if ( y >= height) { 
      status = "receding";
    } else if ( y <= 0) {
      status = "incoming";
    }
  }
  
  void render() {
    for(int i = 0; i < width; i += gap) {
      point(i, y + (noise(xoff) * 100));
      xoff = xoff + 0.04;
    }
  }
}