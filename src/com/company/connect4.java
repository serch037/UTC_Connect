package com.company;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;
/**
 * Created by sergio on 3/1/16.
 */
public class connect4 {
    Board game;
    int[][] test1,test2,test3,test4,test5,test6, test7,test8,test9,test10,test11;


    ArrayList<Board> tests;

    connect4(int t){
        /*
        test1 = new int[][] {
                { 1, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 1, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 1, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 1, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0 }
        };
        test2 = new int[][] {
                { 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 1, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 1, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 1, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 1 }
        };
        test3 = new int[][] {
                { 0, 0, 0, 0, 0, 0, 0, 1 },
                { 0, 0, 0, 0, 0, 0, 1, 0 },
                { 0, 0, 0, 0, 0, 1, 0, 0 },
                { 0, 0, 0, 0, 1, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0 }
        };
        test3 = new int[][] {
                { 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 1, 0, 0, 0, 0 },
                { 0, 0, 1, 0, 0, 0, 0, 0 },
                { 0, 1, 0, 0, 0, 0, 0, 0 },
                { 1, 0, 0, 0, 0, 0, 0, 0 }
        };
        test4 = new int[][] {
                { 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 1, -1, 1, 1, 1, 1, 0 },
                { 0, -1, 0, 0, 0, 0, 0, 0 },
                { -1, 0, 0, 0, 0, 0, 0, 0 }
        };
        test5 = new int[][] {
                { 0, 0, 0, 0, 0, 1, 0, 0 },
                { 0, 0, 0, 0, -1, 1, -1, 0 },
                { 0, 0, 0, 0, 0, 1, 0, 0 },
                { 0, 0, 0, 0, 0, 1, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0 }
        };
        test6 = new int[][] {
                { -1, 1, -1, 1, 1, 1, 1, -1 },
                { 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0, 0, 0 }
        };
        */
        test1 = new int[][] {
                {1,0,-1},
                {0,1,-1},
                {0,0,0}
        };
        test2 = new int[][] {
                {1,0,-1},
                {0,0,-1},
                {0,0,1}
        };
        test3 = new int[][] {
                {1,0,-1},
                {0,0,-1},
                {1,0,0}
        };
        test4 = new int[][] {
                {1,0,0},
                {0,-1,0},
                {-1,0,0}
        };
        test5 = new int[][] {//Fails miserably when second
                {-1,0,1},
                {-1,0,0},
                {0,0,0}
        };
        test5 = new int[][] {
                {-1,1,1},
                {0,-1,0},
                {0,0,0}
        };
        test6 = new int[][] {
                {0,1,0},
                {-1,0,0},
                {-1,0,0}
        };
        test7 = new int[][]{
                {1, 1, -1},
                {-1, -1, 1},
                {1, -1, 0}
        };
        tests = new ArrayList<Board>();
        tests.add(new Board(test1, 3));
        //tests.add(new Board(test2,3));
        //tests.add(new Board(test3,3));
        //tests.add(new Board(test7,3));
        //tests.add(new Board(test5,3));
        /*
        tests.add(new Board(test2,4));
        tests.add(new Board(test3,4));
        tests.add(new Board(test4,4));
        tests.add(new Board(test5,4));
        tests.add(new Board(test6,4));
        tests.add(new Board(test7,3));
        */
    }
    connect4() {
        game = new Board(false, false, 7, 6, 4); //User begins connecting four on a 7*6 board

    }
    public void turn(){
        if (game.ComputerTurn){
            Scanner reader = new Scanner(System.in);
            System.out.println("Enter the move coordinates int the format \"x,y\" ");
            String input = reader.nextLine();
            int [] coordinates = Arrays.asList(input.split(","))
                    .stream()
                    .map(String::trim)
                    .mapToInt(Integer::parseInt).toArray();
            game.userTurn(coordinates[0], coordinates[1]);
            game.ComputerTurn= true;
            game.ComputerTurn =  false;

        }else{
            Scanner reader = new Scanner(System.in);
            System.out.println("Enter the move coordinates int the format \"x,y\" ");
            String input = reader.nextLine();
            int [] coordinates = Arrays.asList(input.split(","))
                    .stream()
                    .map(String::trim)
                    .mapToInt(Integer::parseInt).toArray();
            game.userTurn(coordinates[0], coordinates[1]);
            game.ComputerTurn= true;
        }
    }
    public void test(){
        /*
        System.out.println("Begin Simple Evaluations");
        for (Board b : tests){
            if(b.whoWon()!='h'){
                System.out.println("Error");
                b.printBoard();
                System.out.println(b.whoWon());
            }
            else System.out.println("True");
        }
        */
        System.out.println("Begin MiniMax Evaluations");
        for (Board b : tests) {
            b.ComputerTurn = true;
            b.computerMove();
        }
    }
}
