
//var triangles = [];
//int[] numbers = new int[3];
//int[][] myArray = { {0,1,2,3}, {3,2,1,0}, {3,5,6,1}, {3,8,3,4} };
float[][] triangles = {
    {0, 0, 40, 0, 0, 40, 45, 0.1},
    {-80, -80, -20, -80, -80, -20, 27, random(0.2)}
  };

float[][] t = new float[8][8];

void setup() {
  smooth();

  noStroke();
  //size(800, 600);
  fullScreen();
  //triangles = [
  //  [0, 0, 40, 0, 0, 40, 45, 0.1],
  //  [-80, -80, -20, -80, -80, -20, 27, random(0.2)],
  //];
}

void draw() {
  //background(200);
  fill(255, 25); // semi-transparent white
  rect(0, 0, width, height);

  strokeWeight(4);
  float line_height = random(height);
  stroke(random(255), random(255), random(255), random(45));
  stroke(255 - random(25), random(45));
  line(0, line_height, width, line_height);
  strokeWeight(1);

  translate(width/2, height/2);
  for (int i = 0; i < triangles.length; i++) {
    float t2[] = triangles[i];
    float accel = t2[7];
    for (int j = 0; j < t2.length - 1; j++) {
      t2[j] = t2[j] + accel;
    }

    pushMatrix();
    if ( i % 2 == 0 ) {
      rotate(-t2[6]);
    } else {
      rotate(t2[6]);
    }
    fill(random(255),random(255), random(255), random(80));
    triangle(t2[0], t2[1], t2[2], t2[3], t2[4],t2[5]);
    popMatrix();
    
    // detect out of bounds stuff
    if (t2[0] > width/2 || t2[2] > width/2 || t2[4] > width/2 ||
        t2[1] > height/2 || t2[3] > height/2 || t2[5] > height/2) {

      float[][] t = {
        {0, 0, 40, 0, 0, 40, 45, random(0.2)},
        {-80, -80, -20, -80, -80, -20, 27, random(0.2)},
      };
        
      //t = [
      //  [0, 0, 40, 0, 0, 40, 45, random(0.2)],
      //  [-80, -80, -20, -80, -80, -20, 27, random(0.2)],
      //][i];
    }
    triangles[i] = t2;
  }
  noStroke();
}