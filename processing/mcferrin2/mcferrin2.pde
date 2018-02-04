void setup() {
  //fullScreen();
  size(640, 480, P3D);
  smooth(8);
}

void draw() {
  background(250, 240, 231);
  stroke(34);
  
  float t = 0.0; 
  float dist = 20.0;
  float startx, endx, x, y, prevx, prevy;
  
  color c1 = #FF0000;
  color c2 = #FFC000;
  color c3 = #E0FF00;
  color c4 = #7EFF00;
  color c5 = #21FF00;
  color c6 = #00FF41;
  color c7 = #00FF9F;
  color c8 = #00FDFF;
  color c9 = #009FFF;
  color c10 = #003DFF;
  color c11 = #2100FF;
  color c12 = #8300FF;
  color c13 = #E500FF;
  color c14 = #0052FF;
  color c15 = #FF007C;
  color c16 = #1000FF;
  color c17 = #FFFFFF;
   
   
  color[] colors  = {  
    c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17
  };
  for(int j = 0; j < 15; j++) {
    if (j == 0) {
      fill(76,224,230);
    } else if (j == 1) {
      fill(255, 140, 0);
    } else if (j == 2) {
      fill(25, 2370, 20, 90);
    } else {
      fill(24, 90);
    }

    fill(random(colors[j], 45);
    
    startx = width/2 - (10 * j);
    endx = width/2 - (40 * j);
    prevx = startx;
    prevy = 0;
    
    noStroke();
    beginShape();
    vertex(0, 0);
    vertex(startx, 0);
    int numPoints = 4;
    for (int i = 0; i < numPoints; i++) {
      x = startx + (noise(t) * 90 * i);
      y = height/(numPoints + 1) * (i+1);
      
      if ( i % 2 == 0 ) {
        quadraticVertex(prevx + dist, prevy + dist, x, y);
      } else {
        quadraticVertex(prevx - (dist * 2), prevy + (dist * 2), x, y);
      }
      vertex(x, y);
  
      prevx = x;
      prevy = y;
    }
    quadraticVertex(prevx + dist, prevy + (dist * 2.75), endx, height);
    vertex(endx, height);
    vertex(0, height);
    vertex(0,0);
    endShape();
    t = t + 0.05;
    dist = dist + (10 * cos(dist));
  }
}