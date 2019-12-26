float angle1;

void setup() {
  fullScreen(P3D);
  noCursor();
  smooth();
  
  fill(0);
  rect(0, 0, width, height);
}
 
void draw() {
  noFill();
  noStroke();
  lights();
  fill(0);
  rect(0, 0, width, height);

  angle1+=.00126;
  rotateZ(angle1);
  
  int gap = (width > height ? width/2 : height/2);
  for (int x = -gap; (x * 20) < width + gap; x++) {
    for( int y = -gap; (y * 20) < height + gap; y++ ) {
      if ( (int) random(20) == 10) {
        fill(random(180, 255), random(255), random(255));
      } else {
        fill(0);
      }
      stroke(random(180, 255), random(255), random(255));
      rect( (x * 20), (y * 20), 10, 10 );
    }
  }
}
