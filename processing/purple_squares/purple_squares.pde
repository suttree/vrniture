float theta = 0.0;
int points = 4;
float dist = width/4;

float t = 0.0;

void setup() {
  //fullScreen();
  size(640, 480, P3D);
  smooth(8);
}

void draw() {
  background(250, 240, 231);
  stroke(34);
  
  noFill();
  strokeWeight(4);

/*
 pushMatrix(); 
 translate(mouseX,mouseY); 
 rotate(radians(frameCount)); 
 beginShape(); 
 vertex( 59 , 11); 
 bezierVertex( 59 , 11 , 51 , 0 , 33 , 0); 
 bezierVertex( 14 , 0 , 0 , 15 , 0 , 37); 
 bezierVertex( 0 , 58 , 15 , 70 , 34 , 70); 
 bezierVertex( 52 , 70 , 59 , 59 , 59 , 59); 
 endShape(CLOSE); 
 popMatrix();
*/

  /*
  translate(width/2, height/2);
  for(int i = 0; i < points; i++) {
    fill(0, 0, 255);
    rotate(radians(360/points));
    ellipse(5, -25, 10, 10);
  }
  */
  
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
    fill(250, 240, dist, 90);
    fill(0, 255, 0, 90);
    //fill(lerpColor(0, 255, t));
    fill(10 + dist, 100 - 15 * i);
    stroke(0);
    noStroke();
    beginShape();
    
/*
    vertex(0 - i * 10, 0 + i * 10);
    quadraticVertex(0 + dist, 0 - dist, 0 + shapeWidth, 0);
    
    vertex(0 + shapeWidth, 0);
    quadraticVertex(0 + shapeWidth - dist / 2, 0 + dist, shapeWidth, shapeHeight);
  
    vertex(0 + shapeWidth, 0 + shapeHeight);
    quadraticVertex(0 + shapeWidth - dist, 0 + shapeHeight + dist, 0, shapeHeight);
    
    vertex(0, 0 + shapeHeight);
    quadraticVertex(0 - dist, 0 + shapeHeight - dist / 4, 0 - i * 10, 0 + i * 10);

    vertex(0 - i * 10, 0 + i * 10);
 */
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
    t = t + 0.0025;
    startx = startx - 20;
    starty = starty - 20;
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
