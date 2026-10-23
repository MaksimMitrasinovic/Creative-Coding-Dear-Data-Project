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
  //fill(0,0,125);
  //rect(xPos,yPos,xWidth,yWidth);
  //fill(0);
  //ellipse(xPos,yPos,xWidth,yWidth);
  //ellipse(xPos+xWidth,yPos,xWidth,yWidth);
 // ellipse(xPos,yPos+yWidth,xWidth,yWidth);
  //ellipse(xPos+xWidth,yPos+yWidth,xWidth,yWidth);
  starShape();
}

void starShape(){
  fill(255,255,0);
  stroke(255);
  strokeWeight(2);
  int depth = 10;
  int middleX = 150;
  int middleY = 200;
  int sizeX = 80;
  int sizeY = 100;
  beginShape();
   vertex(middleX,middleY-sizeY);
   quadraticVertex(middleX-depth,middleY-depth,middleX-sizeX,middleY);
   quadraticVertex(middleX-depth,middleY+depth,middleX,middleY+sizeY);
   quadraticVertex(middleX+depth,middleY+depth,middleX+sizeX,middleY);
   quadraticVertex(middleX+depth,middleY-depth,middleX,middleY-sizeY);
   
  endShape(CLOSE);
}
