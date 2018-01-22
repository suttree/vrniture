// TODO: try with a curve drawn from the starting point through each of points
// TODO: can I draw the shape by picking a starting point and incrementing/decrementing through the points
// i.e. [0, +10], [+10, +20]

int[] coordinates = { 0,0, 1,1, 3,1, 3,2, 4,2, 8,2, 25,2, 8,15 }; // remember it starts at 0,0 ;-)

final ArrayList<PVector> curvePoints = new ArrayList();
//curvePoints.add(new PVector(1, 2));  // idx 0

//PVector[] test = new PVector[10];
//test.add(new PVector(0,1));

//ArrayList<PVector> test = new ArrayList<PVector>();
//test.add(new PVector(10, 10, 10));

/*
//ArrayList[] blocks = new ArrayList[4];
ArrayList<PVector>[] blocks = (ArrayList<PVector>[])new ArrayList[4] {};
for (int i=0; i<4 ; i++) {
  blocks[i] = new ArrayList<PVector>();
  for (int x = 0; x < 7; x++) {
    blocks[i].add(new PVector(random(10), random(10)));
  }
}
*/

final static int NUM_BLOCKS = 4, NUM_VECS = 7, MAX = 10;
final ArrayList<PVector>[] blocks = new ArrayList[NUM_BLOCKS];

/*
String[][] arrays = { [0,1] };

Array[] curvePoints[15] = [];

curvePoints[0] = [286, 226];
curvePoints[1] = [296, 226];
curvePoints[2] = [291, 206];
curvePoints[3] = [273, 194];
curvePoints[4] = [253, 206];
curvePoints[5] = [257, 235];
curvePoints[6] = [280, 244];
curvePoints[7] = [290, 245];
curvePoints[8] = [300, 245];
curvePoints[9] = [310, 245];
curvePoints[10] = [320, 245];
curvePoints[11] = [330, 245];
curvePoints[12] = [340, 245];
curvePoints[13] = [350, 245];
curvePoints[14] = [360, 245];
curvePoints[15] = [370, 245];
*/

PVector[] vectors = new PVector[15];
//vectors[0] = new PVector(x: 286, y: 226);

ArrayList <PVector> points = new ArrayList <PVector> ();
int marge = 50;
int numPoints = 10;
int currentPoint;
PVector current;
PImage img;

//float[][] curvePoints = new float[5][];

/*
float[][] curvePoints = {
[286, 226],
[296, 226],
[291, 206],
[273, 194],
[253, 206],
[257, 235],
[280, 244],
[290, 245],
[300, 245],
[310, 245],
[320, 245],
[330, 245],
[340, 245],
[350, 245],
[360, 245],
[370, 245]
}
*/

void setup () {
for ( int i = 0; i != NUM_BLOCKS; println(i++ + "\n") ) {
  final ArrayList b = blocks[i] = new ArrayList(NUM_VECS);
 
  for ( int j = 0; j != NUM_VECS; ++j )
    b.add(new PVector(random(MAX), random(MAX)));
 
  println(b);
}
  //fullScreen();
  size(500, 500);
  
  for( int i = 0; i < numPoints; i++) {
    points.add(new PVector(random(marge, width - marge), random(marge, height-marge)));
  }
  
  current = points.get(currentPoint);
  noStroke();
  smooth();
  
  img = loadImage("eeeee.png");
  img.resize(width, height);
}

void draw () {
  background(255);
  image(img, 0, 0);
  fill(0, 102, 153, 204);
  
  for(PVector p : points) {
    ellipse(p.x, p.y, 10, 10);
  }
  
  if( frameCount % 60 == 0) {
    currentPoint = (currentPoint + 1) % points.size();
    current = points.get(currentPoint);
  }
  
  fill(0, 0, 255);
  ellipse(current.x, current.y, 25, 25);
  
  // draw a curve
  noFill();
  stroke(255, 102, 0);
  //curve(296.0, 226.0, 291.0, 206.0, 273.0, 194.0, 253.0, 206.0, 257.0, 235.0, 280.0, 244.0, 355.0, 245.0);
  //curve(295.0, 226.0, float(296), float(226), float(291), float(206), float(273), float(194));
  //curve(273.0, 194.0, 253.0, 206.0, 257.0, 235.0, 280.0, 244.0);
  
  beginShape();
  curveVertex(286, 226);
  curveVertex(296, 226);
  curveVertex(291, 206);
  ellipse(273, 194, 5, 5);
  curveVertex(273, 194);
  curveVertex(253, 206);
  curveVertex(257, 235);
  curveVertex(280, 244);
  curveVertex(290, 245);
  curveVertex(300, 245);
  curveVertex(310, 245);
  curveVertex(320, 245);
  curveVertex(330, 245);
  curveVertex(340, 245);
  curveVertex(350, 245);
  curveVertex(360, 245);
  curveVertex(370, 245);
  endShape();

  noStroke();
  
  textSize(18);
  text("x: " + mouseX + " y: " + mouseY, 10, 25);
}