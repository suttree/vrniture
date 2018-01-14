int numLines = 0;
float maxLines = random(20, 25);
int x1, y1, width1, height1;
  
void setup() {
  fullScreen();
  smooth();
  noStroke();
  background(15);
  
  x1 = width/2;
  y1 = height/2;
  width1 = height;
  height1 = height;
}

void draw() {
  background(201, 53, 53);
  
  noStroke();
  fill(255);
  //x1 = x1 - 1;
  //y1 = y1 - 1;
  
  width1 = width1 - 1;
  height1 = height1 - 1;

  //ellipse(width/2, height/2, height, height);
  ellipse(x1, y1, width1, height1);

  fill(5);
  triangle(width/4, height, width/2, 0, width - width/4, height);

  fill(255);
  /*
  x
  y
  width
  height
  */
  ellipse(width/2, height - height/3, height/2.5, height/2.5);

  /*
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
  */
}