// Fix other curve
// Draw each on step a layer then render in reverse order? ugh

// Color Harmony library: https://github.com/cageehv/ColorHarmony/
import com.cage.colorharmony.*;
ColorHarmony colorHarmony = new ColorHarmony(this);
color[] colors = colorHarmony.Monochromatic();

float startx;
float starty;
float gapx;
float gapy;
float perspective;
float curve;
float xoff = 0.75;

void setup() {
  fullScreen();
  //size(640, 480);
  noCursor();
  colorMode(HSB, 255);
  frameRate(24);
  
  stroke(48, 48, 48, 90);
  strokeWeight(1);
  background(48, 48, 48, 40);
}

void draw() {
  /*
  for( int i = 0; i < width; i++){
    stroke(map(i,0,width,150,255),0,255-map(i,0,width,150,255));
    line(i,0,i,height);
  }
  */

  startx = -20;
  starty = height / 3;
  
  gapx = 80;
  gapy = 200;
  perspective = 0;
  curve = 0.2;

  float hue_color = hue(colors[1]);
  float saturation_color = saturation(colors[1]);
  float brightness_color = brightness(colors[1]);
  
  float max = map(frameCount, 0, 500, 0, 1000);  

  for(int i = 0; i < max; i++) {
    float temp = brightness_color - map(i, 0, 255, 0, max);
    fill(hue_color, saturation_color, temp);

    if (gapx > 0) {
      if (i%2==0) {
        quad(
          startx, 
          starty, 
          
          startx + gapx, 
          (starty + perspective + curve), 
          
          startx + gapx - curve, 
          (starty + gapy - perspective), 
          
          startx - curve, 
          (starty + gapy - curve)
        );
        
        startx = startx + gapx - curve;
        starty = starty + 1 + curve;
        gapx -= 4;
        gapy -= 4;
        perspective += 0.025;
        curve += 0.5;
        
        gapx -= noise(xoff);
        gapy -= noise(xoff);
      } else {
        quad(
          startx, 
          starty, 
          
          startx + gapx - perspective + curve, 
          starty,

          startx + gapx - perspective - curve,           
          starty + gapy - perspective,

          startx - perspective - curve, 
          starty + gapy - curve
        );
       
        startx = startx + gapx - curve;
        starty = starty + 1 + curve;
        gapx -= 4;
        gapy -= 4;
        perspective += 0.025;
        curve += 0.5;
        
        gapx -= noise(xoff);
        gapy -= noise(xoff);
      }
    } else {
      startx = random(-50, -10);
      starty = random(0, height);
    
      gapx = 80;
      gapy = 200;
      perspective = 0;
      curve = 0.2;
      
      background(48, 48, 48, 40);
    }
  }
  xoff += 0.0075;
  delay(1125);
}
