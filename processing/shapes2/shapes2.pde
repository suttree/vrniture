import gifAnimation.*;

float angle1;
 
void setup() {
  //fullScreen(P3D);
  size(800, 800, P3D);
  noCursor();
  smooth();
  frameRate(30);
}
 
void draw() {
  noFill();
  lights();

  fill(0xee, 0xee, 0xff, 50);
  rect(-100, -100, width + 100, height + 100);
  //angle1+=.00095;
  angle1+=.0035;
  
  int startx = (width/2 - (5*20));
  int starty = (height/2 + (5*10));
 
  for(int i = 0; i < 4; i++) {
    rotateX(angle1);
    for(int j = 0; j < 4; j++) { 
      rect(startx + (i * 40), starty - (j * 40), 10, 10);
    }

    if (angle1 > 1.10) {
      stroke(30, 144, 255); 
      angle1 = 0.0;
    }
  }
  
  // Saving frames to make into a gif later using ImageMagick
  // e.g. convert *.png sketch.gif
  /*
  if(frameCount <= 2500){
    TImage frame = new TImage(width,height,RGB,sketchPath("stills/frame_"+nf(frameCount,3)+".png"));
    frame.set(0,0,get());
    frame.saveThreaded();
  }
  */
}

// From https://stackoverflow.com/questions/22124039/exporting-a-gif-from-a-processing-sketch-w-gif-animation-library
class TImage extends PImage implements Runnable {
  //separate thread for saving images
  String filename;

  TImage(int w, int h, int format, String filename) {
    this.filename = filename;
    init(w,h,format);
  }

  public void saveThreaded() {
    new Thread(this).start();
  }

  public void run() {
    this.save(filename);
  }
}