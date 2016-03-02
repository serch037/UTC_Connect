package com.company;

import java.util.ArrayList;

/**
 * Created by sergio on 3/1/16.
 */
public class Board {
    int board[][];
    boolean is_gomoku;
    boolean ComputerTurn;
    int Xdim, Ydim;
    ArrayList<Move> moves;
    Move LastMove;
    int human = -1;
    int computer = 1;
    int connect;
    ArrayList<Move> bestMoves;
    Move theMove;

    Board(boolean type, boolean _turn,int x, int y, int _connect){//Main init
        is_gomoku = type;
        ComputerTurn = _turn;
        Xdim  = x;
        Ydim = y;
        board = new int[y][x];
        moves = new ArrayList<Move>();
        connect = _connect;
    }

    Board(int arr[][], int _connect ){//Main init
        board = cloneBoard(arr);
        Xdim = board[0].length;
        Ydim = board.length;
        connect = _connect;
    }

    Board(Board m ){//Init with board
        board = cloneBoard(m.board);
        Xdim = board[0].length;
        Ydim = board.length;
        connect = m.connect;
        bestMoves = new ArrayList<Move>();
        ComputerTurn = m.ComputerTurn;
    }

    Board(Board m, boolean _computerTurn ){//Init with board
        this(m);
        ComputerTurn = _computerTurn;
    }

    Board(Board m, boolean _computerTurn, Move _m ){//Init with board
        this(m);
        makeMove(_m);
        theMove = _m;
        ComputerTurn = _computerTurn;
    }


    public int[][] cloneBoard(int arr[][]){
        int _X = arr[0].length;
        int _Y = arr.length;
        int ans[][] = new int[_Y][_X];
        for (int y = 0; y<_Y;y++){
            for (int x = 0; x<_X;x++){
                ans[y][x] = arr[y][x];
            }
        }
return ans;
    }


    public ArrayList<Move> getMoves(){
        ArrayList<Move> tmp = new ArrayList<Move>();
        for (int y = 0; y < Ydim;y++) {
            for (int x = 0; x < Xdim; x++) {
                if (board[y][x] == 0) tmp.add(new Move(x,y));
            }
        }
        return tmp;
    }

    public void computerMove(){
         Move tmp = new Move(0,0);
        ComputerTurn = true;
        miniMaxPlayer tmpPlayer = new miniMaxPlayer(this);
        tmpPlayer.playMiniMax();
        move(tmp, computer);
    }

    public void userTurn(int x, int y){
        move(new Move(x,y), human);
    }

    public void userTurn2(int x, int y){
        move(new Move(x,y), computer);
    }

    private void move(Move m, int value){
        board[m.Y][m.X] = value;
    }

    private void makeMove(Move m){
        board[m.Y][m.X] = ComputerTurn ? computer : human;
    }


    public void printBoard(){
        for (int y = 0; y < Ydim;y++){
            for(int x = 0; x<Xdim; x++){
                System.out.print(" | "+board[y][x] );
            }
            System.out.println();
        }
        System.out.println();
    }
    /*
    public void printMoves(){
        System.out.println("Begin Moves Printing");
        for (Move x: getMoves()){
            System.out.print(x);
        }
        System.out.println("End Moves Printing");
    }
    */

    public String printMoves(){
        String ans ="";
        for (Move x: getMoves()){
            ans+=x+"\n";
        }
        return ans;
    }

    public String printMoves(ArrayList<Move> moves){
        String ans ="";
        for (Move x: moves){
            ans+=x+"\n";
        }
        return ans;
    }

    public char whoWon(){
        int condition = evaluateFixed();
        if (condition == -1000) return 'h';
        if (condition == 0) return 't';
        if (condition == 1000) return 'c';
        if (condition == -1) return 'n';
        return '?';
    }

    private int evaluateFixed(){
        int humanCount=0;
        int computerCount =0;

        //Check Horizontal
        for (int y = 0; y<Ydim; y++){
            humanCount = 0;
            computerCount = 0;
            for (int x = 0; x<Xdim; x++) {
                if (board[y][x] == computer) {
                    if (humanCount <0){
                        humanCount = 0;
                    }
                    computerCount++;
                }else if (board[y][x] == human){
                    if (computerCount<0){
                        computerCount =0;
                    }
                    humanCount++;
                }
                else if (board[y][x]== 0){
                    humanCount = 0;
                    computerCount = 0;
                }
                if (humanCount >= connect) return -1000; //Human Won
                if (computerCount >= connect) return 1000; //Computer Won
            }
        }

        //Check Horizontal
        for (int x = 0; x<Xdim; x++){
            humanCount = 0;
            computerCount = 0;
            for (int y = 0; y<Ydim; y++){
                if (board[y][x] == computer){
                    if (humanCount <0){
                        humanCount =0;
                    }
                    computerCount++;
                }else if (board[y][x] == human){
                    if (computerCount<0){
                        computerCount = 0;
                    }
                    humanCount++;
                }
                else if (board[y][x]== 0){
                    humanCount = 0;
                    computerCount = 0;
                }
                if (humanCount >= connect) return -1000; //Human Wins
                if (computerCount >= connect) return 1000; //Computer Wins
            }
        }
        //Check Diagonal \\ Across Y
        for (int y = 0; y< Ydim; y++){
            int tmpX = 0;
            int tmpY = y;
            humanCount = 0;
            computerCount =0;
            while (tmpY<Ydim && tmpX<Xdim){
                if (board[tmpY][tmpX] == computer){
                    if (humanCount <0){
                        humanCount =0;
                    }
                    computerCount++;
                }else if (board[tmpY][tmpX] == human){
                    if (computerCount<0){
                        computerCount = 0;
                    }
                    humanCount++;
                }
                else if (board[tmpY][tmpX]== 0){
                    humanCount = 0;
                    computerCount = 0;
                }
                tmpX++;
                tmpY++;
                if (humanCount >= connect) return -1000; //Human Wins
                if (computerCount >= connect) return 1000; //Computer Wins
            }
        }
        //Check Diagonal \\ Across X
        for (int x =1; x<Xdim;x++){
            int tmpY =0;
            int tmpX = x;
            humanCount = 0;
            computerCount =0;
            while (tmpY<Ydim && tmpX<Xdim){
                if (board[tmpY][tmpX] == computer){
                    if (humanCount <0){
                        humanCount =0;
                    }
                    computerCount++;
                }else if (board[tmpY][tmpX] == human){
                    if (computerCount<0){
                        computerCount = 0;
                    }
                    humanCount++;
                }
                else if (board[tmpY][tmpX]== 0){
                    humanCount = 0;
                    computerCount = 0;
                }
                tmpX++;
                tmpY++;
                if (humanCount >= connect) return -1000; //Human Wins
                if (computerCount >= connect) return 1000; //Computer Wins
            }
        }

        //Check Diagonal // Across X
        for (int x = 0; x< Ydim; x++){
            int tmpX = x;
            int tmpY = 0;
            humanCount = 0;
            computerCount =0;
            while (tmpY<Ydim && tmpX>=0){
                if (board[tmpY][tmpX] == computer){
                    if (humanCount <0){
                        humanCount =0;
                    }
                    computerCount++;
                }else if (board[tmpY][tmpX] == human){
                    if (computerCount<0){
                        computerCount = 0;
                    }
                    humanCount++;
                }
                tmpX--;
                tmpY++;
                if (humanCount >= connect) return -1000; //Human Wins
                if (computerCount >= connect) return 1000; //Computer Wins
            }
        }
        //Check Diagonal // Across Y
        for (int y =1; y<Ydim;y++){
            int tmpY =y;
            int tmpX = Xdim-1;
            humanCount = 0;
            computerCount =0;
            while (tmpY<Ydim && tmpX>=0){
                if (board[tmpY][tmpX] == computer){
                    if (humanCount <0){
                        humanCount =0;
                    }
                    computerCount++;
                }else if (board[tmpY][tmpX] == human){
                    if (computerCount<0){
                        computerCount = 0;
                    }
                    humanCount++;
                }
                tmpX--;
                tmpY++;
                if (humanCount >= connect) return -1000; //Human Wins
                if (computerCount >= connect) return 1000; //Computer Wins
            }
        }
        if (getMoves().isEmpty()) return 0;
        return -1; //No one won
    }

    @Override
    public String toString(){
        String tmp ="";
            for (int y = 0; y < Ydim;y++){
                for(int x = 0; x<Xdim; x++){
                    tmp += new String(" | "+board[y][x]);
                }
                tmp+="\n";
            }
            tmp+="\n";
        return tmp;
        }

    }

