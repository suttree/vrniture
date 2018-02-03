float theta = 0.0;
int points = 4;
int dist = width/4;

float t = 0.0;
int shapeWidth = 100;
int shapeHeight = 100;

void setup() {
  //fullScreen();
  size(640, 480);
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
  
  translate(width/2, height/2);
  fill(250, 240, 231);
  beginShape();
  vertex(0, 0);
  quadraticVertex(200 * noise(t), -75, 0 + shapeWidth, 0);
  
  vertex(0 + shapeWidth, 0);
  quadraticVertex(50, 120 * noise(t), shapeWidth, shapeHeight);

  vertex(0 + shapeWidth, 0 + shapeHeight);
  quadraticVertex(80 * noise(t), 120, 0, shapeHeight);
  
  vertex(0, 0 + shapeHeight);
  quadraticVertex(-100, 100 * noise(t), 0, 0);
  
  endShape(CLOSE);
  
  t = t + 0.0035;
  
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