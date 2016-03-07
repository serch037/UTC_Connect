package com.company;

public class Main {

    public static void main(String[] args) {
	// write your code here
        connect4 aGame = new connect4();
        //aGame.test();
        System.out.println("EOL");

        while (true){
            //aGame.game.printBoard();
            aGame.turn(1);
            if (aGame.game.whoWon() != 'n') break;
        }
        aGame.game.printBoard();
        System.out.println("Game over");
        System.out.println(aGame.game.whoWon());

        System.out.println("EOL");
    }
}
