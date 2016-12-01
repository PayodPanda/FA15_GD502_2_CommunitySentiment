
import processing.net.*;

Server rtS;
Client rtMC, rtVC;
String input = " ";
color bg = color(0,0,255);

void setup() 
{

  PFont font0 = createFont("arial", 300);
  size(displayWidth/5, displayHeight, P3D);
  rtS = new Server(this, 10020); // This is the right text server, receiving data from clients directed at right
  rtMC = new Client(this, "127.0.0.1", 10000);        // connect to master
  rtVC = new Client(this, "127.0.0.1", 10025);        // connect to right visual server
  smooth(32);
  textFont(font0);
  fill(bg);
  rect(0, 0, width, height);
}


void draw() {
  noStroke();
  fill(255, 3);
  //rect(0, 0, width, height);

  fill(0);

  Client client = rtS.available();        // define the client that's trying to send messages
  if (client != null) {
    if (client.available() > 0) {            // confirm this client has something to say
      input = client.readString();           // store the string to play with 
      rtMC.write(input);                      // relay to master server
      rtVC.write(input);                      // relay to right visual server
      String[] printThis = split(input, ' ');  // split it by blank spaces
      float[] x = new float[printThis.length];
      float[] y = new float[printThis.length];
      float[] value = new float[printThis.length];
      float valueMin = 999999;
      float lengthMin = 999999;
      float valueMax = 0;
      float lengthMax = 0;

      fill(bg, 100);
      rect(0, 0, width, height);
      noiseSeed(0);
      
      for (int i=0; i<printThis.length; i++) {
        for (int j=0; j<printThis[i].length (); j++) {
          value[i] += int(printThis[i].charAt(j));
        }
        if (value[i] > valueMax) valueMax = value[i];
        if (printThis[i].length() > lengthMax) lengthMax = printThis[i].length();
        if (value[i] < valueMin) valueMin = value[i];
        if (printThis[i].length() < lengthMin) lengthMin = printThis[i].length();
      }

      for (int i=0; i<printThis.length; i++) {
        x[i] = map(noise(printThis[i].length()), 0, 1, -width/3, 4*width/3);
        y[i] = map(noise(value[i]), 0, 1, -height/3, 4*height/3);
        fill(map(printThis[i].length(), lengthMin, lengthMax, 0, 255), map(printThis[i].length(), lengthMin, lengthMax, 255, 0), map(printThis[i].length(), lengthMin, lengthMax, 192, 81), 100);
        textAlign(CENTER, CENTER);
        if (printThis.length == 1) {
          fill(random(255));
          textSize(random(100, 300));
          text(printThis[i], width/2, height/2 + random(-100, 100));
        } else {
          fill(0);
          fill(value[i]%255, 255 - value[i]%255, 128);
          textSize(map(value[i], valueMin, valueMax, 10, 30));
          text(printThis[i], x[i], y[i]);
        }
      }
    }
  }
}

