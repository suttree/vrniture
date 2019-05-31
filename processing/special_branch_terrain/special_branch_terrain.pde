// Via https://www.youtube.com/watch?v=IKB1hWWedMk
// and https://github.com/CodingTrain/website/blob/master/CodingChallenges/CC_011_PerlinNoiseTerrain/CC_011_PerlinNoiseTerrain.pde
// audio via: https://freesound.org/people/kvgarlic/sounds/135472/

// TODO: animate the sky colour and brightness to reflect a passing day
PFont font;  

//import processing.sound.*;
//SoundFile file;

int cols, rows;
int scl = 20;
int w = 2800;
int h = 1600;
int counter = 0;

float flying = 0;
float[][] terrain;
ArrayList<PVector> stars;

void setup() {
  fullScreen(P3D);
  noCursor();
    
  smooth();
  colorMode(HSB);

  //font = createFont("Arial Bold", 36);
  
  cols = w / scl;
  rows = h / scl;
  terrain = new float[cols][rows];
  stars = new ArrayList<PVector>();
  
  for (int y = 0; y < 15; y++) {
    for (int x = 0; x < cols; x++) {
      if (random(5) > 4.875) {
        stars.add( new PVector(x*scl + (noise(x) * 12), y*scl + (noise(y) * 14)) );
      }
    }
  }
  
  frameRate(4);
  
  //file = new SoundFile(this, "field.wav");
  //file.loop();
}


void draw() {
  lights(); 
  ambientLight(64,64,64); // TODO is this the right colour here? do we need it?
 
  // Calculate sky colour and sun/moon position to simulate daytime and nighttime
  color sky;
  counter++;
  if (counter < 10) {
    sky = color(199, 57, 38); // moonlight 
  } else if (frameCount < 20) {
    sky = color(199, 57, 50); // sunrise
  } else if (frameCount < 30) {
    //file.loop();
    sky = color(199, 57, 90); // daylight
  } else if (frameCount < 40) {
    sky = color(199, 57, 100); // noon
  } else if (frameCount < 50) {
    sky = color(199, 57, 90); // daylight
  } else if (frameCount < 60) {
    sky = color(199, 57, 86); // evening
  } else if (frameCount < 70) {
    sky = color(199, 57, 58); // sunset
  } else if (frameCount < 80) {
    //file.stop();
    sky = color(199, 57, 35); // moonlight again
  } else {
    counter = 0;
    sky = color(199, 57, 30); // moonlight again (reset counter)
  }

  // move light from from -1, 1, 1 to 1, 1, 1 (left to right)
  // move light from x, 1, 1 to x, 0, 1 (top to middle)
  //directionalLight(128,128,128, 0, 0, -1);  // light from viewer
  directionalLight(128,128,128, 0, 1, 0);   // light from above
  directionalLight(128, 128, 128, 1, 1, 1); // light from middle, above and the back
  
  background(sky);
  
  fill(255);
  //textFont(font, 36);
  //text(counter, 20, 40);
  
  // Add some stars (as the sky becomes brighter they'll fade from view...)
  fill(225);
  for(int i = 0; i < stars.size(); i++) {
    rect(stars.get(i).x, stars.get(i).y, 1, 1);
  }

  // Move the terrain forwards
  flying -= 0.1;
  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      xoff += 0.045;
    }
    yoff += 0.045;
  }
  
  // Render the terrain
  noStroke();
  translate(width/2, height/2 + 150);
  rotateX(PI/3);
  translate(-w/2, -h/2);
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    // TODO: match the lower value here (87) with the background brightness
    float brightness = map(y, 0, rows-1, 87, 256);
    fill(127, 68, brightness, 10 + (y*5));
    for (int x = 0; x < cols; x++) {
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }
  
  delay(125);
}
