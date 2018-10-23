import processing.opengl.*;

float x,y,t;
float[] xpos=new float[100];
float[] ypos=new float[100];
void setup(){
 size(400,400);
 smooth();
 noStroke();
 x=y=200;
 for(int i=0;i<100;i++){
   xpos[i]=x;
   ypos[i]=y;
 }
}


void draw(){
 background(255);

 //motion
 t=frameCount/200.0;
 x=noise(t,0)*width;
 y=noise(t,1)*height;


 //shift array
 for(int i=1;i<100;i++){
   xpos[i-1]=xpos[i]+(noise(t,4)-0.5)*2.0;
   ypos[i-1]=ypos[i]+(noise(t,5)-0.5)*2.0;
 }
 xpos[99]=x;
 ypos[99]=y;


 //draw tail
 fill(100,255,0);
 beginShape(TRIANGLE_STRIP);
 for(int i=99;i>0;i--){
   vertex(xpos[i],ypos[i]);
   vertex(xpos[i]+i/5.0,ypos[i]);
 }

 endShape();
 fill(0,255,0);
 beginShape(TRIANGLE_STRIP);
 for(int i=99;i>0;i--){
   vertex(xpos[i],ypos[i]);
   vertex(xpos[i]-i/5.0,ypos[i]);
 }
 endShape();


 //draw object
 fill(0,100,0);
 ellipse(x,y,40,20);

}
