//
//  Grid.swift
//  Tic Tac Toe
//
//  Created by Yin-Lin Chen on 2023/1/31.
//

import Foundation

class Grid {
    var squares = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    // 0: nothing here, 1: x piece, 2: o piece
    
    func winner() -> (Int, Int, Int) {
        // first row
        if  (squares[0] != 0 && squares[0]==squares[1] && squares[1]==squares[2]) {
            return (squares[0], 0, 2)
        }
        // second row
        else if (squares[3] != 0 && squares[3]==squares[4] && squares[4]==squares[5]) {
            return (squares[3], 3, 5)
        }
        // third row
        else if (squares[6] != 0 && squares[6]==squares[7] && squares[7]==squares[8]) {
            return (squares[6], 6, 8)
        }
        // first column
        else if (squares[0] != 0 && squares[0]==squares[3] && squares[3]==squares[6]) {
            return (squares[0], 0, 6)
        }
        // second column
        else if (squares[1] != 0 && squares[1]==squares[4] && squares[4]==squares[7]) {
            return (squares[1], 1, 7)
        }
        // third column
        else if (squares[2] != 0 && squares[2]==squares[5] && squares[5]==squares[8]) {
            return (squares[2], 2, 8)
        }
        // left to right
        else if (squares[0] != 0 && squares[0]==squares[4] && squares[4]==squares[8]) {
            return (squares[0], 0, 8)
        }
        // right to left
        else if (squares[2] != 0 && squares[2]==squares[4] && squares[4]==squares[6]){
            return (squares[2], 2, 6)
        }
        // tie
        else if (squares[0] != 0 && squares[1] != 0 && squares[2] != 0 && squares[3] != 0 && squares[4] != 0 && squares[5] != 0 && squares[6] != 0 && squares[7] != 0 && squares[8] != 0)
        {
            return (3, 0, 0)  
        }
        else {
            return (0, 0, 0)
        }
    }
    
    // clear the grid
    func clearGrid(){
        squares = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    }

}
