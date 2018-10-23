import peasy.*;
import gifAnimation.*;

PeasyCam cam;

int columns, rows;
int scl = 20;
int w = 1920;
int h = 1080;

float flying = 0;

float[][] terrain;

GifMaker gifExport;
int frames = 0;
int totalFrames = 100;

void setup() {

  size(600, 600 , P3D);

  columns = w / scl;
  rows = h / scl;
  terrain = new float[columns][rows];
  
  cam = new PeasyCam(this, 1000);

  gifExport = new GifMaker(this, "export.gif", 255, 255);
  gifExport.setRepeat(0); // make it an "endless" animation
}

void draw() {
 
  flying += -0.03;
  
   float yoff = flying;
   for (int y = 0; y < rows; y++) {
     float xoff = 0;
    for(int x = 0; x < columns; x++) {
      terrain[x][y] = map(noise(xoff,yoff),0,1,-40,100);
      xoff += 0.1;
    }
    yoff += 0.1;
   }
  
  
  background (0);
  stroke(255);
  noFill();
  translate(width/2,height/2);
  rotateX(PI/3);
  
  translate(-w/2,-h/2);
  
  
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for(int x = 0; x < columns; x++) {
       
       vertex(x*scl, y*scl, terrain[x][y]);
       vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
       
       // rect(x*scl, y*scl, scl, scl);
     
    }
    endShape();
  }
  export();
}

void export() {
  if(frames < totalFrames) {
    gifExport.setDelay(30);
    gifExport.addFrame();
    frames++;
  } else {
    gifExport.finish();
    frames++;
    println("gif saved");
    exit();
  }
}