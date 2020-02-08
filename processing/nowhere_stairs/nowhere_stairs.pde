// Color Harmony library: https://github.com/cageehv/ColorHarmony/
import com.cage.colorharmony.*;
ColorHarmony colorHarmony = new ColorHarmony(this);
color[] colors = colorHarmony.Monochromatic();

void setup() {
  fullScreen();
  //size(640, 480);
  noCursor();

  background(48, 48, 48);
}

void draw() {  
  float gapx = 40;
  float gapy = 100;
  float startx = 40;
  float starty = 40;
  float perspective = 0;
  float curve = 0.2;
  for(int i = 0; i < 50; i++) {
    fill(colors[1], 50);
    if (gapx > 0) {
      if (true) {
        quad(startx, starty, startx + gapx, starty + perspective + curve, startx + gapx - curve, starty + gapy - perspective, startx - curve, starty + gapy - curve);
        
        startx = startx + gapx - curve;
        starty = starty + 1 + curve;
        gapx -= 1;
        gapy -= 2;
        perspective += 0.025;
        curve += 0.2;
      } else {
        quad(startx, starty, startx + gapx, starty + perspective, startx + gapx, starty + gapy - perspective, startx, starty + gapy);
        
        startx = startx + gapx;
        starty += 1;
        gapx -= 1;
        gapy -= 2;
        perspective += 0.025;
      }
    }
  }
}
