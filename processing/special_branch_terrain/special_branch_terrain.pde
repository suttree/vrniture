// Via https://www.youtube.com/watch?v=IKB1hWWedMk
// and https://github.com/CodingTrain/website/blob/master/CodingChallenges/CC_011_PerlinNoiseTerrain/CC_011_PerlinNoiseTerrain.pde
// audio via: https://freesound.org/people/kvgarlic/sounds/135472/

import processing.sound.*;
SoundFile file;

int cols, rows;
int scl = 20;
int w = 2800;
int h = 1600;

float flying = 0;
float[][] terrain;
ArrayList<PVector> stars;

void setup() {
  //size(800, 800, P3D);
  fullScreen(P3D);
  smooth();
  noCursor();
  colorMode(HSB);
  
  cols = w / scl;
  rows = h / scl;
  terrain = new float[cols][rows];
  stars = new ArrayList<PVector>();
  
  for (int y = 0; y < 15; y++) {
    for (int x = 0; x < cols; x++) {
      if (random(5) > 4.875) {
        stars.add( new PVector(x*scl + (noise(x) * 10), y*scl + (noise(y) * 10)) );
      }
    }
  }
  frameRate(4);
  
  file = new SoundFile(this, "field.wav");
  file.loop();
}


void draw() {
  flying -= 0.1;

  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      xoff += 0.075;
    }
    yoff += 0.065;
  }

  // brightness: darken and lighten over time
  background(150, 90, 127, 50);
  noStroke();

  // draw stars
  fill(225);
  for(int i = 0; i < stars.size(); i++) {
    rect(stars.get(i).x, stars.get(i).y, 1, 1);
  }
  //fill(225);
  //rect(x*scl + noise(x) * 10, y*scl + noise(y) * 10, 1, 1);

  translate(width/2, height/2 + 150);
  rotateX(PI/3);
  translate(-w/2, -h/2);
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    // match the lower value (87) with the background brightness
    float brightness = map(y, 0, rows-1, 87, 256);
    fill(85, 83, brightness);
    for (int x = 0; x < cols; x++) {
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }
  
  delay(125);
}
