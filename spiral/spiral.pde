
// draw square
// rotate a little
// repeat

int counter = 0;

void setup() {
  size(640,480,P3D);
  frameRate(4);
}

void draw() {
  background(50);
  stroke(250);
  
  translate(width/2, height/2);
  
  beginShape();
  for(int i = 0; i < 5; i++) {
    //rect(i*20, i+20, 20, 20);
    curveVertex(i*20, i+20);
    
    rotate(radians(counter));
    counter++;
  }
  endShape();
}
