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
  fill(0,0,125);
  rect(xPos,yPos,xWidth,yWidth);
  fill(0);
  ellipse(xPos,yPos,xWidth,yWidth);
  ellipse(xPos+xWidth,yPos,xWidth,yWidth);
  ellipse(xPos,yPos+yWidth,xWidth,yWidth);
  ellipse(xPos+xWidth,yPos+yWidth,xWidth,yWidth);
}
