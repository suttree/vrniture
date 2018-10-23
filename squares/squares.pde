int counter = 0;

void setup() {
  size(640,480,P3D);
  //frameRate(4);
}

void draw() {
  noFill();
  stroke(250);
  
  background(220, 80, 90, 0.1);
  
  translate(width/2, height/2);
  
  for(int i = 0; i < 150; i++) {
    rotate(radians(frameCount));
    rect(i*20, i+20, 20, 20);
    //line(i*20 + 10, i+20+10, (i+1)*20+10, (i+1)+20+10);
  }
}
