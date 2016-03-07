package com.company;

import java.util.ArrayList;

/**
 * Created by theKGS on 3/2/16.
 */
public class Node {
    public double[] score;
    public double games;
    public Move move;
    public ArrayList<Node> unvisitedChildren;
    public ArrayList<Node> children;
    public Node parent;
    public int player;
    public boolean computerTurn;
    public double[] pess;
    public double[] opti;
    public boolean pruned;
    public int depth;

//Root node
    public Node(Board b) {
        children = new ArrayList<Node>();
        computerTurn = b.isComputerTurn();
        player = computerTurn ? 0:1;
        score = new double[2];
        pess = new double[2];
        opti = new double[2];
        for (int i = 0; i < 2; i++)
            opti[i] = 1;
    }

    public Node(Board b, int alt) {
        children = new ArrayList<Node>();
        computerTurn = b.isComputerTurn();
        player = computerTurn ? 1:0;
        score = new double[2];
        pess = new double[2];
        opti = new double[2];
        for (int i = 0; i < 2; i++)
            opti[i] = 1;
    }


    public Node(Board b, Move m, Node prnt){
        children = new ArrayList<Node>();
        parent = prnt;
        depth = parent.depth + 1;
        move = m;
        Board tmpBoard = new Board(b,m);
        computerTurn = tmpBoard.isComputerTurn();
        score = new double[2];
        pess = new double[2];
        opti = new double[2];
        player = computerTurn ? 0:1;
        for (int i = 0; i < 2; i++)
            opti[i] = 1;
    }

    public Node(Board b, Move m, Node prnt, int alt){
        children = new ArrayList<Node>();
        parent = prnt;
        depth = parent.depth + 1;
        move = m;
        Board tmpBoard = new Board(b,m);
        computerTurn = tmpBoard.isComputerTurn();
        score = new double[2];
        pess = new double[2];
        opti = new double[2];
        player = computerTurn ? 1:0;
        for (int i = 0; i < 2; i++)
            opti[i] = 1;
    }

    public double upperConfidenceBound(double c) {
        return score[parent.player] / games + c
                * Math.sqrt(Math.log(parent.games + 1) / games);
    }

    public void backPropagateScore(double[] scr){
        this.games++;
        for (int i = 0; i< scr.length; i++){
            this.score[i] += scr[i];
        }
        if (parent!= null){
            parent.backPropagateScore(scr);
        }
    }

    public void backPropagateBounds(double[] _opti, double[] _pess){
        for (int i =0; i<_opti.length; i++){
            opti[i] = _opti[i];
            opti[i] = _opti[i];
        }
        if (parent != null){
            parent.backPropagateBoundsHelper();
        }
    }

    private void backPropagateBoundsHelper() {
        for (int i = 0; i < opti.length; i++) {
            if (i == player) {
                opti[i] = 0;
                pess[i] = 0;
            } else {
                opti[i] = 1;
                pess[i] = 1;
            }
        }


        for (int i = 0; i < opti.length; i++){
            for (Node c: children){
                if (i == player){
                    if (opti[i] < c.opti[i]){
                        opti[i] = c.opti[i];
                    }
                    if (pess[i] < c.pess[i]){
                        pess[i] = c.pess[i];
                    }
                } else {
                    if (opti[i] > c.opti [i]){
                        opti[i] = c.opti[1];
                    }
                    if (pess[i] > c.pess[i]){
                        opti[i] = c.opti[i];
                    }
                }
            }
        }
        if (!unvisitedChildren.isEmpty()){
            for (int i = 0; i < opti.length; i++){
                if (i == player){
                    opti[i] = 1;
                } else {
                    pess[i] = 0;
                }
            }
        }

        pruneBranches();
        if(parent != null){
            parent.backPropagateBoundsHelper();
        }
    }

    public void pruneBranches(){
        for (Node s: children){
            if (pess[player] >= s.opti[player]) {
                s.pruned = true;
            }
        }
        if (parent != null){
            parent.pruneBranches();
        }
    }

}
