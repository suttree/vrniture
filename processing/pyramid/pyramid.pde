// From https://www.reddit.com/r/processing/comments/5fb9vc/need_help_to_create_a_rotating_pyramid/

import processing.opengl.*;
float y = 0.1;
float v = 0.01;

void setup()
{
  //size(800, 600, P3D);
  lights();
  smooth();
  fullScreen(P3D);
  noCursor();
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*60.0 / 360.0), width/2.0, height/2.0, 0, 0, 1, 0);
}
void draw()
{
  translate(500, 400, 0);
  rotateY(y);
  rotateX(PI/2 * sin(v));
  background(0);
  fill(0, 0, 0);
  stroke(256, 256, 256);
  /////
  beginShape();
  vertex(-100, -100, -100);
  vertex( 100, -100, -100);
  vertex(   0, 0, 100);

  vertex( 100, -100, -100);
  vertex( 100, 100, -100);
  vertex(   0, 0, 100);

  vertex( 100, 100, -100);
  vertex(-100, 100, -100);
  vertex(   0, 0, 100);

  vertex(-100, 100, -100);
  vertex(-100, -100, -100);
  vertex(   0, 0, 100);
  endShape();
  /////
  y += .006;
  v += .004;
}
