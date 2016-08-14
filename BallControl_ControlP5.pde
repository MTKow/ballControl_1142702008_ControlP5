import controlP5.*;

//call the boolean and float
boolean drawS;
boolean drawH;
boolean drawA;
boolean drawP;
boolean drawE;
boolean drawT;
float x;
float y;
float easing = 0.05;
float mx;
float speed=2;
float size=100;

ControlP5 cp5;
ColorPicker cp;

int myColorBackground = color(0,0,0);
int colorMin = 100;
int colorMax = 100;
Range range;

int myColor = color(255);
int c1,c2;
float n,n1;

int col = color(255);
boolean toggleValue = false;

void setup() {
  size(720,540); //size of the screen
  noStroke(); //no stroke for all objects
  textSize(100); //set text size to 100
  rectMode(CENTER); //set rectangle mode to center
  
  //drag to change background color.
  cp5 = new ControlP5(this);
  cp = cp5.addColorPicker("picker")
          .setPosition(50,50)
          .setColorValue(color(103,249,255,0))
          ;
  
  //range bar       
  cp5 = new ControlP5(this);
  range = cp5.addRange("rangeController")
             // disable broadcasting since setRange and setRangeValues will trigger an event
             .setBroadcast(false) 
             .setPosition(50,390)
             .setSize(400,40)
             .setHandleSize(20)
             .setRange(0,255)
             .setRangeValues(50,100)
             // after the initialization we turn broadcast back on again
             .setBroadcast(true)
             .setColorForeground(color(255,40))
             ;
  noStroke();
  
   cp5 = new ControlP5(this);
  
  //press buttons will appear different color at the bottom bar.
  // create a new button with name 'buttonA'
  cp5.addButton("colorA")
     .setValue(0)
     .setPosition(500,460)
     .setSize(200,19)
     ;
  
  // and add another 2 buttons
  cp5.addButton("colorB")
     .setValue(100)
     .setPosition(500,480)
     .setSize(200,19)
     ;
     
  cp5.addButton("colorC")
     .setPosition(500,500)
     .setSize(200,19)
     .setValue(0)
     ;
  
  //change the easing ball's color when choosing color in color wheel  
  cp5 = new ControlP5( this );
  cp5.addColorWheel("c" ,480 , 10 , 200 ).setRGB(color(128,0,255));
  noStroke();
  
  //create a toggle to on/off the star.
  cp5 = new ControlP5(this);
  cp5.addToggle("toggle")
     .setPosition(565,349)
     .setSize(50,20)
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     ;
}

int c = color(100);

void draw() { 
  background(cp.getColorValue()); // background color
  
  fill(colorMax);
  rect(360,410,720,80);
  
  fill(myColor);
  rect(360,495,720,100);
  myColor = lerpColor(c1,c2,n);
  n += (1-n)* 0.1; 
  
  pushMatrix();
  fill(col);
  beginShape();
     vertex(590,225);
     vertex(615,265);
     vertex(660,265);
     vertex(625,305);
     vertex(635,350);
     vertex(590,320);
     vertex(545,350);
     vertex(555,305);
     vertex(520,265);
     vertex(565,265);
  endShape(CLOSE); 
  popMatrix();
  
  float targetX = mouseX; //easing speed
  float dx = targetX - x;
  x += dx * easing;
  
  float targetY = mouseY;
  float dy = targetY - y;
  y += dy * easing;
  
  fill(c);
  ellipse(x,y,66,66);  //easing ball
  
  fill(random(255),random(255),random(255));
  ellipse(mx,100,66,66); // a random color ball is moving at the bottom
  mx=mx+speed;
  if(mx>=720||mx<=0){
    speed=speed*-1;
  } //The random color ball will reverse when it hit the sides
  
  if (mousePressed == true){
    fill(252,255,82);
    rect(x, y, size,size); //a yellow rectangle will appear when you press your mouse
    noStroke(); //no stroke for the circle
    cursor(HAND);//when you press mouse, cursor icon will change to hand sign
    size ++;
    if(size>=480){
       size=100;
    }//when the size of the yellow rectangle as same as the height, the size of circle will set as 100
  } 

  if (drawS == true) { 
    text('S',40,100);
  } // text 'S' will appear when drawE is true
 if (drawH == true) { 
    text('H',100,100);
  } // text 'H' will appear when drawE is true
  if (drawA == true) { 
    text('A',170,100);
  } // text 'A' will appear when drawE is true
  if (drawP == true) { 
    text('P',240,100);
  } // text 'P' will appear when drawE is true
  if (drawE == true) { 
    text('E',295 ,100);
  } // text 'E' will appear when drawE is true
  if (drawT == true) { 
    text('S',40,100);
    text('H',100,100);
    text('A',170,100);
    text('P',240,100);
    text('E',295,100); //word "SHAPE" will appear when you press 'SPACE'
  }
}

void keyPressed() {
  if ((key == 'S') || (key == 's')) {
    drawS = true; //when 'S'/'s' is pressed, the 'C' will appear
  }
  if ((key == 'H') || (key == 'h')) {
    drawH = true; //when 'H'/'h' is pressed, the 'C' will appear
  }
  if ((key == 'A') || (key == 'a')) {
    drawA = true; //when 'A'/'a' is pressed, the 'C' will appear
  }
  if ((key == 'P') || (key == 'p')) {
    drawP = true; //when 'P'/'p' is pressed, the 'C' will appear
  }
  if ((key == 'E') || (key == 'e')) {
    drawE = true; //when 'E'/'e' is pressed, the 'C' will appear
  }
  if (key == ' ' ) {
    drawT = true; //when 'SPACE' is pressed, the word 'SHAPE' will appear
  }
  
}

void keyReleased() {
  drawS = false;
  drawH = false;
  drawA = false;
  drawP = false;
  drawE = false;
  drawT = false; //when key are released, the booleans are false
}

void mouseDragged() {
  background (255,211,237); //background will change color when your mouse is dragged
  
  if (mouseX < 360) {
     fill(301,37,75);
     rect(180,270,360,540);// left background 
  
  }else {
    fill(245,151,173);
    rect(540,270,360,540);// right background   
  }
  
  fill(162,255,200);
  triangle(x,y, width/4, 360, 3*width/4, 360);//When you drag your mouse, a triangle will appear in a different color background and drag your mouse to change the top edge of triangle
 
  fill(165,40,86);
  ellipse(mx,400,66,66); //moving ball in dark pink color
  mx=mx+speed; //ball is moving
  if(mx>=720||mx<=0){
    speed=speed*-1;
  } //The speed will be increase when drag your mouse
}
  
public void controlEvent1(ControlEvent theEvent) {
  println(theEvent.getController().getName());
  n = 0;
}

// function colorA will receive changes from 
// controller with name colorA
public void colorA(int theValue) {
  println("a button event from colorA: "+theValue);
  c1 = c2;
  c2 = color(0,160,100);
}

// function colorB will receive changes from 
// controller with name colorB
public void colorB(int theValue) {
  println("a button event from colorB: "+theValue);
  c1 = c2;
  c2 = color(150,0,0);
}

// function colorC will receive changes from 
// controller with name colorC
public void colorC(int theValue) {
  println("a button event from colorC: "+theValue);
  c1 = c2;
  c2 = color(255,255,0);
}

public void controlEvent(ControlEvent c) {
  // when a value change from a ColorPicker is received, extract the ARGB values
  // from the controller's array value
  if(c.isFrom(cp)) {
    int r = int(c.getArrayValue(0));
    int g = int(c.getArrayValue(1));
    int b = int(c.getArrayValue(2));
    int a = int(c.getArrayValue(3));
    color col = color(r,g,b,a);
    println("event \talpha:"+a+"\tred:"+r+"\tgreen:"+g+"\tblue:"+b+"\tcol"+col);
  }
}

// color information from ColorPicker 'picker' are forwarded to the picker(int) function
void picker(int col) {
  println("picker\talpha:"+int(alpha(col))+"\tred:"+int(red(col))+"\tgreen:"+int(green(col))+"\tblue:"+int(blue(col))+"\tcol"+col);
}

// is the boolean is true, star will appear.
void toggle(boolean theStar) {
  if(theStar==true) {
    col = color(103,249,255,0);
  } else {
    col = color(255);
  }
  println("a toggle event.");
}


