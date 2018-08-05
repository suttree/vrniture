void setup() {
  size(600, 400);
}

void draw() {
  /*
  beginShape(TRIANGLE_STRIP); 
  vertex(50, 50);
  text("1", 50, 50);
  vertex(100, 50);
  text("2", 100, 50);
  vertex(150, 100);
  text("3", 150, 100);
  vertex(200, 125);
  text("4", 200, 150);
  vertex(250, 250);
  text("5", 250, 250);
  endShape();
  */
  
  float mid = width/2;
  beginShape(TRIANGLE_STRIP);
  vertex(mid, height);
  vertex(mid, height - 10);
  vertex(mid + 10, height - 10);
  vertex(mid, height - 20);
  vertex(mid + 10, height - 20);
  vertex(mid, height - 30);
  vertex(mid + 10, height - 30);
  vertex(mid, height - 40);
  vertex(mid + 10, height - 40);
  vertex(mid, height - 50);
  endShape();
}

  
