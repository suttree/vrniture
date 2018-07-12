// put some rects on the screen
// view in 3D

  
float x = width/2;
float y = height/2;
float z = 0;

void setup() {
  size(800, 800, P3D);
  //fullScreen(P3D);
  //noCursor();
  smooth();
}
 
void draw() {
  noFill();
  lights();
  /*
  fill( 0xee, 0xee, 0xff, 10);
  rect(0, 0, width, height);
  
  for(int i = 0; i < 10; i++) {
    stroke(255, random(255), random(255));
    rect( (width / 3) + (i * 20), (height / 3), 10, 10);
  }
  */
  /*
    translate((width/2), (height/2), z);
    rotateX(PI/8);
    rotateY(PI/8);
    rotateZ(PI/8);
  for(int i = 0; i < 5; i++) {
    rect(10 * i, 10 * i, 100, 100);
    z++; // The rectangle moves forward as z increments.
  }
  */
  
  rotateY(PI/8);
  
  int size = 40;
  stroke(0,0,0);
  fill(0xee, 0xee, 0xff, 90);
  rect(size, size, width - (size * 2), height - (size * 2));
  
  fill(125);
  stroke(212, 38, 194);
  for(int j = 0; j < 7; j++ ) {      
    for(int i = 0; i < 7; i++) {
      float angle = i * TWO_PI / 7;
      pushMatrix();
      translate(50 + size + (100 * i), size + 50 + (size * j), size/2 * cos(angle)); // this last var should be a variable on the box object?
      box(size);
      popMatrix();
    }
  }

}