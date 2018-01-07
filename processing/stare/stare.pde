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
}