// Color Harmony library: https://github.com/cageehv/ColorHarmony/
import com.cage.colorharmony.*;
ColorHarmony colorHarmony = new ColorHarmony(this);
color[] colors = colorHarmony.Analogous();

void setup() {
  fullScreen();
  //size(640, 480);
  noCursor();

  background(48, 48, 48);
}

void draw() {
  // draw a parralleogram
  // change the angle
  // shrink
  // repeat
  //quad(38, 31, 86, 20, 69, 63, 30, 76);
  quad(40, 40, 60, 40, 60, 140, 40, 140);
  
  int gapx = 40;
  int gapy = 100;
  int startx = 40;
  int starty = 40;
  int perspective = 0;
  for(int i = 0; i < 50; i++) {
    if (gapx > 0) {
      quad(startx, starty, startx + gapx, starty + perspective, startx + gapx, starty + gapy - perspective, startx, starty + gapy);
      startx = startx + gapx;
      starty += 1;
      gapx -= 1;
      gapy -= 2;
      perspective += 0.025;
    }
  }
}
