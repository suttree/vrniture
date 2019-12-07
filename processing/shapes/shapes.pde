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
  
  //fill( 0xee, 0xee, 0xff, 10);
  noStroke();
  fill(0, (int) random(15));
  rect(0, 0, width, height);

  fill(0, 15);
  angle1+=.0002;
  
  for(int i = 0; i < 200; i++) {
    rotateZ(angle1);
    stroke(random(180, 255), random(255), random(255));
    rect(-100 + (i * 20), -80, 10, 10);
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
