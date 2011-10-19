import processing.serial.*;

import cc.arduino.*;

Arduino arduino;

void setup() {
  size(170, 370);
  arduino = new Arduino(this, Arduino.list()[2], 57600);
  println(Arduino.list());
  for (int i = 0; i <= 13; i++)
    arduino.pinMode(i, Arduino.INPUT);
}

void draw() {
  background(0,0,0);
  color active = color(255,255,255);
  color inactive = color(100,100,100);
  textSize(16);
  fill(inactive);
  float temp = 0;
  int niceTemp;
  int leftMargin = 40;
  int topMargin = 40;
  
  int cutoff = 26;
  
  temp = ((arduino.analogRead(0) * .004882814) - .5) * 100;
  niceTemp = int(temp);
    
  for (int i=0; i<16; i++) {
    fill(inactive);
    int  y = topMargin + i * 20;
    if (i+15 == niceTemp) {      
      fill(active);
    }
    text(i+15, leftMargin, y);
    if (i == cutoff-15) {
      stroke(200, 0, 0);
      rect(10, y+4, 170, 0);
    }
  }
  
  if (temp > cutoff + 1) {
    fill(active);
  } else {
    fill(inactive);
  }
  text("Open", 110, (cutoff-14) * 20 + topMargin);
  
  delay(400);
}
