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
}
