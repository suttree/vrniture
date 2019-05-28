//import processing.sound.*;
//SoundFile file;

Wave[] waves = new Wave[6];

void setup() {
  smooth();
  //size(800, 800);
  fullScreen();
  noCursor();
  
  for(int i = 0; i < waves.length; i++) {
    color c = color(0, 105, 148, 95 - (i * 10));
    waves[i] = new Wave(c, 0 - (i * 120), random(10), 15, random(1.5));
  }
  
  frameRate(4);

  //file = new SoundFile(this, "waves.wav");
  //file.loop();
}

void draw() {
  noStroke();
  fill(237, 201, 175, 50);
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
  float xoff = random(3.75);
  
  Wave(color _c, int _y, float _mag, float _gap, float _inc) {
    c = _c;
    y = _y;
    mag = _mag;
    gap = _gap;
    inc = _inc;
  }
  
  void update() {
    y = y + inc;
    if ( y >= (height - height/3)) { 
      y = 0 - gap;
    }
  }
  
  void render() {
    fill(c);
    beginShape();
    vertex(-10, -10);
    stroke(255, 255, 242, 70);
    for(int i = 0; i < width; i += gap) {
      vertex(i, y + (noise(xoff) * 100));
      xoff = xoff + 0.04;
    }
    vertex(width + 100, y + 10);
    vertex(width + 10, -10);
    endShape(CLOSE);
  }
}
