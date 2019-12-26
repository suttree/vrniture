float angle1;

void setup() {
  fullScreen(P2D);
  noCursor();
  smooth();
  
  fill(0);
  rect(0, 0, width, height);
  
  frameRate(4);
}
 
void draw() {
  noFill();
  noStroke();

  fill(0);
  rect(0, 0, width, height);

  angle1+=.00126;
  rotate(angle1);
  
  int gap = (width > height ? width/5 : height/5);
  for (int x = -gap; (x * 20) < width + gap; x++) {
    for( int y = -gap; (y * 20) < height + gap; y++ ) {
      if ( (int) random(100) == 10) {
        fill(random(180, 255), random(255), random(255));
      } else {
        fill(0);
      }
      stroke(random(180, 255), random(255), random(255));
      rect( (x * 20), (y * 20), 10, 10 );
    }
  }
  
  delay((int) random(125,1000) );
}
