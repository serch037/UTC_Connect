import java.util.*; 
//1 == x , -1 == 0
class Game{
  int board[][];
  boolean turnOfPlayer, playerBegins;
  Scanner reader; 
  int human, computer;
  boolean continueGame;
  int diag1, diag2;
  int row[], col[];
  
  Game(boolean turn){
    board = new int[3][3];
    playerBegins = turn;
    turnOfPlayer = turn;
    reader = new Scanner(System.in);
    continueGame = true; 
    if (playerBegins){
      human = 1;
      computer =  -1;
    }else{
      human = -1;
      computer =  1;
    }
    row = new int[3]; 
    col = new int[3]; 
  }
  
  void computerTurn(){
  }
  
  void evaluate(int locX, int locY,int point){
        row[locY]+=point;
        col[locX]+=point;
        if(locX ==locY) diag1+=point;
        if(abs(locX-locY)==2 || (locX==1 && locY ==1)) diag2+=point;
        println("Row: ",row[locY], "Col: ", col[locX], "Diag: ", diag1, "Diag: ", diag2, "Delta", point);
        if (row[locY] == 3 || col[locX] == 3 || diag1 ==3 || diag2 == 3 ||
        row[locY] == -3 || col[locX] == -3 || diag1 ==-3 || diag2 ==-3) continueGame = false;
      }

  
  int userTurn(int x, int y){
    if (board[y][x] != 0){
      return 1; 
    } else{
      board[y][x] = human; 
    }
      return 0; 
    }

  
    int userTurn2(int x, int y){
    if (board[y][x] != 0){
      return 1; 
    } else{
      board[y][x] = computer; 
    }
      return 0; 
    }
  }
  