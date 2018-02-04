float t = 0.0;

void setup() {
  //fullScreen();
  size(640, 480, P3D);
  smooth(8);
}

void draw() {
  //background(250, 240, 231);
  //stroke(34);
  
  noFill();
    
  noStroke();
  fill(10, 200, 255, 90);
  rect(0, 0, width, height);


  int startx = 0;
  int starty = 0;
  int shapeWidth = 100;
  int shapeHeight = 100;
  float dist = 50;

  translate(width/2, height/2);
  for(int i = 0; i < 2; i++) {
    
    if (i == 0) {
      //background(250, 240, 231, 90);
      fill(255, 0, 0, 90);
    } else if (i == 1) {
      //background(250, 0, 0, 90);
      fill(0, 255, 0, 90);
     } else {
       //background(34, 90);
       fill(0, 0, 255, 90);
     }
    //fill(lerpColor(0, 255, t));
    //fill(255, 90);
    
    ellipse(startx, starty, 10, 10);
    ellipse(startx + shapeWidth, starty, 10, 10);
    ellipse(startx + shapeWidth, starty + shapeHeight, 10, 10);
    ellipse(startx, starty + shapeHeight, 10, 10);
    
    beginShape();
    
    vertex(startx, starty);
    quadraticVertex(startx + dist, starty - dist, startx + shapeWidth, starty);
    
    vertex(startx + shapeWidth, starty);
    quadraticVertex(startx + shapeWidth - dist * 2, starty + dist, startx + shapeWidth, starty + shapeHeight);    
  
    vertex(startx + shapeWidth, starty + shapeHeight);
    quadraticVertex(startx + shapeWidth - dist, starty + shapeHeight + dist, startx, starty + shapeHeight);
    
    vertex(startx, starty + shapeHeight);
    quadraticVertex(startx - dist, starty + shapeHeight - dist, startx, starty);

    vertex(startx, starty);
    
    endShape(CLOSE);
    
    shapeWidth = shapeWidth + 100;
    shapeHeight = shapeHeight + 100;
    //dist = dist + 5;
    t = t + 0.0025;
    startx = startx - 50;
    starty = starty - 50;
  }
  
/*
  translate(width/2, height/2);
  beginShape();
  for(int i = 0; i < points; i++) {
    pushMatrix();
    rotate(radians(360/4));
    fill(0, 0, 255);
    int startx = dist + (i * 10);
    int starty = -dist;
    ellipse(startx, starty, 10, 10);
    println(startx, starty);
    popMatrix();
    //println("^ start");
    
    //rotate(radians(360/points));
    //rotate(PI/6.0);
    //rotateZ(radians(60));

    fill(255, 0, 0);
    int endx = dist + (i * 10);
    int endy = -dist;
    ellipse(endx, endy, 10, 10);
    println(endx, endy);
    //println("^ end ");
 
    //vertex(startx, starty);
    //quadraticVertex(width/2 - dist, height/2 - dist, 50, 50);
    //vertex(endx, endy);
  }
  endShape();
*/
}