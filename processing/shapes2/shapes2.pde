float angle1;
 
void setup() {
  fullScreen(OPENGL);
  //size(800, 800, P3D);
  noCursor();
  smooth();
}
 
void draw() {
  noFill();
  lights();

  fill(0xee, 0xee, 0xff, 50);
  rect(-100, -100, width + 100, height + 100);
  angle1+=.0001;
  
  for(int i = 0; i < 40; i++) {
    rotateX(angle1);
    for(int j = 0; j < 30; j++) { 
      rect(0 + (i * 40), height - (j * 40), 10, 10);
    }

    if (angle1 > 0.05) {
      stroke(random(255), random(255), random(255)); 
      angle1 = 0.0;
    }
  }
}