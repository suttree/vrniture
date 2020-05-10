// NEXT: same but with contour?
// NEXT: do this with a PShape and perlin edges
//import gifAnimation.*;

//PFont font;
Layer[] layers = new Layer[5];

//GifMaker gifExport;
int frames = 0;
int totalFrames = 824;

int gap = 100;

float _accel = random(0.28, 0.98);
//int _repeat = (int) random(1, 2);
int _repeat = 0;


void setup() {
  noSmooth();
  //size(800, 800, P3D);
  fullScreen(P3D);
  noCursor();
  //font = createFont("Arial Bold", 36);
  
  //gifExport = new GifMaker(this, "export.gif", 255, 255);
  //gifExport.setRepeat(0);

  for(int i = 0; i < layers.length; i++) {
    int start = 0 - (i * gap);
    layers[i] = new Layer(
      start, 
      start, 
      width + (i * gap * 2), 
      height + (i * gap * 2), 
      color(100 + random(155), random(255), 106)
     );
  }
}

void draw() {
  // fps
  /*
  fill(255);
  textFont(font, 36);
  text(frameCount, 20, 40);
  */
  
  //fill(10, 200, 255, 85);
  fill(10, 20);
  rect(0, 0, width, height);
 
  for(int i = 0; i < layers.length; i++) {
    layers[i].render();
    layers[i].update();
  }
  
  //export();
}

/*
void export() {
  if(frames < totalFrames) {
    gifExport.setDelay(60);
    gifExport.addFrame();
    frames++;
  } else {
    gifExport.finish();
    frames++;
    println("gif saved");
    exit();
  }
}
*/

class Layer {
  float x, y, w, h;
  float startx, starty, startw, starth;
  float accel = _accel;
  color c = color(255, 255, 225);
  String status = "ready";
  
  Layer(float _x, float _y, float _w, float _h, color _c) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    c = _c;
    
    startx = x;
    starty = y;
    startw = w;
    starth = h;
  }
  
  void update() {
    x = x + accel;
    y = y + accel;
    w = w - (accel * 2);
    h = h - (accel * 2);
    
    if (w <= 0) {
      status = "repeating";
      
      if (_repeat == 1) {
        accel = 0 - accel;
      } else {
        accel = _accel;
        x = startx;
        y = starty;
        w = startw;
        h = starth;
      }
    } else if (w > width && status == "repeating") {
      accel = _accel;
      c = color(100 + random(155), random(255), random(144, 255));
    }
  }
  
  void render() {
    noFill();
    stroke(c);
    rotateX(PI/24);
    rect(x, y, w, h);
  }
}
