float angle1;

void setup() {
  fullScreen(P2D);
  noCursor();
  smooth();
  
  fill(0);
  rect(0, 0, width, height);
}
 
void draw() {
  noFill();
  noStroke();

  fill(0);
  rect(0, 0, width, height);

  angle1+=.00126;
  rotate(angle1);
  
  int gap = (width > height ? width/6 : height/6);
  for (int x = -gap; (x * 35) < (width + gap); x++) {
    for( int y = -gap; (y * 35) < (height + gap); y++ ) {
      if ((int) random(500) == 10) {
        fill(random(180, 255), random(255), random(255));
      } else {
        fill(0);
      }
      stroke(random(180, 255), random(255), random(255));
      rect( (x * 35), (y * 35), 22, 22);
    }
  }
  
  delay((int) random(12, 847));
}
