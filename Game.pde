//1 == x , -1 == 0
class Game extends SmallGame{
  boolean playerBegins;
  Move lastMove;
  Game(boolean turn){
    board = new int[3][3];
    /*
    board = new int[][] {
      {1,-1,0},
      {1,-1,0},
      {0,0,-1}
    };
    */
    playerBegins = turn;
    turnOfPlayer = turn;
    continueGame = true; 
    row = new int[3]; 
    col = new int[3];
    bestMove = new Move();
    lastMove = new Move();
    human = 1;
    computer = -1;
    moves  = new ArrayList<Move>();
    //moves  = new ArrayList<Integer[]>();
  }
  
  void printArray(){
    for (int y = 0; y<3;y++){
        for (int x = 0; x<3; x++){
      print(" | ", board[y][x]);
    }
    println();
    }
  }
  
 void printMoves(ArrayList<Move> moves){
   for (Move x : moves){
     println("( ", x.moveX, ", ",x.moveY, " )");
   }
 }
     void printMove(Move move){
     println("The move is ", "( ", move.moveX, ", ",move.moveY, " )");
 }
 
  int userTurn(int x, int y){
    if (board[y][x] != 0){
//      println("ERROR");
      return 1; 
    } else{
      board[y][x] = human;
      lastMove.setMove(x,y);
      
//      println("X: ", x, "Y: ", y);
    }
      return 0; 
    }

  int userTurn2(int x, int y){
    if (board[y][x] != 0){
      println("ERROR");
      return 1; 
    } else{
      println("Final: ", "( ", x, ", ",y, " )");
      board[y][x] = computer; 
      lastMove.setMove(x,y);
    }
      return 0; 
    }
    
  void computerTurn(){
    println("First call", turnOfPlayer);
    if (getMoves() ==0){
    userTurn2(moves.get(0));
    //SmallGame dummy = new SmallGame(this, moves.get(0), true);
    bestMove = miniMax(this,0).bestMove;
    //printMove(bestMove);
    //userTurn2(bestMove);
    }
   //suserTurn2(bestMove);
  }
    int userTurn2(Move x){
      printMove(x);
    if (board[x.moveY][x.moveX] != 0){
      println("ERROR");
      return 1; 
    } else{
      board[x.moveY][x.moveX] = computer; 
      lastMove.setMove(x);
    }
      return 0; 
    }
  }
  