//
//  GridView.swift
//  Tic Tac Toe
//
//  Created by Yin-Lin Chen on 2023/1/31.
//

import Foundation
import UIKit

class GridView: UIView {

    
    // draw the grid of four lines
    override func draw(_ rect: CGRect) {

        let path = UIBezierPath()
        // two vertical lines
        path.move(to: CGPoint(x: 100, y: 0))
        path.addLine(to: CGPoint(x: 100, y: 300))
        path.move(to: CGPoint(x: 215, y: 0))
        path.addLine(to: CGPoint(x: 215, y: 300))
        // two horizontal lines
        path.move(to: CGPoint(x: 5, y: 85))
        path.addLine(to: CGPoint(x: 300, y: 85))
        path.move(to: CGPoint(x: 5, y: 205))
        path.addLine(to: CGPoint(x: 300, y: 205))
    
        path.lineWidth = 10
        path.stroke()
    }
    

}
