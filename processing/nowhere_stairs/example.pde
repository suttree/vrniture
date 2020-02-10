float z;

void setup()
{
   size(500,500, P3D);
   z = 0;
}

void draw()
{
  background(255);
   translate(width/2, height/2, z);
   rect(0, 0, 50, 50); 
}

void mouseMoved(){
  z = map(mouseX, 0, width, 0, 500);
}
