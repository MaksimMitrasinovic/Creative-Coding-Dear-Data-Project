int xPos = 100;
int yPos = 100;
int xWidth = 50;
int yWidth = 60;

void setup() {
  noStroke();
  size(500, 500);
  background(0);
}

void draw() {
  starShape(10, 150, 200, 80, 100, 255, 255, 0, 30, 255, 2);
}

void starShape(int depth, int middleX, int middleY, int sizeX, int sizeY, int r, int g, int b, int opacity, int stroCol, int stroWei) {
  fill(r, g, b, opacity);
  stroke(stroCol);
  strokeWeight(stroWei);

  beginShape();
  vertex(middleX, middleY-sizeY);
  quadraticVertex(middleX-depth, middleY-depth, middleX-sizeX, middleY);
  quadraticVertex(middleX-depth, middleY+depth, middleX, middleY+sizeY);
  quadraticVertex(middleX+depth, middleY+depth, middleX+sizeX, middleY);
  quadraticVertex(middleX+depth, middleY-depth, middleX, middleY-sizeY);

  endShape(CLOSE);
}
