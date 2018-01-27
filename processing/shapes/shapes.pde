// Size of cubes
float bounds = 20;
float angle1;
 
void setup() {
  size(800, 800, P3D);  
  smooth();
}
 
void draw() {
  background(0);
  //lights();
 
  // Center in display window
  //translate(width/2, height/2, -130);
 
  // Rotate cube
  noFill();

  angle1+=.0001;
  
  for(int i = 0; i < 50; i++) {
    //translate(width/2, height/2, 0 - 130 - i);
    //translate(width/2, height/2);
    //rotateX(angle1);
    //rotateY(angle1);
    rotateZ(angle1);
    stroke(255); 
    //box(bounds);
    rect(0 + (i * 20), 0, 10, 10);
  }
}