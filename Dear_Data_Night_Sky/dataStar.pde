class dataStar {
  int column;
  int middleX;
  float middleY;
  int sizeX;
  int sizeY;
  int depth;
  int r;
  int g;
  int b;
  int opacity;
  int stroCol;
  int stroWei;

  dataStar(int newColumn, float newMiddleY, int newSizeX, int newSizeY, int newDepth, int newR, int newG, int newB, int newOpacity, int newStroCol, int newStroWei) {
    middleY = newMiddleY;
    sizeX = newSizeX;
    sizeY = newSizeY;
    column = newColumn;
    middleX = (int)random(xScaleWidth*column+sizeX,xScaleWidth*(column+1)-sizeX);
    depth = newDepth;
    r = newR;
    g = newG;
    b = newB;
    opacity = newOpacity;
    stroCol = newStroCol;
    stroWei = newStroWei;
  }

  void display() {
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
}
