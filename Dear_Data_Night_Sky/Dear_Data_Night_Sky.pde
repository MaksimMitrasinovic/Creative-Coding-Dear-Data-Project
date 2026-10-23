int lineSeed = 9909;

int startTime = millis();
int timeToReset = 5000;
int timePassed = millis();

boolean mouseReady = true;
boolean showScale = false;
boolean scalesUsed = false;

int scaleLineWidth = 5;
int xScaleWidth;
int yScaleWidth;

String[] days = {"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"};
String[] scaleNumbers= { "01.00", "24.30", "24.00", "23.30", "23.00", };//Will be using processed values when enough data collected

dataStar testStar;


void setup() {
  size(1491, 700);
  background( 82, 85, 144);
  frameRate(30);
  textAlign(CENTER, CENTER);
  xScaleWidth = width/7;
  yScaleWidth = height/5;
  testStar = new dataStar(150, 200, 80, 100, 10, 255, 255, 0, 30, 255, 2);
}


void draw() {

  refresh();
  fill( 82, 85, 144, 7);
  rect(0, 0, width, height);
  helpButton();
  println(int(frameRate));
  testStar.display();
}

void refresh() {
  timePassed = millis();
  if (timePassed - startTime >= timeToReset) {
    lineSeed = (int)random(0, 100000);
    startTime = millis();
  }
  smallStars();
  bigStars();
  brightStars();
}

void helpButton() {
  int posX = 20;
  int posY = 20;
  int size = 25;
  stroke(2);
  fill(255);
  circle(posX, posY, size);
  fill(0);
  textSize(size);
  text("?", posX, posY);
  buttonCheck(posX, posY, size);
  if (showScale == true) {
    scales();
    scalesUsed = true;
  } else if (scalesUsed == true) {//showScale == false
    scalesHide();
    scalesUsed= false;
  }
}

void scales() {
  noStroke();
  for (int i = 1; i <= 7; i ++) {
    if (i < 7) {
      fill( 110, 85, 170, 80);
      rect(i*xScaleWidth, 0, scaleLineWidth, height);
    }
    textSize(30);
    fill(255, 80);
    text(days[i-1], (i*xScaleWidth)-30, 30);
  }
  for (int i = 1; i <= 5; i ++) {
    if (i < 5) {
      fill( 95, 85, 170, 90);
      rect(0, i*yScaleWidth, width, scaleLineWidth);
    }
    textSize(17);
    fill(255, 80);
    text(scaleNumbers[i-1], 30, (i*yScaleWidth)-10);
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
  for (int i = 1; i <= 5; i ++) {
    if (i < 5) {
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
