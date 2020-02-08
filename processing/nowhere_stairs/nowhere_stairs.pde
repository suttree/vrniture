// Color Harmony library: https://github.com/cageehv/ColorHarmony/
import com.cage.colorharmony.*;
ColorHarmony colorHarmony = new ColorHarmony(this);
color[] colors = colorHarmony.Monochromatic();

float xoff = 0.75;

void setup() {
  fullScreen();
  //size(640, 480);
  noCursor();
  colorMode(HSB, 255);
  frameRate(24);
}

void draw() {
  float startx = -20;
  float starty = height / 3;

  float gapx = 80;
  float gapy = 200;
  float perspective = 0;
  float curve = 0.2;
  
  float hue_color = hue(colors[1]);
  float saturation_color = saturation(colors[1]);
  float brightness_color = brightness(colors[1]);

  stroke(48, 48, 48);
  background(48, 48, 48);
  
  for(int i = 0; i < frameCount; i++) {
    brightness_color -= 5;
    fill(hue_color, saturation_color, brightness_color, 50);
    if (gapx > 0) {
      if (true) {
        quad(startx, starty, startx + gapx, starty + perspective + curve, startx + gapx - curve, starty + gapy - perspective, startx - curve, starty + gapy - curve);
        
        startx = startx + gapx - curve;
        starty = starty + 1 + curve;
        gapx -= 4;
        gapy -= 4;
        perspective += 0.025;
        curve += 0.5;
        
        gapx -= noise(xoff);
        gapy -= noise(xoff);
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
  xoff += 0.0075;
  delay(125);
}
