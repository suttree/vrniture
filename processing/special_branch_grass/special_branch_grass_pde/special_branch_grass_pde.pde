// Code extended from https://www.openprocessing.org/sketch/158875
// License: 
//  http://creativecommons.org/licenses/by-sa/3.0/
//  http://creativecommons.org/licenses/GPL/2.0/

ArrayList<PVector> segments;

void setup() {
  size(800, 800);
}

void draw() {
  background(100, 220, 255);
  
  float x = width/2;
  float y = height;

  segments = new ArrayList<PVector>();
  for (int i = 0; i < 6; i++) {
    segments.add(new PVector(x, y - 50 * i));
  }
  
  float wind = (noise(frameCount/100.0+0.1)-0.5);
  for (int i = 1; i < segments.size (); i++) {
    PVector segment = segments.get(i);
    segment.y += (((segments.size () - x) * 1) / 1) * 1.1;
    segment.x += x * wind;
  }
  
  stroke(255);
  beginShape(TRIANGLE_STRIP);
  int h = segments.size() - 2; // 3
  for (int i = 0; i < segments.size() - 1; i++) {
    PVector segment = segments.get(i);
    stroke(255);
    vertex(segment.x + 5 * (h - i) / h, segment.y);
    vertex(segment.x - 5 * (h - i) / h, segment.y);
    stroke(255, 0, 0);
    ellipse(segment.x, segment.y, 5, 5);
  }
  endShape();
}
