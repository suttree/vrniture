 int numLines = 0;
 float maxLines = random(20, 25);
  
void setup() {
  fullScreen(P3D);
  noStroke();
  background(15);
}

void draw() {
  if (frameCount % 4 == 0) {
    background(15);
    
    stroke(0);
    fill(255);
    ellipse(width/2, height/2, height, height);
    fill(15);
    stroke(0);
    triangle(width/4, height, width/2, 0, width - width/4, height);
    fill(255);
    ellipse(width/2, height - height/3, height/2.5, height/2.5);
    
    stroke(75);
    noFill();
    numLines++;

    for(int i = 0; i < numLines; i++) {
      int j = i * 20;
      triangle(width/4 - j, height + j, width/2, -j, width - width/4 + j, height + j);
    }
    
    if (numLines > maxLines) {
      numLines = 0;
      maxLines = random(5, 15);
    }
  }
}