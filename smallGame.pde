class Move{
  int moveX;
  int moveY;
  Move(){
  }
  Move(int _X , int _Y){
    moveX = _X;
    moveY = _Y;
  }
  void setMove(int _X , int _Y){
     moveX = _X;
    moveY = _Y;
  }
    void setMove(Move x){
     moveX = x.moveX;
    moveY = x.moveY;
  }
}

class SmallGame{
//1 == x , -1 == 0
  int board[][];
  boolean continueGame;
  int diag1, diag2;
  int row[], col[];
  ArrayList<Move> moves; 
//  int moveX, moveY;
  Move thisMove;
  boolean turnOfPlayer;
  int human, computer;
  int evaluation;
  Move bestMove;
  int depth;
  SmallGame(){
  }
  
    SmallGame(SmallGame father, 
  //int x, 
  //int y,
    boolean turn){
    board = copy2D(father.board);
    row = Arrays.copyOf(father.row, father.row.length);
    col = Arrays.copyOf(father.col, father.col.length);
    diag1 = father.diag1;
    diag2 = father.diag2;
    //moveX = x;
    turnOfPlayer = turn;
    //moveY = y;
    //board[y][x] = -1;
    human = 1;
    computer = -1; 
    moves  = new ArrayList<Move>();
    bestMove = new Move();
    continueGame = true;
    //printArray();
    //println(turn);
    //println();
  }
  void printArr(int arr[]){

        for (int x = 0; x<3; x++){
          print(" | ",arr[x]);
          output.print(" | ");
          output.print(arr[x]);
        }
        println();
        output.println();
  }
  SmallGame(SmallGame father, 
  //int x, 
  //int y,
    Move _thisMove, boolean turn){
    board = copy2D(father.board);
    row = Arrays.copyOf(father.row, father.row.length);
    col = Arrays.copyOf(father.col, father.col.length);
    diag1 = father.diag1;
    diag2 = father.diag2;
    //moveX = x;
    turnOfPlayer = turn;
    //moveY = y;
    //board[y][x] = -1;
    human = 1;
    computer = -1; 
    thisMove = new Move(_thisMove.moveX, _thisMove.moveY);
    moves  = new ArrayList<Move>();
    makeMove();
    bestMove = new Move();
    //evaluation = evaluate(thisMove.moveX, thisMove.moveY);
    output.println("test");
    evaluation = evaluate();
    printArray();
     printEval();
        output.println("testend");
    continueGame = true; 
    //println();
  }
  
  int[][] copy2D(int arr[][]){
    int newArr[][] = new int[3][3];
    for (int y = 0; y<3; y++){
    for (int x = 0; x<3; x++){
      newArr[y][x] = arr[y][x];
    }
    }
    return newArr;
  }
  void makeMove(){
    //println(turnOfPlayer);
    if (turnOfPlayer) board[thisMove.moveY][thisMove.moveX] = -1;
    else board[thisMove.moveY][thisMove.moveX] = 1;
  }
    void makeMove(Move M, boolean reset){
    //println(turnOfPlayer);
    if (!reset){
    if (turnOfPlayer) board[M.moveY][M.moveX] = -1;
    else board[M.moveY][M.moveX] = 1;
    }
    else board[M.moveY][M.moveX] = 0;
  }

    void printArray(){
    for (int y = 0; y<3;y++){
        for (int x = 0; x<3; x++){
      print(" | ", board[y][x]);
      output.print(" | ");
      output.print(board[y][x]);
    }
    println();
    output.println();
    }
  }
       void printMove(Move move){
     print("The move is ", "( ", move.moveX, ", ",move.moveY, " )");
     output.print( "( ");
     output.print(move.moveX);
     output.print(", ");
     output.print(move.moveY);
     output.print( " )");
     output.println();
 }
  
  //Score = 0;
  //x = 1;
  //y = 0;
  SmallGame miniMax(SmallGame aGame, int depth){//returns array with best moves
    aGame.getMoves();
    if (!aGame.continueGame || aGame.moves.isEmpty()){
      //aGame.printArray();
      //println("Finito", depth);
      //printArray();
      output.println(aGame.evaluation+"\n");
      if(aGame.moves.isEmpty() && aGame.evaluation == 0)output.println("GoodZero");
            if(aGame.moves.isEmpty() && aGame.evaluation > 0)output.println("GoodWin");
                  if(aGame.moves.isEmpty() && aGame.evaluation < 0)output.println("GoodLose");
                              if(!aGame.moves.isEmpty() && aGame.evaluation > 0)output.println("BetterWin");
                  if(!aGame.moves.isEmpty() && aGame.evaluation < 0)output.println("BetterLose");
      return aGame;
    }
    if (aGame.turnOfPlayer){ //MIN's turn
      int bestmove = 9999;
      for(Move x : aGame.moves){
      SmallGame possible_game = new SmallGame(aGame, x, !aGame.turnOfPlayer); //Makes move
      println("Simulating min turn with depth:" ,depth);
      output.print("\nSimulating min turn with depth:");
      output.print(depth);
      output.println();
      printMove(x);
      //possible_game.printArray();
      //possible_game.printEval();
      println(possible_game.turnOfPlayer);
      println();
      int tmp = miniMax(possible_game, depth+1).evaluation;
      if (tmp<bestmove){
        bestmove = tmp;
        println("MIN ",tmp);
        aGame.bestMove.setMove(x.moveX, x.moveY);
      }
          //return possible_game; 
    }
    }
    else{//Max's turn
       int bestmove = -9999;
      for(Move x : aGame.moves){
      SmallGame possible_game = new SmallGame(aGame, x, !aGame.turnOfPlayer); //Makes move
      println("Simulated max turn with depth:" ,depth);
            output.print("\nSimulating max turn with depth:");
      output.print(depth);
      output.println();
      printMove(x);
//      possible_game.printArray();
      //possible_game.printEval();
      println(possible_game.turnOfPlayer);
      int tmp = miniMax(possible_game, depth+1).evaluation; 
      println();
      if (tmp>bestmove ){
        println("MAX ",tmp);
        bestmove = tmp;
        //aGame.bestMove.setMove(x.moveX, x.moveY);
        //return possible_game;
      }
    }
    }
        return aGame;
  }
  
  int  getMoves(){
  if(!moves.isEmpty()) moves.clear();
  for (int y = 0; y<3 ; y++){
    for (int x = 0; x<3;x++){
      if (board[y][x] ==0) moves.add(new Move(x,y));
    }
  }
  if (moves.isEmpty()){ continueGame = false; return 1;} 
  return 0;
  }
  
  void printEval(){
    println("Rows");
    output.print("Rows:\n");
    printArr(row);
        println("Cols");
         output.print("Cols:\n");
    printArr(col);
    print("Diag1: ", diag1, " Diag2: ", diag2); 
    output.println("Diag1: "+ diag1+ " Diag2: "+ diag2);
    println();
    output.println("Continue? "+continueGame);
  }
  Integer evaluate(int locX, int locY,int point){
        row[locY]+=point;
        col[locX]+=point;
        if(locX ==locY) diag1+=point;
        if(abs(locX-locY)==2 || (locX==1 && locY ==1)) diag2+=point;
 //       println("Row: ",row[locY], "Col: ", col[locX], "Diag: ", diag1, "Diag: ", diag2, "Delta", point, " X: ", locX, " Y:", locY);
        if (row[locY] == 3 || col[locX] == 3 || diag1 ==3 || diag2 == 3 ||
        row[locY] == -3 || col[locX] == -3 || diag1 ==-3 || diag2 ==-3){
          continueGame = false;
                    if (point <0) return 10;
          return -10;
        }
   return 0; 
      }
      
        Integer evaluate(int locX, int locY){
        int point = turnOfPlayer ? 1:-1;
        row[locY]+=point;
        col[locX]+=point;
        if(locX ==locY) diag1+=point;
        if(abs(locX-locY)==2 || (locX==1 && locY ==1)) diag2+=point;
//        println("Row: ",row[locY], "Col: ", col[locX], "Diag: ", diag1, "Diag: ", diag2, "Delta", point);
        //printEval();
        if (row[locY] == 3 || col[locX] == 3 || diag1 ==3 || diag2 == 3 ||
        row[locY] == -3 || col[locX] == -3 || diag1 ==-3 || diag2 ==-3){
          continueGame = false;
          //println("Finished");
          //printArray();
                    if (point <0) return 100;
          return -100;
        }
   return 0; 
      }
      
           Integer evaluate(Move m){
        int point = turnOfPlayer ? 1:-1;
            int locY = m.moveY;
    int locX = m.moveX;
        row[locY]+=point;
        col[locX]+=point;
        if(locX ==locY) diag1+=point;
        if(abs(locX-locY)==2 || (locX==1 && locY ==1)) diag2+=point;
//        println("Row: ",row[locY], "Col: ", col[locX], "Diag: ", diag1, "Diag: ", diag2, "Delta", point);
        if (row[locY] == 3 || col[locX] == 3 || diag1 ==3 || diag2 == 3 ||
        row[locY] == -3 || col[locX] == -3 || diag1 ==-3 || diag2 ==-3){
          continueGame = false;
          //println("Finished");
          //printArray();
                    if (point <0) return 100;
          return -100;
        }
   return 0; 
      }
      Integer evaluate(){
    for (int y = 0; y<3;y++){
    for (int x = 0; x<3;x++){
            row[y]=0;
        col[x]=0;
    }
}
diag1= 0;
diag2 = 0;
  
  for (int y = 0; y<3;y++){
    for (int x = 0; x<3;x++){
        col[x]+=board[y][x];
        row[y]+=board[y][x];
         if(x==y) diag1+=board[y][x];
        if(abs(x-y)==2 || (x==1 && y ==1)) diag2+=board[y][x];
         if (row[y] == 3 || col[x] == 3 || diag1 ==3 || diag2 == 3 ||
        row[y] == -3 || col[y] == -3 || diag1 ==-3 || diag2 ==-3){
          continueGame = false;
          output.println("Game Finished "+continueGame);
          //printArray();
                    if (row[y] <0 || col[x] < 0) return 100;
          return -100;
    }

}
}
return 0;
}
}