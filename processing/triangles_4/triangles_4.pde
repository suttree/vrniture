// Just working on some TRIANGLE_STRIP learnings
// https://forum.processing.org/two/discussion/19317/how-to-change-the-color-of-one-triangle-in-a-pshape-triangles-triangle-fan-triangle-strip

PShape shape;
 
void setup() {
  size(400, 400, P3D);
 
  shape = createShape();
  shape.beginShape(TRIANGLES);
 
  // per vertex fill
  shape.fill(0, 0, 255);
  shape.vertex(200, 100, 0);
  shape.fill(0, 255, 0);
  shape.vertex(250, 180, 0);
  shape.fill(255, 0, 0);
  shape.vertex(300, 100, 0);
 
  shape.endShape();
  noLoop();
}
 
void draw() {
  background(255);
  shape(shape);
}