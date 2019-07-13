// Color Harmony library: https://github.com/cageehv/ColorHarmony/
import com.cage.colorharmony.*;

// Create a colorharmony instance
ColorHarmony colorHarmony = new ColorHarmony(this);

// Fetch a random palette
color[] colors = colorHarmony.GetRandomPalette();

color c1 = colors[(int)random(8)];
color c2 = colors[(int)random(8)];

float t = 0.0;
  
void setup() {
  fullScreen(P3D);
  //size(640, 480, P3D);
  
  noCursor();
  smooth(8);
  
  frameRate(random(0, 60));
}

void draw() {
  background(0, 0, 0, 95);

  color c = lerpColor(c1, c2, t);

  fill(c);
  noStroke();
  rect(0, 0, width, height);
 
  t = t + 0.01;
  if (t >= 1.0) {
    t = 0.0;

    // Just random colour changes
    //c1 = colors[(int)random(8)];
    //c2 = colors[(int)random(8)];
    
    // Stepped colour changes
    c1 = c2;
    c2 = colors[(int)random(8)];
  }
  
  // Change the palette infrequently
  if ( frameCount % 500 == 0 ) {
    color[] colors = colorHarmony.GetRandomPalette();
  }
}
