// TODO: try with a curve drawn from the starting point through each of points



ArrayList <PVector> points = new ArrayList <PVector> ();
int marge = 50;
int numPoints = 10;
int currentPoint;
PVector current;
PImage img;

void setup () {
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
  
  textSize(18);
  text("x: " + mouseX + " y: " + mouseY, 10, 25);
}