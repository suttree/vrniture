float angle1;
float z = 0;
 
void setup() {
  //fullScreen(P3D);
  size(800, 800, OPENGL);
  noCursor();
  smooth();
  lights();
}
 
void draw() {
  lights();
  ambientLight(0,0,255);
  background(0);

  translate(100, 100, 0);
    
  noStroke();
  fill(255);
  sphere(50);
}