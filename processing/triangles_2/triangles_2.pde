// Just working on some TRIANGLE_STRIP learnings

PShape shape;
 
void setup() {
  size(400, 400, P3D);
 
  shape = createShape();
  shape.beginShape(TRIANGLES);
 
  shape.fill(255, 0, 0);
  shape.vertex(100, 100, 0);
  shape.vertex(150, 180, 0);
  shape.vertex(200, 100, 0);
 
  shape.fill(0, 255, 0);
  shape.vertex(150, 180, 0);
  shape.vertex(200, 100, 0);
  shape.vertex(250, 180, 0);
 
  shape.fill(0, 0, 255);
  shape.vertex(200, 100, 0);
  shape.vertex(250, 180, 0);
  shape.vertex(300, 100, 0);
 
  shape.endShape();
  noLoop();
}
 
void draw() {
  background(255);
  shape(shape);
}