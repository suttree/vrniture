float angle1;

void setup() {
  size(800, 800, P3D);  
  smooth();
}
 
void draw() {
  noFill();
  lights();
  
  //fill(255, 10);
  fill( 0xee, 0xee, 0xff, 10);
  rect(0, 0, width, height);
  
  angle1+=.0001;
  
  for(int i = 0; i < 100; i++) {
    rotateZ(angle1);
    stroke(255); 
    rect(0 + (i * 20), 0, 10, 10);
  }
}