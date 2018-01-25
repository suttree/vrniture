// TODO: try with a curve drawn from the starting point through each of points
// TODO: can I draw the shape by picking a starting point and incrementing/decrementing through the points
// i.e. [0, +10], [+10, +20]
// TODO use PVector velocity on each curvePoint?
// TODO use PShapes?

final ArrayList<PVector> curvePoints = new ArrayList();

int t = 0;
PImage img;

void setup () {
  /*
  curvePoints.add(new PVector(286, 226));
  curvePoints.add(new PVector(296, 226));
  curvePoints.add(new PVector(291, 206));
  curvePoints.add(new PVector(273, 194));
  curvePoints.add(new PVector(253, 206));
  curvePoints.add(new PVector(257, 235));
  curvePoints.add(new PVector(280, 244));
  curvePoints.add(new PVector(290, 245));
  curvePoints.add(new PVector(300, 245));
  curvePoints.add(new PVector(310, 245));
  curvePoints.add(new PVector(320, 245));
  curvePoints.add(new PVector(330, 245));
  curvePoints.add(new PVector(340, 245));
  curvePoints.add(new PVector(350, 245));
  curvePoints.add(new PVector(360, 245));
  curvePoints.add(new PVector(370, 245));
  */
  curvePoints.add(new PVector(288, 228));
  curvePoints.add(new PVector(287, 211));
  curvePoints.add(new PVector(284, 208));
  curvePoints.add(new PVector(292, 194));
  curvePoints.add(new PVector(302, 207));
  curvePoints.add(new PVector(303, 228));
  

  //fullScreen();
  size(500, 500);
  noStroke();
  smooth();
  
  img = loadImage("eeeee.png");
  img.resize(width, height);
}

void draw () {
  background(255);
  image(img, 0, 0);
  fill(0, 102, 153, 204);
  
  if( frameCount % 10 == 0) {
    if (t >= curvePoints.size()) {
      t = 0;
    } else {
      t++;
    }
  }
  
  // draw a shape
  beginShape();
  for(int i = 0; i < t; i++) {
    PVector point = curvePoints.get(i);
    //curveVertex(point.x, point.y);
    vertex(point.x, point.y);
    ellipse(point.x, point.y, 10, 10);
    text(i, point.x, point.y);
  }
  endShape(CLOSE);

  noStroke();
  textSize(18);
  text("x: " + mouseX + " y: " + mouseY, 10, 25);
}