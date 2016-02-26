  PrintWriter output;
  import java.util.*; 
Gui test; 
void setup(){
  size(500,500);
  test = new Gui();
  test.drawGrid();
  output = createWriter("positions.txt");
}
void draw(){
  test.turn();
  test.drawMoves();
}

void mouseClicked(){
  test.waitInput = false;
  test.handleInput(mouseX, mouseY);
  //println("Recieved Input", test.tmpX, test.tmpY, test.test.turnOfPlayer);
  //test.test.printArray();
}
void keyPressed(){
  output.flush();
  output.close();
  exit();
}