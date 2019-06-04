float theta = 0.0;
int points = 4;
float dist = width/4;

float t = random(0.0, 1.0);


void setup() {
  fullScreen(P3D);
  noCursor();
  smooth(8);
}

void draw() {
  background(250, 240, 231);

  //stroke(34);
  //strokeWeight(4);

  noFill();
  noStroke();
  fill(255, 0, 255, 90);
  rect(0, 0, width, height);

  int shapeWidth = 200;
  int shapeHeight = 200;

  int startx = 0;
  int starty = 0;
  dist = noise(t) * 8;
  translate(width/2, height/2);

  for(int i = 0; i < 10; i++) {
    //fill(250, 240, dist, 90);
    //fill(0, 255, 0, 90);
    //fill(lerpColor(0, 255, t));

    fill(10 + dist, 100 - 15 * i);

    //stroke(0);

    noStroke();

    // Draw the square
    beginShape();
    
    vertex(startx - dist, starty - dist);
    quadraticVertex(startx + dist, starty - dist, startx + shapeWidth, starty);
    
    vertex(startx + shapeWidth, starty);
    quadraticVertex(startx + shapeWidth - dist * 2, starty + dist, startx + shapeWidth, starty + shapeHeight);
  
    vertex(startx + shapeWidth, starty + shapeHeight);
    quadraticVertex(startx + shapeWidth - dist, starty + shapeHeight + dist, startx, starty + shapeHeight);
    
    vertex(startx, starty + shapeHeight);
    quadraticVertex(startx - dist, starty + shapeHeight - dist / 4, startx - dist, starty - dist);

    vertex(startx - dist, starty - dist);
    
    endShape(CLOSE);
    
    shapeWidth = shapeWidth + 20;
    shapeHeight = shapeHeight + 20;
    dist = dist + 15;
    t = t + random(0.0025, 0.025);
    startx = startx - 20;
    starty = starty - 20;
  }
}
