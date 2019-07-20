// NEXT: same but with contour?
// NEXT: do this with a PShape and perlin edges
//import gifAnimation.*;

//PFont font;
Layer[] layers = new Layer[(int)random(3,8)];

//GifMaker gifExport;
int frames = 0;
int totalFrames = 440;

int gap = width/layers.length;

void setup() {
  smooth();
  //size(800, 800, P3D);
  fullScreen();
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
      color(100 + random(175), random(255), 126),
      random(12)
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
  noStroke();
  fill(0, 38);
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
  float x, y, w, h, xoff;
  float accel = random(0.50, 1.70);
  color c = color(255, 0, 255);
  String status = "ready";
  
  Layer(float _x, float _y, float _w, float _h, color _c, float _xoff) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    c = _c;
    xoff = noise(_xoff);
    
  }
  
  void update() {
    x = x + accel;
    y = y + accel;
    w = w - (accel * 2);
    h = h - (accel * 2);
    println(h);
    if (w <= 0 || h <=0) {
      status = "repeating";
      //accel = 0 - accel;
      x = 0;// - gap + xoff;
      y = 0;// - gap + xoff;
    } else if (w > width && status == "repeating") {
      accel = 0.78;
      c = color(90 + random(175), random(255), 160 + xoff);
    }
  }
  
  void render() {
    noFill();
    fill(c, 10);
    stroke(c);
    strokeWeight(2);
    //rect(x, y, w, h);
    beginShape();
    
    vertex(x, y);
    
    curveVertex(x, y);
    curveVertex(x + random(10,width/2) + xoff, y - random(10,20) - xoff);
    curveVertex((x + w) / 2, y);
    curveVertex(x + w, y);
    
    vertex(x + w, y);
    
    vertex(x + w, y + h);
    vertex(x, y + h);
    endShape(CLOSE);

    //quadraticVertex(x, y, x + (xoff * w), y - (xoff * h/2));
    //quadraticVertex(x, y, x + w/4, y + h/8);
    //quadraticVertex(x + w/4, y + h/8, x + w/2, y);

    xoff = xoff + .0274;
  }
}
