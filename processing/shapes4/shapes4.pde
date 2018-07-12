// Just working on some SHAPE learnings
// https://forum.processing.org/two/discussion/2674/changing-color-of-each-shape-in-an-iteration

/** 
 * Pulsating Boxes (v3.32)
 * by  Jam131 (2014/Jan)
 * mod GoToLoop
 *
 * forum.processing.org/two/discussion/2674/
 * changing-color-of-each-shape-in-an-iteration
 *
 * studio.processingtogether.com/sp/pad/export/ro.9A9O52aqsIjdx/latest
 */
 
static final int DIM = 050, RAD = DIM >> 1;
static final int STEP = 3, COLORS = 0100;
 
Pulse[] pulses;
 
void setup() {
  size(960, 480);
  frameRate(60);
  smooth(4);
  noCursor();
  strokeWeight(5);
 
  colorMode(HSB, COLORS, 1, 1);
 
  rectMode(CENTER);
  ellipseMode(CENTER);
 
  pulses = createPulses();
  println(pulses);
}
 
Pulse[] createPulses() { // for rectMode(CENTER)!!!
  final int cols = width/DIM, rows = height/DIM;
  final Pulse[] boxes = new Pulse[rows*cols];
 
  for (int y = 0; y != rows; ++y)  for (int x = 0; x != cols; ++x)
    boxes[y*cols + x] = new Pulse(x*DIM + RAD, y*DIM + RAD);
 
  return boxes;
}
 
void shuffleColors() {
  for (Pulse p: pulses)  p.randColor();
}
 
void draw() {
  clear();       // Java
  //background(0); // JS
 
  final float diam = DIM * abs(sin(radians(frameCount*STEP)));
  if (diam < 1e-2)  shuffleColors();
 
  frame.setTitle("Diam: " + nf(diam, 2, 2)); // Java only!
 
  for (Pulse p: pulses)  p.display(diam);
 
  fill(0, 030);
  stroke(-1);
  ellipse(mouseX, mouseY, DIM + diam*20, DIM + diam*20);
  ellipse(pmouseX, pmouseY, DIM + diam*10, DIM + diam*10);
 
  fill(-1);
  noStroke();
  rect(mouseX, mouseY, DIM/1.3, DIM/1.3);
}
 
class Pulse {
  final short x, y;
  color c;
 
  Pulse(int px, int py) {
    x = (short) px;
    y = (short) py;
 
    randColor();
  }
 
  void randColor() { // for colorMode(HSB)!!!
    c = color(random(COLORS), 1, 1);
  }
 
  void display(float diam) {
    fill(c);
    rect(x, y, diam, diam);
  }
 
  String toString() {
    return "(" + x + ", " + y + ")";
  }
}