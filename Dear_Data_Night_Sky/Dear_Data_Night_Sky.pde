int lineSeed = 9909;

int startTime = millis();
int timeToReset = 5000;
int timePassed = millis();

boolean mouseReady = true;
boolean showScale = false;
boolean scalesUsed = false;

int scaleLineWidth = 6;
int xScaleWidth;
int yScaleWidth;

String[] days = {"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"};
float[] scaleNumbers;//Will be using processed values when enough data collected= { 01.00, 24.00, 23.00, 22.00, 21.00, }

int startHour = 21;

String[] sleepDataRaw;

float[][] sleepDataProcessed;

float smallestTime = 99;
float largestTime=0;

stellarLine line1;
stellarLine line2;

dataStar[] dataStars;

void setup() {
  size(1491, 700);
  background( 82, 85, 144);
  frameRate(35);
  textAlign(CENTER, CENTER);

  xScaleWidth = width/7;
  yScaleWidth = height/5;

  line1 = new stellarLine(50, 30, 100);
  line2 = new stellarLine(50, 30, 100);

  sleepDataRaw = loadStrings("sleepDataUsable.csv");
  sleepDataProcessed = new float[sleepDataRaw.length][2];

  for (int i = 0; i < sleepDataRaw.length; i ++) {
    String[] tokenA = split(sleepDataRaw[i], ",");
    if (((parseFloat(tokenA[0]) - 12 + 24) % 24) < smallestTime) {
      smallestTime = floor((parseFloat(tokenA[0]) - 12 + 24) % 24);
    }
    if (((parseFloat(tokenA[1]) - 12 + 24) % 24) < smallestTime) {
      smallestTime = floor((parseFloat(tokenA[0]) - 12 + 24) % 24);
    }
    if (((parseFloat(tokenA[0]) - 12 + 24) % 24) > largestTime) {
      largestTime = floor((parseFloat(tokenA[0]) - 12 + 24) % 24);
    }
    if (((parseFloat(tokenA[1]) - 12 + 24) % 24) > largestTime) {
      largestTime = floor((parseFloat(tokenA[1]) - 12 + 24) % 24);
    }

    sleepDataProcessed[i][0] =  parseFloat(tokenA[0]);
    sleepDataProcessed[i][1] = parseFloat(tokenA[1]);
  }
  int minBound = (int)smallestTime + 12;
  int maxBound = (int)largestTime + 12;
  startHour = minBound;
  

  scaleNumbers = new float[maxBound-minBound+1];
  yScaleWidth = height/(1+maxBound-minBound);

  for (int i = maxBound-minBound; i >= 0; i--) {
    scaleNumbers[i] = (i+minBound)%24;
  }

  dataStars = new dataStar[sleepDataProcessed.length*2];
  for (int i = 0; i < sleepDataProcessed.length; i++) {
    int day = i % 7;
    float starHeight = (sleepDataProcessed[i][0] - startHour + 24) % 24;
    starHeight = height - (starHeight*yScaleWidth);
    dataStars[i*2] = new dataStar(day, starHeight, 20, 25, 5, 255, 255, 125, 20, 255, 1);
    starHeight = (sleepDataProcessed[i][1] - startHour + 24) % 24;
    starHeight = height - (starHeight*yScaleWidth);
    dataStars[(i*2)+1] = new dataStar(day, starHeight, 20, 25, 5, 255, 255, 0, 20, 255, 1);
  }
}


void draw() {
  //println(int(frameRate));
  refresh();
  smallStars();
  bigStars();
  brightStars();

  fill( 82, 85, 144, 7);
  rect(0, 0, width, height);

  helpButton();

  line1.display();
  line2.display();
  for (int i=0; i<dataStars.length; i++) {
    dataStars[i].display();
  }
}

void refresh() {


  timePassed = millis();
  if (timePassed - startTime >= timeToReset) {
    lineSeed = (int)random(0, 100000);
    startTime = millis();
    line1 = new stellarLine(50, 30, 100);
    line2 = new stellarLine(50, 30, 100);
  }
}

void helpButton() {
  int posX = 20;
  int posY = 20;
  int size = 25;
  noStroke();
  fill(255);
  circle(posX, posY, size);
  fill(0);
  textSize(size);

  text("?", posX, posY);
  buttonCheck(posX, posY, size);
  if (showScale == true) {
    scales();
    scalesUsed = true;
  } else if (scalesUsed == true) {
    scalesHide();
    scalesUsed= false;
  }
}

void scales() {
  noStroke();

  for (int i = 1; i <= scaleNumbers.length; i ++) {
    if (i <  scaleNumbers.length) {
      fill( 110, 85, 170, 150);
      rect(0, i*yScaleWidth, width, scaleLineWidth);
    }
  }
  for (int i = 1; i <= scaleNumbers.length; i ++) {
    textSize(17);
    fill(255, 80);
    text(String.format("%05.2f", scaleNumbers[scaleNumbers.length-(i)]), 30, (i*yScaleWidth)-10);
  }
  for (int i = 1; i <= 7; i ++) {
    if (i < 7) {
      fill( 130, 85, 170, 140);
      rect(i*xScaleWidth, 0, scaleLineWidth, height);
    }
    textSize(30);
    fill(255, 80);
    text(days[i-1], (i*xScaleWidth)-30, 30);
  }
}


void scalesHide() {
  noStroke();
  for (int i = 1; i <= 7; i ++) {
    if (i < 7) {
      fill(  82, 85, 144);
      rect(i*xScaleWidth, 0, scaleLineWidth, height);
    }
    fill( 82, 85, 144);
    rectMode(CENTER);
    rect((i*xScaleWidth)-30, 30, 50, 25);
    rectMode(CORNER);
  }
  for (int i = 1; i <= scaleNumbers.length; i ++) {
    if (i < scaleNumbers.length) {
      fill(  82, 85, 144);
      rect(0, i*yScaleWidth, width, scaleLineWidth);
    }

    fill( 82, 85, 144);
    rectMode(CENTER);
    rect( 30, (i*yScaleWidth)-10, 50, 20);
    rectMode(CORNER);
  }
}


void buttonCheck(int xCoord, int yCoord, int maxDist) {
  if (mousePressed && mouseReady == true) {
    mouseReady = false;

    if (dist(mouseX, mouseY, xCoord, yCoord) <= maxDist) {
      showScale = !showScale;
    }
  }
}


void mouseReleased() {
  mouseReady = true;
}

void smallStars() {
  randomSeed(lineSeed);
  int amount = 9000;
  noStroke();

  for (int i = 1; i <= amount; i++) {
    fill( 255, 255, 255, (int)random(10, 20));
    rect((int)random(0, width), (int)random(0, height), 1, 1);
  }
}


void bigStars() {

  randomSeed(lineSeed);
  int amount = 3000;
  noStroke();

  for (int i = 1; i <= amount; i++) {
    fill( 255, 255, 255, (int)random(10, 20));
    rect((int)random(0, width), (int)random(0, height), (int)random(2, 4), (int)random(2, 4));
  }
}


void brightStars() {
  int amount = 500;
  fill(255, 240, 75, 10);
  randomSeed(lineSeed);
  noStroke();

  for (int i = 1; i <= amount; i++) {
    rect((int)random(0, width), (int)random(0, height), (int)random(4, 5), (int)random(4, 5));
  }
}
