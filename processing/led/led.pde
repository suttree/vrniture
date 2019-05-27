//import gifAnimation.*;

//GifMaker gifExport;
int frames = 0;
int totalFrames = 120;

float t = 0;
float gap = 2;
int offset = 6;
int boxSize = 160;
int boxLayers = 3;

float[][] boxColours = {                                                                                                                                                   
  {245, 195, 72}, 
  {103, 203, 255}, 
  {55, 230, 180}, 
  {255, 129, 240}, 
  {120, 221, 208}, 
  {70, 156, 101}, 
  {203, 223, 88}, 
  {32, 187, 210}
};

float[][] boxColours2 = boxColours;


// array of colours
// shift the array on each draw() so that leds lights travel along the wall

void setup() {
  //size(640, 480, P3D);
  fullScreen();
  smooth();
  noCursos();
  
  //gifExport = new GifMaker(this, "export.gif", 100);
  //gifExport.setRepeat(0); // make it an "endless" animation
}

void draw() {
  background(49, 54, 57);

  pushMatrix();
  translate(0, height/2 - boxSize/2);
  // draw a line of rects
  for(int h = 0; h < 1; h++) {
    for (int i = 0; i < (width/boxSize) + 2; i++ ) {
      float[] c = boxColours[i];
      stroke(34);
      fill(c[0], c[1], c[2]);
      rect((i * boxSize - boxSize/3) + (i * gap), (height/2 - boxSize/4) + (h * boxSize) - height/2 + gap, boxSize, boxSize, 0);
  
      noStroke();
      for (int j = 0; j < boxLayers; j++) {
        t = t + 0.01;
        fill(c[0], c[1], c[2], noise(t) * 50 * j);
        rect((i * boxSize - boxSize/3) + (i * gap) + (offset * j) + 1, (height/2 - boxSize/4) + (h * boxSize) - (offset * j) - 1 - height/2 + gap, boxSize, boxSize, 0);
      }
    }
    fill(69, 74, 77, 10);
    rect(0, 0, width, height);
    
    if (frameCount % 12 == 0) {
      for(int i = 0; i < boxColours.length; i++) {
        int j;
        if (i + 1 == boxColours.length) {
          j = 0;
        } else {
          j = i + 1;
        }
          
        boxColours2[i] = boxColours[j];
      }
      boxColours = boxColours2;
    }
  }
  
  popMatrix();

  //t = t + 0.0002;
  //export();
}

void export() {
  if(frames < totalFrames) {
//    gifExport.setDelay(20);
//    gifExport.addFrame();
    frames++;
  } else {
    //gifExport.finish();
    frames++;
    println("gif saved");
    exit();
  }
}
