float angle1;

void setup() {
  //size(800, 800, P3D);
  fullScreen(P3D);
  noCursor();
  smooth();
}
 
void draw() {
  noFill();
  lights();
  
  //fill(255, 10);
  fill( 0xee, 0xee, 0xff, 10);
  rect(0, 0, width, height);
  
  angle1+=.0001;
  println(angle1);
  
  for(int i = 0; i < 100; i++) {
    rotateZ(angle1);
    stroke(255); 
    rect(-100 + (i * 20), 0, 10, 10);
  }
  
  if (angle1 > 0.06) {
    for(int i = 0; i < 100; i++) {
      rotateZ(-angle1);
      stroke(0); 
      rect(-10 + (i * 20), 0, 10, 10);
    }
  }
  
  if (angle1 > 0.16) {
    angle1 = 0;
  }
}