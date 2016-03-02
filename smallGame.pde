class Move{
  int moveX;
  int moveY;
  int id;
  Move(){
  }
  Move(int _X , int _Y){
    moveX = _X;
    moveY = _Y;
    id = totalCases;
  }
  void setMove(int _X , int _Y, int _id){
     moveX = _X;
    moveY = _Y;
    id = _id;
  }
    void setMove(Move x){
     moveX = x.moveX;
    moveY = x.moveY;
    id = x.id;
  }
}


class SmallGame{
//1 == x , -1 == 0
  int board[][];
  boolean continueGame, humanWon, computerWon, tieWon;
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
  int bestmove;
  SmallGame(){
  }
  
  SmallGame(boolean turn, int x[][]){
    board = x;
    turnOfPlayer = turn; 
    human = 1;
    computer = -1;
    moves  = new ArrayList<Move>();
    row = new int[3];
    col = new int[3];
    diag1=0;
    diag2=0;
    evaluate();
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
    //output.println("test");
        continueGame = true; 
    //bestmove =  turnOfPlayer ? 9999:-9999;
    evaluation = evaluate();
    //printArray();
     //printEval();
       // output.println("testend");
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
     output.print( " ) ");
     output.print(move.id);
     output.println();
 }
  
  //Score = 0;
  //x = 1;
  //y = 0;
  Move chooseBest3(){
    Move ans = null;
    getMoves();
    Integer mm = null; 
      for (Move m: moves){ 
          SmallGame tmp = new SmallGame(this,m,!turnOfPlayer);
          int value = tmp.miniMax3(0);
          printMove(m);
          output.println(value+ "\n");
          if (mm == null || (!turnOfPlayer && mm < value) || (turnOfPlayer &&  value < mm ) ){
            //printMove(m);
            mm = value; 
            ans = m ;
          }
          
      }
      output.println(mm);
    return ans;
  }
  
  
  int miniMax3(int depth){
    getMoves();
    whoWon();
    if (computerWon){ return 100;}
    if (humanWon){ return -100;}
    if (tieWon){ return 0;}
    Integer mm = null;
    for (Move m: moves){
        SmallGame tmp = new SmallGame(this, m, !this.turnOfPlayer);
        int value = tmp.miniMax3(depth+1);
        if (mm == null || (!turnOfPlayer && mm < value) || (turnOfPlayer &&  value < mm ) ){
          //output.println("\nMM: "+ mm);
          mm = value;
          output.println("Inloop: "+ value+ " Depth: "+depth);
          tmp.printArray();
          printMove(m);
          //output.println("Value: "+mm);
        }
    }
    try{
    return mm + (turnOfPlayer? 1:-1) ;
    }
    catch (NullPointerException e){
      return 5; 
    }
  }
  int[] miniMax2(int depth, boolean computerTurn){
    output.println("FirstLine of : "+depth);
    totalCases++;
    ArrayList<Move> pMoves = getMoves2();
    whoWon();
    int bestScore = computerTurn ? -9999:9999;
    int currentScore;
    int bestRow = -1;
    int bestCol = -1;
    printArray();
    output.println(computerWon+", "+humanWon+", "+tieWon);
    printEval();
    if (computerWon || humanWon || tieWon){
      bestScore = evaluate();
      output.println(bestScore+ " Game OVER");
      computerWon = false;
      humanWon = false;
      tieWon = false;
    } else {
      for (Move m : pMoves){
        board[m.moveY][m.moveX] = computerTurn ? computer:human;
        output.println("Depth: "+ depth+"\n");
        if (computerTurn){ //MAX
        currentScore = miniMax2( depth+1, false)[0];
        output.println("Current: "+ currentScore+" bestScore "+bestScore+ " Turn of computer " +computerTurn);

        if (currentScore > bestScore){
          output.println("Maxxed: "+depth);
          printMove(m);
          bestScore = currentScore;
          bestRow = m.moveY;
          bestCol = m.moveX;
        }
        }else { //MIN
        currentScore = miniMax2(depth+1, true)[0];
        output.println("Current: "+ currentScore+" bestScore "+bestScore+ " Turn of computer " +computerTurn);

        if (currentScore < bestScore){
          output.println("Minned: "+depth);
          printMove(m);
          bestScore = currentScore;
          bestRow = m.moveY;
          bestCol = m.moveX;
        }
        }
        board[m.moveY][m.moveX] = 0;
      }
    }
    return new int[]{bestScore, bestRow, bestCol};
  }
  
  Integer miniMax(SmallGame aGame, int depth){//returns array with best moves
  if (depth==1){
    output.println("New branch");
    output.println(totalCases);
  }
  output.println("Begin Minimax for");
  aGame.printArray();
  output.println(aGame.evaluation);
  aGame.printEval();
  output.println();
  aGame.whoWon();
  totalCases++;
  //aGame.getMoves();
    if (aGame.computerWon || aGame.humanWon || aGame.tieWon){
      //aGame.printArray();
      //println("Finito", depth);
      //printArray();
      endCases++;
      if(aGame.computerWon) output.println("Computer Won");
      if(aGame.humanWon) output.println("Human Won");
      if(aGame.tieWon) output.println("Tie");
      return aGame.evaluation;
    }
    if (aGame.turnOfPlayer){ //MIN's turn
      for(Move x : aGame.moves){
      SmallGame possible_game = new SmallGame(aGame, x, !aGame.turnOfPlayer); //Makes move
      println("Simulating min turn with depth:" ,depth);
      output.print("\nSimulating min turn with depth:");
      output.print(depth);
      output.println();
      printMove(x);
      output.println("Continue?? "+ possible_game.continueGame);
      //possible_game.printArray();
      //possible_game.printEval();
      println(possible_game.turnOfPlayer);
      println();
      output.println("Begin Min recursion");
      int tmp = miniMax(possible_game, depth+1);
      output.println(tmp);
      output.println("End Min recursion");
      if (tmp<aGame.bestmove){
        output.print("OLD Min:"+ tmp);
        output.println(" OLD bestmove:"+ aGame.bestmove);
        aGame.bestmove = tmp;
        output.print("NEW MIN: ");
        output.println(tmp);
        output.println("New bestmove: "+aGame.bestmove);
        aGame.bestMove.setMove(x);
        return aGame.bestmove;
      }
          //return possible_game; 
    }
    }
    else{//Max's turn
      for(Move x : aGame.moves){
      SmallGame possible_game = new SmallGame(aGame, x, !aGame.turnOfPlayer); //Makes move
      println("Simulated max turn with depth:" ,depth);
            output.print("\nSimulating max turn with depth:");
      output.print(depth);
      output.println();
      printMove(x);
      output.println("Continue?? "+ possible_game.continueGame);
//      possible_game.printArray();
      //possible_game.printEval();
      println(possible_game.turnOfPlayer);
      output.println("Begin Max recursion");
      int tmp = miniMax(possible_game, depth+1); 
      output.println("End MAX recursion");
      println();
      if (tmp>aGame.bestmove ){
        println("MAX: ",tmp);
        output.print("OLD MAX:"+ tmp);
        output.println(" OLD bestmove:"+ aGame.bestmove);
        aGame.bestmove = tmp;
        //output.print("Set my final move to ");
        //printMove(x);
        output.print("New MAX: ");
        output.println(tmp);
        output.println("New bestmove: "+aGame.bestmove);
        if (depth ==0){
          aGame.bestMove.setMove(x);
          output.println("Game won at 1:");
        }
        //return possible_game;
        return aGame.bestmove;
      }
    }
    }
        output.println("End of Minimax");
        return 0;
  }
  
    ArrayList<Move>  getMoves2(){
      ArrayList<Move> newMoves =  new ArrayList<Move>();
  for (int y = 0; y<3 ; y++){
    for (int x = 0; x<3;x++){
      if (board[y][x] ==0) newMoves.add(new Move(x,y));
    }
  }
  return newMoves;
  }
  
  
  int  getMoves(){
  if(!moves.isEmpty()) moves.clear();
  for (int y = 0; y<3 ; y++){
    for (int x = 0; x<3;x++){
      if (board[y][x] ==0) moves.add(new Move(x,y));
    }
  }
  if (moves.isEmpty()){ return 1;} 
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
      
      void whoWon(){
        int tmp = evaluate();
        if (tmp >0) computerWon = true;
        if (tmp<0) humanWon = true;
        getMoves();
        if (moves.isEmpty() && tmp == 0) tieWon=true;
      }
      
      boolean computerWon(){
        whoWon();
        boolean ans= false;
        if (computerWon) ans = true;
        computerWon = false;
        return ans;
      }
      
        boolean humanWon(){
        whoWon();
        boolean ans= false;
        if (humanWon) ans = true;
        humanWon = false;
        return ans;
      }
        boolean tieWon(){
        whoWon();
        boolean ans= false;
        if (tieWon) ans = true;
        tieWon = false;
        return ans;
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
        row[y] == -3 || col[x] == -3 || diag1 ==-3 || diag2 ==-3){
          //continueGame = false;
          //output.println("Game Finished "+continueGame);
          //printArray();
                    if (row[y] ==-3 || col[x]  ==-3 || diag1==-3 || diag2==-3) return 100;
          return -100;
    }

}
}
return 0;
}


}