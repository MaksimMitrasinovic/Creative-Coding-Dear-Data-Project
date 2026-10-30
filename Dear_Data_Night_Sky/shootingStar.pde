class shootingStar {
  int size;
  int opacity;
  int posX = 0;
  int posY;
  float accelerationX;
  float accelerationY;
  float velocityX;
  float velocityY;
  float oldX;
  float oldY;
  int startTime = millis();

  shootingStar() {
    size = (int)random(3, 6);
    opacity = (int)random(200, 250);
    posY = (int)random(0, height);
    accelerationX = (float)random(0, 1);
    accelerationY = (float)random(0, 1);
    velocityX = (float)random(10, 20);
    velocityY = (float)random(-20, -10);
    oldX = posX;
    oldY = posY;
  }
  void display() {
    noStroke();
    strokeWeight(5);
    stroke(255,opacity);
    line(oldX,oldY,posX,posY);
    oldX = posX;
    oldY = posY;
    velocityX += accelerationX;
    posX += velocityX;
    velocityY += accelerationY;
    posY += velocityY;
    if (millis() - startTime > 10000){
      posY = width + 100;
      //print("manual reset");
    }
  }
}
