float theta;
float t = 1;
int num = 4, frms = 240;

void setup() {
  fullScreen();
  smooth(8);
  
background(216, 138, 66, 70);
}

void draw() {
  //background(216, 138, 66);
  
  stroke(250, 240, 231);
  strokeWeight(noise(t) * 4);
  //line(width/2 - 150, height/2 + cos(noise(t) * 100), width/2 + cos(noise(t) * 100), random(height));
  t+=0.05;
  
  int dir = 1, n = 15, v = 10;
  theta += TWO_PI/frms;

  
  beginShape();
  for (int i=0; i<num; i++) {
    float angle = TWO_PI/num*i;
    float minV = map(sin(dir*theta+dir*angle*3), -1, 1, 20, noise(t) + width* .95);
    float d = map(sin(angle*n), -1, 1, minV, width*.75+v);
    float x = cos(angle)*d;
    float y = sin(angle)*d;
    vertex(x, y);
  }
  endShape(CLOSE);
}
