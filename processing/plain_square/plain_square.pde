// Color Harmony library: https://github.com/cageehv/ColorHarmony/
import com.cage.colorharmony.*;

// Create a colorharmony instance
ColorHarmony colorHarmony = new ColorHarmony(this);

// The harmonized palette
//color[] colors = new color[8];

// Fetch a monochromatic palette, based on a random base colour
//color[] colors = colorHarmony.Monochromatic();

// Fetch a random palette
color[] colors = colorHarmony.GetRandomPalette();

//println("Palette type: " + colorHarmony.GetCurrentTypeText() + ", base color: #" + colorHarmony.GetBaseColor());

// Pick and use a random colour
// color c = colors[(int)random(8)];

color c1 = colors[(int)random(8)];
color c2 = colors[(int)random(8)];

float t = 0.0;
  
void setup() {
  //fullScreen(P3D);
  size(640, 480, P3D);
  
  noCursor();
  smooth(8);
  
  //frameRate(3);
}

void draw() {

  /*
  // Change the color infrequently
  if (frameRate % 100 == 0) {
    c = colors[(int)random(8)];
  }
  */
  
  background(0, 0, 0, 90);

  noStroke();

  t = t + 0.01;
  color c = lerpColor(c1, c2, t);
  println(t);
  println(c);
  println("---");

  fill(c);
  rect(0, 0, width, height);
  
  if (t >= 1.0) {
    println("HERE");
    t = 0.0;
    c1 = colors[(int)random(8)];
    c2 = colors[(int)random(8)];
  }
  
  // Change the palette infrequently
  if ( frameCount % 250 == 0 ) {
    println("change");
    color[] colors = colorHarmony.GetRandomPalette();
  }
}
