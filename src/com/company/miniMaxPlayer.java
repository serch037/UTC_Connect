package com.company;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

/**
 * Created by sergio on 3/1/16.
 */
public class miniMaxPlayer {
    Board mainGame;
    ArrayList<Move> bestFinalMoves = new ArrayList<Move>();
    String empty = "";
    PrintWriter writer;
    File file = new File("miniMax.txt");
    int evals=0;
    int posLimit = 99999;
    int negLimit = -99999;



    miniMaxPlayer(){
        //board = new int[][];
    }

    miniMaxPlayer(Board b){
        mainGame = new Board(b);
        try {
            openWriter();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void playMiniMax() {
        //Move  tmpMove = miniMaxEnd2(mainGame, 0).bestMove;
        //Move  tmpMove = miniMaxEnd3(mainGame, 0,negLimit,posLimit).bestMove;
        System.out.println("Finalized all");
        writer.println("Original\n"+mainGame);
        //System.out.println(tmpMove);
        //System.out.println(bestMove);
        System.out.println("TheMoves");
        System.out.println(mainGame.printMoves(bestFinalMoves));
        System.out.println(evals);
            writer.flush();
            writer.close();
        //return tmpMove;
    }

    private void  openWriter() throws FileNotFoundException {
        writer = new  PrintWriter("miniMax.txt");
        writer.println("Test");
    }

    private result miniMaxEnd2(Board tmpGame, int depth) {
        evals += 1;
        char winner = tmpGame.whoWon();
        ArrayList<Move> myMoves = tmpGame.getMoves();

        if (winner == 'c') { //Base Cases
            writer.println("Computer wins");
            return new result(1000);
        } else if (winner == 'h') {
            writer.println("Human wins");
            return new result(-1000);
        } else if (winner == 't') {
            writer.println("Tie wins");
            return new result(0);
        }
        Move bestMove1 = new Move(-1, -1);
        if (tmpGame.ComputerTurn) {//MAX
            int bestScore1 = negLimit;
            for (Move m : tmpGame.getMoves()) {
                Board newGame = new Board(tmpGame, !tmpGame.ComputerTurn, m);
                writer.println("Begin recursive max");
                result aScore = miniMaxEnd2(newGame, depth + 1);

                if (aScore.score > bestScore1) {
                    bestScore1 = aScore.score;
                    bestMove1 = m.duplicate();
                    writer.println("Won depth" + depth);
                    if (depth <= 1) {
                        System.out.println("Out");
                        bestFinalMoves.clear();
                        bestFinalMoves.add(m);
                    }
                }
            }
            return new result(bestScore1, bestMove1);
        } else {//MIN
            int bestScore1 = posLimit;
            for (Move m : tmpGame.getMoves()) {
                Board newGame = new Board(tmpGame, !tmpGame.ComputerTurn, m);
                writer.println("Begin recursive min");
                result aScore = miniMaxEnd2(newGame, depth + 1);
                writer.println("End recursive min");
                if (aScore.score < bestScore1) {
                    writer.println("Min Score Change");
                    bestScore1 = aScore.score;
                    bestMove1 = m.duplicate();
                }

            }
            return new result(bestScore1, bestMove1);

        }

        //System.out.println("Error, should never reach here");
        //return new result(-666);
    }

    private result miniMaxEnd3(Board tmpGame, int depth, int alpha, int beta) { //Now with alpha-beta
        evals += 1;
        char winner = tmpGame.whoWon();
        ArrayList<Move> myMoves = tmpGame.getMoves();

        if (winner == 'c') { //Base Cases
            writer.println("Computer wins");
            return new result(1000 - depth, tmpGame.theMove);
        } else if (winner == 'h') {
            writer.println("Human wins");
            return new result(depth - 1000, tmpGame.theMove);
        } else if (winner == 't') {
            writer.println("Tie wins");
            return new result(0, tmpGame.theMove);
        }
        Move bestMove = new Move(-1, -1);
        if (tmpGame.ComputerTurn) {//MAX
            int bestScore = negLimit;
            for (Move m : tmpGame.getMoves()) {
                Board newGame = new Board(tmpGame, !tmpGame.ComputerTurn, m);
                writer.println("Begin recursive max");
                result aScore = miniMaxEnd3(newGame, depth + 1, alpha, beta);
                if (aScore.score > alpha) {
                    alpha = aScore.score;
                    bestMove = m.duplicate();
                    if (depth == 0) {
                        bestFinalMoves.add(m);
                    }
                }
                if (alpha >= beta) break;
            }
            return new result(bestScore, bestMove);
        } else {//MIN
            int bestScore = posLimit;
            for (Move m : tmpGame.getMoves()) {
                Board newGame = new Board(tmpGame, !tmpGame.ComputerTurn, m);
                writer.println("Begin recursive min");
                result aScore = miniMaxEnd3(newGame, depth + 1, alpha, beta);
                writer.println("End recursive min");
                if (aScore.score < beta) {
                    writer.println("Min Score Change");
                    beta = aScore.score;
                    bestMove = m;
                    if (depth <= 5) {
                        writer.println("At depth " + depth);
                        writer.println("Score");
                        writer.println(m + "\n");
                    }
                }
                if (alpha >= beta) break;
            }
            return new result(bestScore, bestMove);

        }

        //System.out.println("Error, should never reach here");
        //return new result(-666);
    }

    /*
    private result miniMaxEnd(Board tmpGame, int depth){

        char winner =  tmpGame.whoWon();

        if (winner == 'c'){ //Base Cases
            writer.println("Computer wins");
            return new result(1000-depth, tmpGame.theMove);
        }else if (winner == 'h'){
            writer.println("Human wins");
            return new result(depth-1000,tmpGame.theMove);
        }
        else if (winner == 't'){
            writer.println("Tie wins");
            return new result(0,tmpGame.theMove);
        }

        ArrayList<Move> myMoves = tmpGame.getMoves();
        for (Move m: myMoves) {
            Board newGame = new Board(tmpGame,!tmpGame.ComputerTurn, m);
            bestScore = tmpGame.ComputerTurn ? -99999:99999;
                writer.write("\nDepth: "+depth);
                writer.write("\nNumber of moves: "+myMoves.size());
                writer.write("\nBefore\n"+tmpGame.toString());
                writer.write(""+m.toString()+" "+tmpGame.ComputerTurn+" "+depth);
                writer.write("\nAfter\n"+newGame.toString());

            if (tmpGame.ComputerTurn) {//MAX
                bestScore = -99999;
                writer.println("Begin recursive max");
                result aScore = miniMaxEnd(newGame, depth+1);
                if (aScore.score > bestScore){
                    writer.println("End recursive max");
                    writer.println("Max Score: " +aScore.score);
                    writer.println("Previous Score: "+bestScore);
                    bestScore = aScore.score;
                    if (depth == 0){
                        writer.println("Winner move");
                        writer.println(m);
                        writer.println("With Score: "+bestScore);
                        bestMove = m;
                    }
                }
            } else {//MIN
                 bestScore = 99999;
                writer.println("Begin recursive min");
                result aScore = miniMaxEnd(newGame, depth+1);
                if (aScore.score < bestScore){
                    writer.println("End recursive min");
                    writer.println("Min Score: " +aScore.score);
                    writer.println("Previous Score: "+bestScore);
                    writer.println(aScore.score);
                    writer.println(bestScore);
                    bestScore = aScore.score;
                }

            }

        }
        return new result(bestScore, bestMove);
        //System.out.println("Error, should never reach here");

        //return new result(-666);
    }
*/
    private class result {
        Move bestMove;
        int score;
        int alpha, beta;

        result(Move m, int x) {
            score = x;
            bestMove = m.duplicate();
        }

        result(int x, Move m) {
            score = x;
            bestMove = m.duplicate();
        }

        result(int x, Move m, int _alpha, int _beta) {
            score = x;
            bestMove = m.duplicate();
            alpha = _alpha;
            beta = _beta;
        }

        result(int x) {
            score = x;
            bestMove = null;
        }
    }

}
