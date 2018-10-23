// Flying over a rolling field of grass
// - rising and falling in height too?
// 
// Code extended from https://www.openprocessing.org/sketch/158875
// License: 
//  http://creativecommons.org/licenses/by-sa/3.0/
//  http://creativecommons.org/licenses/GPL/2.0/

ArrayList<Blade> grass;

void setup() {
  size(800, 800);
  
  grass = new ArrayList<Blade>();
  for (int i = 0; i < 20; i++) {
    for (int j = 0; j < 20; j++ ) {
      grass.add(new Blade( new PVector(random(0, width), height - (20 * j)), random(5, 10) ));
    }
  } 
}

void draw() {
  background(100, 220, 255);
  
  for (int i = 0; i < grass.size() - 1; i++) {
    grass.get(i).update();
    grass.get(i).render();
  }
}

class Blade {
  float x = width / 2;
  float y = height - 100;
  PVector anchor;
  color green;

  ArrayList<PVector> segments;
  
  Blade(PVector _anchor, float numSegments) {
    green = color((int)random(0, 50), (int)random(100, 255), (int)random(0, 100));
    segments = new ArrayList<PVector>();
    
    anchor = _anchor;
    
    for (int i = 0; i < numSegments  ; i++) {
      segments.add(new PVector(anchor.x, anchor.y - 50 * i));
    }
    
    segments.get(0).x = anchor.x;
    segments.get(0).y = anchor.y;
  }
  
  void update() {
    // Apply perlin wind
    float wind = (noise(frameCount / 100.0 + 0.1) - 0.5);
    for (int i = 1; i < segments.size (); i++) {
      PVector segment = segments.get(i);
      segment.y -= ( ((segments.size () - i) * 1) / 1) * 1;
      segment.x += i * wind * (4/1);
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
  }
  
  void render() {
    stroke(255);
    beginShape(TRIANGLE_STRIP);
    int h = segments.size() - 2;
    for (int i = 0; i < segments.size() - 1; i++) {
      PVector segment = segments.get(i);
      vertex(segment.x + 5 * (h - i) / h, segment.y);
      vertex(segment.x - 5 * (h - i) / h, segment.y);
    }
    endShape();
  }
}
