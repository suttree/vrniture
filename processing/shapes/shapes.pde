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
  
  fill(10, 15);
  //fill( 0xee, 0xee, 0xff, 10);
  rect(0, 0, width, height);
  
  angle1+=.0001;
  
  for(int i = 0; i < 100; i++) {
    rotateZ(angle1);
    stroke(255, random(255), random(255));
    rect(-200 + (i * 20), 0, 10, 10);
  }
  
  /*
  if (angle1 > 0.06) {
    for(int i = 0; i < 80; i++) {
      rotateZ(-angle1);
      stroke(random(255), 255, 255);
      rect(-10 + (i * 20), 0, 10, 10);
    }
  }
  */

  /*
  if (angle1 > 0.12) {
    for(int i = 0; i < 100; i++) {
      rotateZ(-angle1);
      stroke(125, 255, 255); 
      rect(-10 + (i * 20), 0, 10, 10);
    }
  }
  
  if (angle1 > 0.18) {
    for(int i = 0; i < 100; i++) {
      rotateZ(-angle1);
      stroke(255, 125, 125); 
      rect(-10 + (i * 22), 0, 10, 10);
    }
  }
  */
  
  /*
  if (angle1 > 0.16) {
    angle1 = 0;
  }
  */
}
