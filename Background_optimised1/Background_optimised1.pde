int lineSeed = 9909;

int screenX = 1491;
int screenY = 700;
int startTime = millis();
int timeToReset = 5000;
int timePassed = millis();

int starX = 0;
int starY = 400;
int speedX = 60;
int speedY = -10;
int accelX = 0;
int accelY = 1;




void settings() {
  size(screenX, screenY);
}

void setup() {
  background( 82, 85, 144);
}

void refresh() {
  timePassed = millis();

  if (timePassed - startTime >= timeToReset) {
    lineSeed = (int)random(0, 100000);


    startTime = millis();
  }
  //line1();
  //line2();
  smallStars();
  bigStars();
  brightStars();
}



void draw() {

  refresh();
  fill( 82, 85, 144, 3);
  rect(0, 0, screenX, screenY);
  //shootingStar();
  println(int(frameRate));
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
  int amount = 3000;//needs rework
  noStroke();

  for (int i = 1; i <= amount; i++) {
    fill( 255, 255, 255, (int)random(10, 20));
    rect((int)random(0, screenX), (int)random(0, screenY), (int)random(2, 4), (int)random(2, 4));
  }
}

void line1() {
  randomSeed(lineSeed);
  int lineWidth = 50;
  int LineRegidity = 5;
  int previousYPos = screenY/2 + (int)random(-(screenY/2), (screenY/2));
  noStroke();
  for (int i = 1; i <= screenX; i++) {
    for (int j = -lineWidth; j <= lineWidth; j++) {
      fill( 82, 85, 144, (255-(abs(j*(255/lineWidth))))/30);
      rect(i, previousYPos+j, 1, 1);
    }
    previousYPos = previousYPos + (int)random(-(lineWidth/LineRegidity), (lineWidth/LineRegidity) );
  }
}
void line2() {
  randomSeed(lineSeed);
  int lineWidth = 100;
  int LineRegidity =15;
  int previousYPos = screenY/2 + (int)random(-(screenY/2), (screenY/2));
  noStroke();
  for (int i = 1; i <= screenX; i++) {
    for (int j = -lineWidth; j <= lineWidth; j++) {
      fill( 82, 85, 144, (255-(abs(j*(255/lineWidth))))/30);
      rect(i, previousYPos+j, 1, 1);
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

  if (starX < screenX) {
    fill(255, 255, 255);
    rect(starX, starY, speedX, 4);
    speedX += accelX;
    starX += speedX;
    speedY += accelY;
    starY += speedY;
  }
}
