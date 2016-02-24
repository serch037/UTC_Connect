Gui test; 
void setup(){
  size(500,500);
  test = new Gui();
  test.drawGrid();
}
void draw(){
  test.turn();
  test.drawMoves();
}

void mouseClicked(){
  test.waitInput = false;
  test.handleInput(mouseX, mouseY);
  println("Recieved Input", test.tmpX, test.tmpY);
}