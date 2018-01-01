// https://www.openprocessing.org/sketch/310920

ArrayList<Star> poop = new ArrayList();
void setup() {
  fullScreen();
  noCursor();
  for (int i=0; i<5; i++) {
    poop.add(new Star(random(width), random(10, height-10)));
  }
}

void draw() {
  background(#E3662A); 
  for (int i=0; i<poop.size (); i++) {
    Star S = poop.get(i);
    S.show();
    S.tail();
    S.update();
  }
}

class Star {
  int r1 = 20, r2=10, r; 
  float k, j, x, y;
  Star(float x, float y) {
    this.x = x;
    this.y = y;
  }
  void show() {  
    float s = 0.05*sin(radians(j))+0.25f;
    pushMatrix();
    translate(x, y);
    scale(s);
    noStroke();
    beginShape();
    for (int i=0; i<16; i++) {
      float rad = radians(i*360/8);
      if (i%2==0)r = r1;
      else r = r2;
      float xx =  r*cos(rad);
      float yy =  r*sin(rad);
      curveVertex(xx, yy);
    }
    endShape(CLOSE);
    popMatrix();
    if (j<180)j+=6;
    else j=0;
  }
  void tail() {
    for (int i=0; i<4; i++) {
      float l = 50*sin(radians(k));
      stroke(-1);
      line(x-k*i-50+l, y, x-l-k*i, y);
    }
    if (k<45)k+=2;
    else k=0;
  }
  void update() {
    if (x<width)x++;
    else {
      x =0;
      y = random(10, height-10);
    }
  }
}