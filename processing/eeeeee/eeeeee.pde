void setup () {
  //fullScreen();
  smooth();
  size(640, 480);
}

void draw () {
  background(201, 53, 53);

  textSize(18);
  text("x: " + mouseX + " y: " + mouseY, 10, 25); 
}