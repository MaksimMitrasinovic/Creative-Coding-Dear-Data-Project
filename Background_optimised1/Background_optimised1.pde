int lineSeed = 9909;

int screenX = 1491;
int screenY = 700;
int startTime = millis();
int timeToReset = 5000;
int timePassed = millis();

int starX = 0;
int starY = 400;
int speedX = 20;
int speedY = -10;
int accelX = 0;
int accelY = 1;

boolean mouseReady = true;
boolean showScale = false;
boolean scalesUsed = false;

  int scaleLineWidth = 5;
int xScaleWidth = screenX/7;

String[] days = {"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"};


void settings() {
  size(screenX, screenY);
}

void setup() {
  background( 82, 85, 144);
  frameRate(30);
  textAlign(CENTER, CENTER);
}

void refresh() {
  timePassed = millis();

  if (timePassed - startTime >= timeToReset) {
    lineSeed = (int)random(0, 100000);


    startTime = millis();
  }
  line1();
  line2();
  smallStars();
  bigStars();
  brightStars();
}



void draw() {

  refresh();
  fill( 82, 85, 144, 7);
  rect(0, 0, screenX, screenY);
  //shootingStar();
  helpButton();
  println(int(frameRate));
}


void helpButton() {
  int posX = screenX-20;
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
  }
  else if (scalesUsed == true){//showScale == false
  scalesHide();
  scalesUsed= false;
  }



}

void scales() {
  noStroke();
  for (int i = 1; i <= 7; i ++) {
    if (i < 7) {
      fill( 110, 85, 170, 80);
      rect(i*xScaleWidth, 0, scaleLineWidth, screenY);
    }
    fill(255, 80);
    text(days[i-1], (i*xScaleWidth)-60, 30);
  }
}
void scalesHide(){
  noStroke();
  for (int i = 1; i <= 7; i ++) {
    if (i < 7) {
      fill(  82, 85, 144);
      rect(i*xScaleWidth, 0, scaleLineWidth, screenY);
    }
    fill( 82, 85, 144);
    textSize(30);
    rectMode(CENTER);
    rect((i*xScaleWidth)-60, 30,50,25);
    rectMode(CORNER);
  }
}



void buttonCheck(int xCoord, int yCoord, int maxDist) {  //Need to alter if I decide to use multiple buttons
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
  int amount = 7000;//needs rework
  noStroke();

  for (int i = 1; i <= amount; i++) {
    fill( 255, 255, 255, (int)random(10, 20));
    rect((int)random(0, screenX), (int)random(0, screenY), 1, 1);
  }
}


void bigStars() {

  randomSeed(lineSeed);
  int amount = 3000;
  noStroke();

  for (int i = 1; i <= amount; i++) {
    fill( 255, 255, 255, (int)random(10, 20));
    rect((int)random(0, screenX), (int)random(0, screenY), (int)random(2, 4), (int)random(2, 4));
  }
}

void line1() {
  randomSeed(lineSeed);
  int lineWidth = 50;
  int LineRegidity = 2;
  int lineXDist = 20;
  int previousYPos = screenY/2 + (int)random(-(screenY/2), (screenY/2));
  noStroke();
  for (int i = 1; i <= screenX; i = i + lineXDist) {
    for (int j = -lineWidth; j <= lineWidth; j++) {
      fill( 82, 85, 144, (255-(abs(j*(255/lineWidth))))/30);
      rect(i, previousYPos+j, lineXDist, 1);
    }
    previousYPos = previousYPos + (int)random(-(lineWidth/LineRegidity), (lineWidth/LineRegidity) );
  }
}
void line2() {
  randomSeed(lineSeed);
  int lineWidth = 50;
  int LineRegidity = 2;
  int lineXDist = 20;
  int previousYPos = screenY/2 + (int)random(-(screenY/2), (screenY/2));
  noStroke();
  for (int i = 1; i <= screenX; i = i + lineXDist) {
    for (int j = -lineWidth; j <= lineWidth; j++) {
      fill( 82, 85, 144, (255-(abs(j*(255/lineWidth))))/30);
      rect(i, previousYPos+j, lineXDist, 1);
    }
    previousYPos = previousYPos + (int)random(-(lineWidth/LineRegidity), (lineWidth/LineRegidity) );
  }
}

void brightStars() {
  int amount = 500; //Smaller num means less stars
  fill(255, 240, 75, 10);
  randomSeed(lineSeed);
  noStroke();

  for (int i = 1; i <= amount; i++) {
    rect((int)random(0, screenX), (int)random(0, screenY), (int)random(4, 5), (int)random(4, 5));
  }
}


void shootingStar() {
  println(starX);
  if (starX < screenX) {
    fill(255, 255, 255);
    rect(starX, starY, speedX, 4);
    speedX += accelX;
    starX += speedX;
    speedY += accelY;
    starY += speedY;
  } else {
    starX=0;
    speedY = -10;
  }
}
