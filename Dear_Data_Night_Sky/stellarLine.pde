class stellarLine {
  int lineWidth;
  int lineRigidity;
  int bendAmount;
  int newY;

  int[] yPositions;

  int firstX =  -200;
  int lastX = width + 200;
  int newX = firstX;
  int[] xPositions;

  stellarLine(int newWidth, int newRigid, int newBend) {
    bendAmount = newBend;
    yPositions = new int[bendAmount+1];
    xPositions = new int[bendAmount+1];
    newY = (int)random(0, height);
    lineWidth = newWidth;
    lineRigidity =  newRigid;

    yPositions[0] = newY;
    for (int i = 1; i <= bendAmount; i++) {
      newY += (int)random(-lineRigidity, lineRigidity);
      yPositions[i] = newY;
    }
    xPositions[0] = firstX;

    for (int i = 1; i <= bendAmount; i++) {
      newX += (lastX-firstX)/bendAmount;
      xPositions[i] = newX;
    }
  }
  void display() {
    fill(200, 85, 144,10);
    stroke(82, 85, 144,10);
    strokeWeight(lineWidth/4);
    beginShape();

    for (int i = 0; i <= bendAmount; i++) {
      vertex(xPositions[i], yPositions[i]);
    }

    for (int i = bendAmount; i >= 0; i--) {
      vertex(xPositions[i], yPositions[i]+lineWidth);
    }
    endShape(CLOSE);
  }
}
