class Gui{
  Game test;
  int dist1, dist2;
  boolean waitInput; 
  int tmpX, tmpY;
  Gui(){
    test = new Game(true); 
    waitInput = true; 
    dist1 = 500/3;
    dist2 = 5; 
  }
  
  void drawGrid(){
    background(255);
    strokeWeight(4);
    line(dist1,dist2, dist1, height-dist2);
    line(2*dist1,dist2, 2*dist1, height-dist2);
    line(dist2,dist1, width-dist2, dist1);
    line(dist2,dist1*2, width-dist2, 2*dist1);
    strokeWeight(1);
  }
  
  int turn(){
    if(test.continueGame){
      //println("Enter turn", waitInput, test.turnOfPlayer);
    if (test.turnOfPlayer){  
      if(waitInput){ waitInput = true; return 1;}
      //println("Finish loop2", tmpX, tmpY, waitInput);
      if (test.userTurn(tmpX,tmpY) != 0) return 1;
      test.evaluate(tmpX,tmpY, test.human);
      //test.printEval();
      test.turnOfPlayer = false;
      waitInput = true; 
    }else{
      //if(waitInput){ waitInput = true; return 1;}
      ////println("Finish loop2", tmpX, tmpY, waitInput);
      ////test.userTurn2(tmpX,tmpY);
      //if (test.userTurn2(tmpX,tmpY) != 0) return 1;
      test.computerTurn();
      println("Finish computer turn");
      tmpX = test.lastMove.moveX;
      tmpY = test.lastMove.moveY;
      test.evaluate(tmpX,tmpY, test.computer);
      test.turnOfPlayer = true;
      waitInput = true; 
    }
    
    if (!test.continueGame){
      textSize(100);
      fill(255,0,0);
      text("Game Over",30,100,400,400);
    }
  }
  return 0;
  }

  
  void handleInput(int x, int y){
    if (x<dist1){
      x = 0;
    } else if (x<dist1*2){
      x = 1;
    }else {
      x = 2; 
    }
    
    if (y<dist1){
      y = 0;
    } else if (y<dist1*2){
      y = 1;
    }else {
      y = 2; 
    }
    tmpX = x;
    tmpY = y;
    //test.board[y][x] = test.player; 
  }
  
  
  void drawMoves(){
    fill(0);
    for (int y = 0; y<3;y++){
      for (int x = 0; x<3; x++){
    pushMatrix();
    translate(x*(dist1), y*(dist1));
    textSize(170);
    switch(test.board[y][x]){
      case 1:
      text("X",30 ,dist1-20);
      break;
      case -1:
      text("O",30 ,dist1-20);
      break;
      default:
      break;
    }
    popMatrix();
    }
    }
  }
  
  void test(){
  int array[][]= new int[][] {
      {1,-1,0},
      {0,1,0},
      {0,0,0}
    };
  SmallGame tmp = new SmallGame(false, array);
  tmp.evaluate();
  tmp.whoWon();
  output.println(tmp.computerWon+", "+tmp.humanWon+", "+tmp.tieWon);
  tmp.printEval();
  //output.print(tmp.miniMax3());
  //tmp.printMove(tmp.chooseBest3());
  tmp.miniMax2(0,true);
}
  
}