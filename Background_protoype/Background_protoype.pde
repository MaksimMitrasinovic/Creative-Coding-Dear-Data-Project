

int screenX = 1491;
int screenY = 700;

void settings() {
  size(screenX, screenY);
}

void setup() {
  background( 82, 85, 144);
  line1();
  smallStars();
}

void draw() {
   
}

void smallStars() {
  int lineWidth = 10;
  noStroke();

  for (int i = 1; i <= screenX; i++) {
    for (int j = -lineWidth; j <= lineWidth; j++) {
      fill( 255, 255, 255, 255-(abs(j*25)));
      rect(i, (int)random(1, screenY+1), 1, 1);
    
    }
  }
}

void line1() {
  int lineWidth = 50;
  int LineRegidity = 5;
  int previousYPos = screenY/2 + (int)random(-(screenY/2), (screenY/2));
  noStroke();
  println("run");
  for (int i = 1; i <= screenX; i++) {
    for (int j = -lineWidth; j <= lineWidth; j++) {
      fill( 119, 82, 144, 255-(abs(j*(255/lineWidth))));

      rect(i, previousYPos+j, 1, 1);
    }
    previousYPos = previousYPos + (int)random(-(lineWidth/LineRegidity), (lineWidth/LineRegidity) );
  }
}
