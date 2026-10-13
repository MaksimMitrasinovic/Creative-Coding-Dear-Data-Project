int lineSeed = 0;

int smallStarsPos = 0;


int screenX = 1491;
int screenY = 700;


boolean flash = true;
boolean fadeIn = true;


float backgroundFade = 0;


void settings() {
  size(screenX, screenY);
}

void setup() {
  background( 82, 85, 144);
  line1();
  smallStars();
}

void refresh() {
  line1();
  smallStars();
}




void fadeBg() {
  println(backgroundFade);
  if (backgroundFade < 30 && fadeIn == true) {

    backgroundFade = lerp(backgroundFade, 255, 0.0005);
    fill( 82, 85, 144, backgroundFade);
    rect(0, 0, screenX, screenY);
  } else {
    fadeIn = false;
    if (backgroundFade > 0.5 && fadeIn == false) {
      backgroundFade = lerp(backgroundFade, 0, 0.05);

      refresh();


      fill( 82, 85, 144, backgroundFade);
      rect(0, 0, screenX, screenY);
    } else {
      fadeIn = true;
           lineSeed = (int)random(0, 10000);
    }
  }
}

void draw() {

  fadeBg();
}

void smallStars() {
  randomSeed(lineSeed);
  int lineWidth = 10;
  noStroke();

  for (int i = 1; i <= screenX; i++) {
    for (int j = -lineWidth; j <= lineWidth; j++) {
      fill( 255, 255, 255, 255-(abs(j*25)));
      rect(i, (int)random(1, screenY+1), 2, 2);
    }
  }
}

void line1() {
  int lineWidth = 50;
  int LineRegidity = 5;
  int previousYPos = screenY/2 + (int)random(-(screenY/2), (screenY/2));
  noStroke();
  for (int i = 1; i <= screenX; i++) {
    for (int j = -lineWidth; j <= lineWidth; j++) {
      fill( 119, 82, 144, 255-(abs(j*(255/lineWidth))));

      rect(i, previousYPos+j, 1, 1);
    }
    previousYPos = previousYPos + (int)random(-(lineWidth/LineRegidity), (lineWidth/LineRegidity) );
  }
}
