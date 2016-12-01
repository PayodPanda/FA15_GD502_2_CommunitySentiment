

import processing.net.*; 

import controlP5.*;

ControlP5 textBox;

PShape s;

StringList saved;
color bg = color(255, 0, 0), 
fg = color(255,255,255);
color fgt = color(255, 255, 255), 
bgt = color(0, 0, 0);
PFont font0, font1;
Boolean left = true;

Client clientL, clientR; 
String input;

void setup() { 
  size(512, 768, P3D);
  clientL = new Client(this, "10.139.6.85", 10010); 
  clientR = new Client(this, "10.139.5.43", 10020); 
  saved = new StringList();
  // textMode(SHAPE);

  font0 = createFont("arial", 200);
  font1 = createFont("arial", 20);

  textBox = new ControlP5(this);

  textBox.addTextfield("input")
    .setPosition(int(width/2 - 0.3*width), 100)
      .setSize(int(0.6*width), 40)
        .setFont(font1)
          .setFocus(true)
            .setColorBackground(bgt) 
              .setColorActive(bgt) 
                .setColorForeground(bgt)
                  .setColor(fgt)
                    .setColorLabel(bgt) 
                      //.setColorValue(color(0,0,0)) 
                      .setLabelVisible(false)
                        .setLabel(" ") 
                          .align(5, 5, 2, 2) 
                            ;

  s = createShape();
} 

void draw() { 
  background(bg);  
      textBox.setColorBackground(bg) 
              .setColorActive(bg) 
                .setColorForeground(bg);
  
  /*s.beginShape(TRIANGLE_STRIP);
  s.noStroke();
  s.fill(bg);
  s.vertex(0, 0);
  s.vertex(width, 0);
  s.fill(0);
  s.vertex(width, height);
  s.vertex(0, height);
  s.endShape(CLOSE);
  shape(s);*/
  
  randomSeed(5);
  textAlign(CENTER);
  int size = 192;
  textFont(font0);
  for (int i=0; i<saved.size (); i++) {
    fill(random(255), random(255), random(255), 64);
    size *= 0.7;
    if (size <20) textFont(font1);
    textSize(size);
    text(saved.get(i), width/2, 200 + ((i+4)*30));
  }
} 

public void input(String text) {
  if ((text.length()>1) && (text.substring(0, 2).equals("//"))) {
    if (text.substring(2, text.length()).equals("left")) {
      left = true;
      bg = color(255, 0, 0);
    } else if (text.substring(2, text.length()).equals("right")) {
      left = false;
      bg = color(0, 0, 255);
    } else if (text.substring(2, text.length()).equals("clear")) {
      saved.clear();
    } else if ((text.substring(2, text.length()).equals("exit")) || (text.substring(2, text.length()).equals("quit"))) {
      clientR.stop();
      clientL.stop();
      exit();
    }
  } else {
    saved.reverse();
    saved.append(text);
    saved.reverse();
    if (left) {
      clientL.write(text);
    } else clientR.write(text);
  }
}


