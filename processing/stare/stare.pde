void setup() {
  fullScreen(P3D);
  noStroke();
  background(0);
  
  ellipse(width/2, height/2, height, height);
  fill(0);
  triangle(width/4, height, width/2, 0, width - width/4, height);
  fill(255);
  ellipse(width/2, height - height/3, height/2.5, height/2.5);
}

void draw() {
  //background(0);
  
  ellipse(width/2, height/2, height, height);
  fill(0);
  triangle(width/4, height, width/2, 0, width - width/4, height);
  fill(255);
  ellipse(width/2, height - height/3, height/2.5, height/2.5);
  
  stroke(124, 5);
  noFill();
  //triangle(width/4 - 10, height, width/2, -10, width - width/4 + 20, height + 20);
  
  for(int i = 0; i < 25; i++) {
    int j = i * 20;
    triangle(width/4 - j, height + j, width/2, -j, width - width/4 + j, height + j);
  }
}