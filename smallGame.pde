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
        }
        println();
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
    evaluation = evaluate(thisMove.moveX, thisMove.moveY);
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
    }
    println();
    }
  }
  
  //Score = 0;
  //x = 1;
  //y = 0;
  SmallGame miniMax(SmallGame aGame, int depth){//returns array with best moves
    aGame.getMoves();
    if (!aGame.continueGame){
      aGame.printArray();
      println("Finito", depth);
      //printArray();
      return aGame;
    }
    if (aGame.turnOfPlayer){ //MIN's turn
    println("Simulating min turn");
      int bestmove = 9999;
      for(Move x : aGame.moves){
      SmallGame possible_game = new SmallGame(aGame, x, !aGame.turnOfPlayer); //Makes move
      int tmp = miniMax(possible_game, depth++).evaluation; 
      if (tmp<bestmove){
        bestmove = tmp;
        println("MIN ",tmp);
        aGame.bestMove.setMove(x.moveX, x.moveY);
        return possible_game;
        //aGame.bestMove.setMove(x.moveX, x.moveY);
      }
          return possible_game; 
    }
    }
    else{//Max's turn
       int bestmove = -9999;
           println("Simulating max turn");
      for(Move x : aGame.moves){
      SmallGame possible_game = new SmallGame(aGame, x, !aGame.turnOfPlayer); //Makes move
      int tmp = miniMax(possible_game, depth++).evaluation; 
      if (tmp>bestmove){
        println("MAX ",tmp);
        bestmove = tmp;
        aGame.bestMove.setMove(x.moveX, x.moveY);
        return possible_game;
        //aGame.bestMove.setMove(x.moveX, x.moveY);
      }
      return possible_game;
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
    printArr(row);
        println("Cols");
    printArr(col);
    print("Diag1: ", diag1, " Diag2: ", diag2); 
    println();
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
        int point = !turnOfPlayer ? 1:-1;
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
      
           Integer evaluate(Move m){
        int point = !turnOfPlayer ? 1:-1;
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

}