
import processing.net.*;

Server master;
String input = " ";
color bg = color(255,255,0);

void setup() 
{
  size(displayWidth/5, displayHeight, P3D);
  master = new Server(this, 10015); // This is the right visual server, receiving data from the right text server
  smooth(32);
  fill(bg);
  rect(0, 0, width, height);
}


void draw() {
  noStroke();
  fill(255, 3);
  //rect(0, 0, width, height);

  fill(0);

  Client client = master.available();        // define the client that's trying to send messages
  if (client != null) {
    if (client.available() > 0) {            // confirm this client has something to say
      input = client.readString();           // store the string to play with 
      String[] printThis = split(input, ' ');  // split it by blank spaces
      float[] x = new float[printThis.length];
      float[] y = new float[printThis.length];
      float[] value = new float[printThis.length];
      float valueMin = 999999;
      float lengthMin = 999999;
      float valueMax = 0;
      float lengthMax = 0;

      for (int i=0; i<printThis.length; i++) {
        for (int j=0; j<printThis[i].length (); j++) {
          value[i] += int(printThis[i].charAt(j));
        }
        if (value[i] > valueMax) valueMax = value[i];
        if (printThis[i].length() > lengthMax) lengthMax = printThis[i].length();
        if (value[i] < valueMin) valueMin = value[i];
        if (printThis[i].length() < lengthMin) lengthMin = printThis[i].length();
      }

      fill(bg, 60);
      rect(0, 0, width, height);
      noiseSeed(0);
      PShape lines;
      lines = createShape();
      lines.beginShape(TRIANGLE_STRIP);
      for (int i=0; i<printThis.length; i++) {
        x[i] = map(noise(printThis[i].length()), 0, 1, -width/3, 4*width/3);
        y[i] = map(noise(value[i]), 0, 1, -height/3, 4*height/3);
        lines.stroke(map(printThis[i].length(), lengthMin, lengthMax, 0, 255), map(printThis[i].length(), lengthMin, lengthMax, 255, 0), map(printThis[i].length(), lengthMin, lengthMax, 255, 0));
        lines.fill(map(printThis[i].length(), lengthMin, lengthMax, 0, 255), map(printThis[i].length(), lengthMin, lengthMax, 255, 0), map(printThis[i].length(), lengthMin, lengthMax, 164, 82), 100);
        lines.vertex(x[i], y[i]);
      }
      lines.endShape(CLOSE);
      shape(lines);

      for (int i=0; i<printThis.length; i++) {
        fill(map(printThis[i].length(), lengthMin, lengthMax, 0, 255), map(printThis[i].length(), lengthMin, lengthMax, 255, 0), map(printThis[i].length(), lengthMin, lengthMax, 192, 81), 100);
        ellipse(x[i], y[i], map(value[i], valueMin, valueMax, 40, 100), map(value[i], valueMin, valueMax, 40, 100));
        /*textAlign(CENTER, CENTER);
        if (printThis.length == 1) {
          fill(random(255));
          textSize(random(100, 300));
          text(printThis[i], width/2, height/2 + random(-100, 100));
        } else {
          fill(0);
          fill(value[i]%255, 255 - value[i]%255, 128);
          textSize(map(value[i], valueMin, valueMax, 10, 30));
          text(printThis[i], x[i], y[i]);
        }*/
      }
    }
  }
}

