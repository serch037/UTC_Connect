package com.company;

/**
 * Created by sergio on 3/1/16.
 */
public class Move {
    int X;
    int Y;

    Move(int _x, int _y){
        X = _x;
        Y = _y;
    }

    Move(Move m){
        X = m.X;
        Y = m.Y;
    }

    public Move duplicate(){
        int tmpX = X;
        int tmpY = Y;
        Move ans = new Move(tmpX,tmpY);
        return ans;
    }

    public Move copyOf(Move m){
        int tmpX = m.X;
        int tmpY = m.Y;
        Move ans = new Move(tmpX,tmpY);
        return ans;
    }

    @Override
    public String toString(){
        String tmp = (""+X+","+Y);
        return tmp;
    }


    @Override
    public int hashCode(){
        int hash;
        hash = 1/2*(X+Y)*(X+Y+1)+Y;
        return hash;
    }
}
