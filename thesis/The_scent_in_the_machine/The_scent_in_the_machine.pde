/** 
 * Multi Page Buttons (v1.7)
 * by GoToLoop (2013/Oct)
 *
 * Forum.Processing.org/two/discussion/558/creating-a-next-page-button#Item_8
 * Studio.ProcessingTogether.com/sp/pad/export/ro.9eDRvB4LRmLrr
 */

//import controlP5 anad serial
import controlP5.*; //import ControlP5 library
import processing.serial.*;
import processing.video.*;
Serial port;
ControlP5 cp5; //create ControlP5 object
static final int MAX = 8, GAP = 25, DIM = 120, RAD = DIM >> 1;
int page, cx, cy;

//Backgound image initial
//1728, 1050 for fullscreen
PImage bg1, purple_img1, purple_img2, purple_img3, purple_img4, 
       purple_img5, purple_img6,
       bean, oil;
PShape rect;
String text1, text2, text3, text4, text4mouse, text5, text5box, text6, text7, text8, text9, text10, text11;
PFont snell, inst; 

int x = 1728; //window width
int y = 1050; //window height
int nav_gap = 20;
int nav_w = 180;
int nav_h = 100;

int tbx = x/2, tby = y/2, tbw = 760, tbh = 400;

//Textfield initial
String textValue = "";
int tposx, tposy;

Button back, next, click1, click2, click3, click4, click5, click6;

Movie movie, dither1, dither2, dither3, bounce;

boolean is_movie_finished(Movie m) { 
  return m.duration() - m.time() < 0.1; 
}

//for icon
float xpos = 846; 
float ypos = 260;



void setup() {
//button setup
  size(1728, 1050);
  
  //noLoop();
  smooth();
  rectMode(CORNER);
  ellipseMode(CENTER);
  textAlign(CENTER, CENTER);
  stroke(0);
  strokeWeight(0.5);
  cx = width  >> 1;
  cy = height >> 1;
  //textfield setup
  tposx = x/2-250;
  tposy = y/2+300;
  
  back = new Button("go back", GAP, height - Button.H - GAP);
  next = new Button("keep going", width - Button.W - GAP, height - Button.H - GAP);
  click1 = new Button("yes", tposx-100, tposy-5);
  click2 = new Button("no", tposx+218, tposy-5);
  click3 = new Button("my defaults", 300, 450);
  click4 = new Button("my history", 600, 600);
  click5 = new Button("my preference", 450, 800);
  click6 = new Button("my ads", 900, 500);
  
//ESTABLISH SERIAL PORT
  //port = new Serial(this, "/dev/cu.usbmodem101", 9600);   //Change this to your port
  port = new Serial(this, "/dev/cu.Bluetooth-Incoming-Port", 9600);

  snell = createFont("SnellRoundhand",23);
  inst = createFont("AndaleMono", 11);
  
  cp5 = new ControlP5(this);
  cp5.addTextfield("")
   .setPosition(tposx, tposy)
   .setSize(500,30)
   .setFont(snell)
   .setFocus(true)
   .setColor(color(255,0,0))
   .setColorBackground(color(#D4D4D4))
   .setColorActive(color(#00FFFF));
   textFont(snell);
   
  movie = new Movie(this, "hand-mouse.mp4");
  dither1 = new Movie(this, "dither1.mp4");
  dither2 = new Movie(this, "dither2.mp4");
  dither3 = new Movie(this, "dither3.mp4");
  bounce = new Movie(this, "bouncevid.mp4");
  
  purple_img1 = loadImage("black.png");
  purple_img2 = loadImage("black1.png");
  purple_img3 = loadImage("black2.png");
  purple_img4 = loadImage("dither1.png");
  purple_img5 = loadImage("black.png");
  purple_img6 = loadImage("green1.png");
  
  bean = loadImage("greenbean.png");
  oil = loadImage("greenoil.png");
}




void draw() {
  method("page" + page); // Works on Java Mode only!
  //pageSelector();        // Workaround for PJS. But works on Java Mode as well!
  background(bg1);
  fill(255);
  rect(x-(nav_gap+nav_w), nav_gap, nav_w, nav_h);
  fill(0);
  textSize(0014);
  textFont(inst);
  text("\n to navigate:\n" + "R arrow key: keep going\n" + "L arrow key: go back\n" + "[type] into text bar" + "\nenter: submit & proceed\n" , x - (nav_w/2 + nav_gap), nav_h/2 + nav_gap);
  textFont(snell);
  
  textSize(0012);
  fill(Button.TXTC);
  textSize(Button.TXTSZ);
  if (page > 0)    back.display();
  if (page < MAX)  next.display();
  
  if (page == 0)   {//noStroke();
                    //shape(rect);
                    fill(#8F00FF);
                    textSize(80);
                    text(text1, cx, cy);
                    fill(#00A7A7);
                    textSize(0030);
                    text("Play me", cx, tposy-65);
                    textSize(0025);
                    text("[Press the right arrow key or click 'keep going' to start]", cx, tposy-37);
  }
  if (page == 1)   {//noStroke();
                    //shape(rect);
                    fill(#8F00FF);
                    textSize(0060);
                    text(text2, cx, cy);
                    fill(#00A7A7);
                    textSize(0025);
                    text("[keep going]", cx, tposy-45);
  }
  if (page == 2)   {//noStroke();
                    //shape(rect);
                    fill(#D39BFF);
                    image(dither1, mouseX, mouseY, 250, 200);
                    if (is_movie_finished(dither1)) {
                      dither1.jump(0);
                    }
                    textSize(0060);
                    text(text3, cx, cy);
                    fill(#00A7A7);
                    textSize(0025);
                    text("[move your mouse and keep going]", cx, tposy-45);
                    
  }
  
  if (page == 3)   {//click1.display(); click2.display();
                    //noStroke();
                    shape(rect);
                    image(movie, mouseX, mouseY); 
                    image(movie, 200, 600); 
                    image(movie, 600, 100);
                    image(movie, 1800, 900);
                    image(movie, 1600, 500);
                    image(movie, 1550, 200);
                    image(movie, 550, 750);
                    fill(#FFFFFF);
                    textSize(0050);
                    text(text4, cx, cy);
                    textSize(0050);
                    text(text4mouse, mouseX, mouseY);
                    fill(#00A7A7);
                    textSize(0025);
                    text("[move your mouse and keep going]", cx, tposy-45);
  }
  if (page == 4)   {fill(#24FF00);
                    textSize(0060);
                    text(text5, cx, cy);
                    fill(#00A7A7);
                    textSize(0030);
                    text(text5box, cx, tposy-45);
  }
  if (page == 5)   {fill(#000000);
                    imageMode(CENTER);
                    image(bean, xpos, ypos, 200, 100);
                    textSize(0060);
                    text(text6, cx, cy);
                    fill(#00A7A7);
                    textSize(0030);
                    text(text7, cx, tposy-45);
                      
  }
  if (page == 6)   {fill(#FFFFFF);
                    textSize(0050);
                    image(dither2, cx, cy-100);
                    image(dither3, mouseX, mouseY, 420, 230);
                    fill(#FFFFFF);
                    textSize(0040);
                    text(text8, mouseX, mouseY);
                    image(oil, mouseX, mouseY - 200 , 100, 170);
                    if (is_movie_finished(dither2)) {
                      print("jump");
                      dither2.jump(0);
                    }
                    if (is_movie_finished(dither3)) {
                      dither3.jump(0);
                    }
                    fill(#00A7A7);
                    textSize(0025);
                    text("[move your mouse and keep going]", cx, tposy-45);
  }
  if (page == 7)   {fill(#8F00FF);
                    textSize(0060);
                    text(text9, cx, cy);
                    fill(#D39BFF);
                    text(text10, mouseX, mouseY);
                    fill(#00A7A7);
                    textSize(0025);
                    text("[keep going]", cx, tposy-45);
  }
  if (page == 8)   {fill(#8F00FF);
                    textSize(80);
                    text(text11, cx, cy);
                    fill(#00A7A7);
                    textSize(0030);
                    text("The end.", cx, tposy-45);
  }
}

//CLICKS AND KEYPRESSES///////////////////////////////
void keyPressed() {
  if (key == ENTER) {++page;}
  
  if (key == CODED) {
    if (keyCode == RIGHT) {
      ++page;}
    if (keyCode == LEFT) {
      --page;}
  }
    
  if (key == CODED) {
    if (page == 1 && keyCode == RIGHT) {println('d'); port.write('d');} //page 1
    if (page == 2 && keyCode == LEFT) {println('d'); port.write('d');} //page 1
    if (page == 2 && keyCode == RIGHT) {println('a'); port.write('a');} //page 2
    if (page == 3 && keyCode == LEFT) {println('a'); port.write('a');} //page 2
    if (page == 3 && keyCode == RIGHT) {println('s'); port.write('s');} //page 3
    if (page == 4 && keyCode == LEFT) {println('s'); port.write('s');} //page 3
    if (page == 5 && keyCode == RIGHT) {println("d+w"); port.write('d'); port.write('s');} //page 5
    if (page == 6 && keyCode == LEFT) {println("d+w"); port.write('d'); port.write('s');} //page 5
    if (page == 6 && keyCode == RIGHT) {println("a+w"); port.write('a'); port.write('s');} //page 6
    if (page == 7 && keyCode == LEFT) {println("a+w"); port.write('a'); port.write('s');} //page 6
    if (page == 7 && keyCode == RIGHT) {println('s'); port.write('s');} //page 7
    if (page == 8 && keyCode == LEFT) {println('s'); port.write('s');} //page 7
    if (page == 8 && keyCode == RIGHT) {println("s+w"); port.write('w'); println('s'); port.write('s');}
  }
  
  if  (page == 4 && key == ENTER) {println("w+d"); 
        port.write('w');
        port.write('d');
        }
  if  (page == 5 && key == ENTER) {println("w+a"); 
        port.write('w');
        port.write('a');
        }
  if  (page == 6 && key == ENTER) {println('w'); 
        port.write('w');
        }
        
        
  if (key == '1') {
    println('d'); 
    port.write('d');
  }
  if (key == '2') {
    println('a'); 
    port.write('a');
  }
  if (key == '3') {
  println('s'); 
  port.write('s');
  }
  if (key == '4') {
  println('w'); 
  port.write('w');
  }

}


void mousePressed() {
  if      (page > 0   && back.isHovering)  --page;
  if      (page < MAX && next.isHovering)  ++page;
  if      (page == 1 && next.isHovering) {println('d'); port.write('d');}//page 1
  if      (page == 2 && back.isHovering) {println('d'); port.write('d');}//page 1
  if      (page == 2 && next.isHovering) {println('a'); port.write('a');}//page 2
  if      (page == 3 && back.isHovering) {println('a'); port.write('a');}//page 2
  if      (page == 3 && next.isHovering) {println('s'); port.write('s');}//page 3
  if      (page == 4 && back.isHovering) {println('s'); port.write('s');}//page 3
  if      (page == 5 && next.isHovering) {println("d+w"); port.write('d'); port.write('w');}//page 5
  if      (page == 6 && back.isHovering) {println("d+w"); port.write('d'); port.write('w');}//page 5
  if      (page == 6 && next.isHovering) {println("a+w"); port.write('a'); port.write('w');}//page 6
  if      (page == 7 && back.isHovering) {println("a+w"); port.write('a'); port.write('w');}//page 6
  if      (page == 7 && next.isHovering) {println('s'); port.write('s');}//page 7
  if      (page == 8 && back.isHovering) {println('s'); port.write('s');}//page 7
  if      (page == 8 && next.isHovering) {println("w+s"); port.write('w'); port.write('s');}//page 8
  
}

void mouseMoved() {
  back.isInside();
  next.isInside();
  click1.isInside();
  click2.isInside();
  click3.isInside();
  click4.isInside();
  click5.isInside();
  click6.isInside();

  //redraw();
}


//PAGES/////////////////////////////////////////////
void page0() {
  bg1 = purple_img1; 
  bg1.resize(x, y); // resize bg image
  imageMode(CENTER);
  rect = createShape(RECT, tbx-(tbw/2), tby-(tbh/2), tbw, tbh);
  //rect.setFill(#252227);
  text1 = "The scent in the machine";
}

void page1() {
  bg1 = purple_img2;
  bg1.resize(x, y);
  rect = createShape(RECT, tbx-(tbw/2), tby-(tbh/2), tbw, tbh);
  //rect.setFill(#392E41);
  text2 = "On the other side of our screens,"
          + "\n an invisible workforce is built" 
          + "\n with only an internet connection and a computer.";
}

void page2() {
  bg1 = purple_img3;
  bg1.resize(x, y);
  rect = createShape(RECT, tbx-(tbw/2), tby-(tbh/2), tbw, tbh);
  //rect.setFill(#55396A);
  text3 = "By carrying out the"
          + "\n cleaning" 
          + "\n scrubbing"
          + "\n organizing of data; "
          + "\n they prop up the opaque, automated windows"
          + "\n in our novel, 'intelligent' screens.";
  dither1.loop();
}

void page3() {
  dither1.stop();
  bg1 = purple_img4;
  bg1.resize(x, y);
  rect = createShape(RECT, tbx-((tbw)/2), tby-((tbh-180)/2), tbw, tbh-180);
  rect.setFill(#000000);
  text4 = "How can scent carry traces of the digital tasker,"
          + "\n by lingering beyond the generated windows,";
  text4mouse = "where their work"
             + "\n is intangible"
             + "\n and vanishing?";

  movie.loop();
}

void page4() {
  movie.stop();
  bg1 = purple_img5;
  bg1.resize(x, y);
  text5 = "You log on to your computer," 
          + "\n getting ready for another day of being online.";
  text5box = "What is your username?" 
          +"\n[ press return to submit ]";
}

void page5() {
  bg1 = purple_img6;
  bg1.resize(x, y);
  text6 = "You think of queuing up some music" 
          + "\n to set the ambiance.";
          
  text7 = "What are you in the mood for?" 
          +"\n[ press return to submit ]";
}

void page6() {
  bg1 = purple_img6;
  bg1.resize(x, y);
  dither2.loop();
  dither3.loop();
  text8 = "Kala sits at her home desk"
          + "\n in Bangalore, with coffee brewing,"
          + "\n hearing traffic going by,"
          + "\n sorting phrases by their emotions";
}

void page7() {
  bg1 = purple_img2;
  bg1.resize(x, y);
  text9 = "One name among the massive population"
          + "\n of ghostworkers around the world,";
  text10 = "How can their labors"
          + "\nresist reduction"
          + "\nby data?";
}

void page8() {
  bg1 = purple_img1; 
  bg1.resize(x, y); // resize bg image
  imageMode(CENTER);
  rect = createShape(RECT, tbx-(tbw/2), tby-(tbh/2), tbw, tbh);
  rect.setFill(#252227);
  text11 = "...the scent in the machine";

}


void pageSelector() { // Replaces method("") for PJS
  switch(page) {
  case 0: 
    page0();
    break;

  case 1: 
    page1();
    break;

  case 2: 
    page2();
    break;
    
  case 3: 
    page3();
    break; 
    
  case 4: 
    page4();
    break;
        
  case 5: 
    page5();
    break;
    
  case 6: 
    page6();
    break;
    
  case 7: 
    page7();
    break;
    
  case 8: 
    page8();
    break;
  }
}

void movieEvent(Movie m){
  if (m == dither1){
    dither1.read();
  } else if (m == movie) {
    movie.read();
  } else if (m == dither2) {
    dither2.read();
  } else if (m == dither3) {
    dither3.read();
  } else if (m == bounce) {
    dither3.read();
  }
  
}

public void clear() {
  cp5.get(Textfield.class,"textValue").clear();
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
  }
}

public void input(String theText) {
  // automatically receives results from controller input
  println("a textfield event for controller 'input' : "+theText);
}

class Button {
  static final int W = 80, H = 40, TXTSZ = 015;
  static final color BTNC = #00A0A0, HOVC = #00FFFF, TXTC = 0;

  final String label;
  final int x, y, xW, yH;

  boolean isHovering;

  Button(String txt, int xx, int yy) {
    label = txt;

    x = xx;
    y = yy;

    xW = xx + W;
    yH = yy + H;
  }

  void display() {
    fill(isHovering? HOVC : BTNC);
    rect(x, y, W, H);

    fill(TXTC);
    text(label, x + W/2, y + H/2);
  }

  boolean isInside() {
    return isHovering = mouseX > x & mouseX < xW & mouseY > y & mouseY < yH;
  }
}
