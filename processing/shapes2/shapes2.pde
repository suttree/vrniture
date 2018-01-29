float angle1;
 
void setup() {
  fullScreen(P3D);
  //size(800, 800, P3D);
  noCursor();
  smooth();
}
 
void draw() {
  noFill();
  lights();

  fill(0xee, 0xee, 0xff, 50);
  rect(-100, -100, width + 100, height + 100);
  angle1+=.00095;
  
  int startx = (width/2 - (5*20));
  int starty = (height/2 + (5*10));
 
  for(int i = 0; i < 4; i++) {
    rotateX(angle1);
    for(int j = 0; j < 4; j++) { 
      rect(startx + (i * 40), starty - (j * 40), 10, 10);
    }

    if (angle1 > 1.10) {
      stroke(255, random(255), random(255)); 
      angle1 = 0.0;
    }
  }
}