// Flying over a rolling field of grass
// - rising and falling in height too?
// 
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
  
  float x = width / 2;
  float y = height - 100;

  // Create some stalks
  segments = new ArrayList<PVector>();
  for (int i = 0; i < 6; i++) {
    segments.add(new PVector(x, y - 50 * i));
  }
  
  // Apply perlin wind
  float wind = (noise(frameCount / 100.0 + 0.1) - 0.5);
  for (int i = 1; i < segments.size (); i++) {
    PVector segment = segments.get(i);
    segment.y += (((segments.size () - i) * 1) / 1) * 1.3;
    segment.x += x * wind;
  }
  
  // Connect each segment of the stalks
  for (int i = 0; i < segments.size()-1; i++) {
    PVector joint = PVector.sub(segments.get(i), segments.get(i+1));  

    if (joint.mag() > 5 * 4) {
      joint.normalize();
      joint.mult(-5 * 4);

      segments.get(i+1).x = segments.get(i).x + joint.x;
      segments.get(i+1).y = segments.get(i).y + joint.y;
    }
  }
  
  stroke(255);
  beginShape(TRIANGLE_STRIP);
  int h = segments.size() - 2; // 3
  for (int i = 0; i < segments.size() - 1; i++) {
    PVector segment = segments.get(i);
    stroke(255);
    vertex(segment.x + 5 * (h - i) / h, segment.y);
    vertex(segment.x - 5 * (h - i) / h, segment.y);
  }
  endShape();
}
