//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Yin-Lin Chen on 2023/1/31.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet var square0: UIView!
    @IBOutlet var square1: UIView!
    @IBOutlet var square2: UIView!
    @IBOutlet var square3: UIView!
    @IBOutlet var square4: UIView!
    @IBOutlet var square5: UIView!
    @IBOutlet var square6: UIView!
    @IBOutlet var square7: UIView!
    @IBOutlet var square8: UIView!
    @IBOutlet var XPiece: UILabel!
    @IBOutlet var OPiece: UILabel!
    @IBOutlet var infoView: InfoView!
    @IBOutlet var infoLabel: UILabel!
    
    // reference: https://stackoverflow.com/questions/24805180/swift-put-multiple-iboutlets-in-an-array
    @IBOutlet var collectionOfSquares: Array<UIView>?
    
    let grid = Grid()

    override func viewDidLoad() {
        super.viewDidLoad()
        // pan gesture to x and o
        let panGesture1 = UIPanGestureRecognizer(target: self,
                                                action: #selector(handlePan(_:)))
        panGesture1.delegate = self
        
        XPiece.addGestureRecognizer(panGesture1)
        XPiece.text = "X"
        XPiece.textColor = UIColor.white
        XPiece.backgroundColor = UIColor.tintColor
        XPiece.font = XPiece.font.withSize(75)
        XPiece.textAlignment = .center
        XPiece.tag = 1
        let panGesture2 = UIPanGestureRecognizer(target: self,
                                                action: #selector(handlePan(_:)))
        panGesture2.delegate = self
        
        OPiece.addGestureRecognizer(panGesture2)
        OPiece.text = "O"
        OPiece.textColor = UIColor.white
        OPiece.backgroundColor = UIColor.systemOrange
        OPiece.font = OPiece.font.withSize(75)
        OPiece.textAlignment = .center
        OPiece.tag = 2
        // info view on the top
        self.infoView.center = CGPoint(x: self.view.center.x, y: -100)
        // https://stackoverflow.com/questions/6511443/how-to-make-a-uiview-always-appear-at-the-front
        self.infoView.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)

        xTurn()
    }
    
    func createNewPiece(pieceType: String) -> UILabel {
        let panGesture = UIPanGestureRecognizer(target: self,
                                                action: #selector(handlePan(_:)))
        panGesture.delegate = self
        if pieceType == "X" {
            let newXpiece = UILabel(frame: CGRect(x: 65, y: 650, width: 90, height: 90))
            newXpiece.text = "X"
            newXpiece.textColor = UIColor.white
            newXpiece.backgroundColor = UIColor.tintColor
            // https://stackoverflow.com/questions/24356888/how-do-i-change-the-font-size-of-a-uilabel-in-swift
            newXpiece.font = newXpiece.font.withSize(75)
            // https://stackoverflow.com/questions/24034300/swift-uilabel-text-alignment
            newXpiece.textAlignment = .center
            newXpiece.tag = 1
            newXpiece.isUserInteractionEnabled = true
            newXpiece.addGestureRecognizer(panGesture)
            view.addSubview(newXpiece)
            return newXpiece
        } else {
            let newOpiece = UILabel(frame: CGRect(x: 230, y: 650, width: 90, height: 90))
            newOpiece.text = "O"
            newOpiece.textColor = UIColor.white
            newOpiece.backgroundColor = UIColor.systemOrange
            newOpiece.font = newOpiece.font.withSize(75)
            newOpiece.textAlignment = .center
            newOpiece.tag = 2
            newOpiece.isUserInteractionEnabled = true
            newOpiece.addGestureRecognizer(panGesture)
            view.addSubview(newOpiece)
            return newOpiece
        }
    }
    
    func xTurn() {
        // attention getting animation
        self.XPiece.isUserInteractionEnabled = false
        UIView.animate(withDuration: 1.0) {
            self.XPiece.alpha = 0.5
        } completion: { (finished) in
        }
        UIView.animate(withDuration: 1.0) {
            self.XPiece.alpha = 1
        } completion: { (finished) in
        }
        self.XPiece.isUserInteractionEnabled = true
        self.OPiece.isUserInteractionEnabled = false
        self.OPiece.alpha = 0.1
    }
    
    func oTurn() {
        self.OPiece.isUserInteractionEnabled = false
        UIView.animate(withDuration: 1.0) {
            self.OPiece.alpha = 0.5
        } completion: { (finished) in
        }
        UIView.animate(withDuration: 1.0) {
            self.OPiece.alpha = 1
        } completion: { (finished) in
        }
        self.OPiece.isUserInteractionEnabled = true
        self.XPiece.isUserInteractionEnabled = false
        self.XPiece.alpha = 0.1
    }
    
    @IBAction func tapInfoButton(_ sender: Any) {
        print("InfoButton tapped")
        infoLabel.text = "Get 3 in a row to win!"
        //infoLabel.textAlignment = .center
        // Add animation to info view
        UIView.animate(withDuration: 1.0) {
            self.infoView.center = self.view.center
        } completion: { (finished) in
        }
    }
    
    @IBAction func tapOkButton(_ sender: Any) {
        print("success")
        UIView.animate(withDuration: 1.0) {
            self.infoView.center = CGPoint(x: self.view.center.x, y: 1000)
        } completion: { (finished) in
            self.infoView.center = CGPoint(x: self.view.center.x, y: -100)
        }
        // tap ok will start a new game
        if grid.winner().0 != 0 {
            newGame()
        }
    }
    
    func compareOverlap(piece: UIView, square: UIView) -> Bool {
        let pieceRec = CGRect(x: piece.center.x, y: piece.center.y, width: 100, height: 100)
        let squareRec = CGRect(x: square.center.x, y: square.center.y, width: 80, height: 80)
        return pieceRec.intersects(squareRec)
        
    }
    
    // create a new game, also start from x
    func newGame() {
        for subview in view.subviews {
            if subview.tag > 0 {
                subview.removeFromSuperview()
            }
        }
        grid.clearGrid()
        XPiece = createNewPiece(pieceType: "X")
        OPiece = createNewPiece(pieceType: "O")
        xTurn()
    }
    
    func drawLine(start: Int, end: Int) {
        // animation https://medium.com/%E5%BD%BC%E5%BE%97%E6%BD%98%E7%9A%84%E8%A9%A6%E7%85%89-%E5%8B%87%E8%80%85%E7%9A%84-100-%E9%81%93-swift-ios-app-%E8%AC%8E%E9%A1%8C/%E5%88%A9%E7%94%A8-cabasicanimation-cashapelayer-%E7%B9%AA%E8%A3%BD%E7%B7%9A%E6%A2%9D%E5%8B%95%E7%95%AB-dc08b4db4726
        let path = UIBezierPath()
        path.move(to: CGPoint(x: collectionOfSquares![start].center.x, y: collectionOfSquares![start].center.y))
        path.addLine(to: CGPoint(x: collectionOfSquares![end].center.x, y: collectionOfSquares![end].center.y))
        

        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor = UIColor.systemPink.cgColor
        shapeLayer.lineWidth = 8
        shapeLayer.path = path.cgPath

        view.layer.addSublayer(shapeLayer)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            shapeLayer.removeFromSuperlayer()
            
            // Show after the end of animation
            UIView.animate(withDuration: 1.0) {
                self.infoView.center = self.view.center
            } completion: { (finished) in
            }
        }
        let animation = CABasicAnimation(keyPath: "stroke")
        animation.fromValue = 0
        animation.duration = 1.5
        shapeLayer.add(animation, forKey: "animation")
        CATransaction.commit()
    }
    
    // handle the gesture of released
    @objc func handlePan(_ recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x: view.center.x + translation.x,
                                  y: view.center.y + translation.y)
            
            recognizer.setTranslation(CGPoint.zero, in: self.view)
            
            if recognizer.state == .ended {
                print("released")

                var overlapped = false
                for i in 0...8 {
                    if compareOverlap(piece: view, square: collectionOfSquares![i]) &&
                        grid.squares[i] == 0
                    {
                        UIView.animate(withDuration: 1.0) {
                            view.center = self.collectionOfSquares![i].center
                        } completion: { (finished) in
                        }
                        grid.squares[i] = view.tag
                        overlapped = true
                        break
                    }
                }
                if overlapped {
                    view.isUserInteractionEnabled = false
                    if view.tag == 1 {
                        XPiece = createNewPiece(pieceType: "X")
                        oTurn()
                    }
                    else {
                        OPiece = createNewPiece(pieceType: "O")
                        xTurn()
                    }
                } else {
                    if view.tag == 1 {
                        view.center = CGPoint(x: 115, y: 680)
                        xTurn()
                    } else {
                        view.center = CGPoint(x: 315, y: 680)
                        oTurn()
                    }
                }
                
                print(grid.squares)
                // check the winner
                print(grid.winner())
                let winner = grid.winner().0
                let start = grid.winner().1
                let end = grid.winner().2
                if winner == 1 {
                    self.XPiece.isUserInteractionEnabled = false
                    self.OPiece.isUserInteractionEnabled = false
                    self.infoLabel.text = "Congratulations, X wins!"
                    drawLine(start: start, end: end)
                }
                else if winner == 2 {
                    self.XPiece.isUserInteractionEnabled = false
                    self.OPiece.isUserInteractionEnabled = false
                    infoLabel.text = "Congratulations, O wins!"
                    drawLine(start: start, end: end)
                } else if winner == 3 {
                    self.XPiece.isUserInteractionEnabled = false
                    self.OPiece.isUserInteractionEnabled = false
                    infoLabel.text = "Oops! It is a tie."
                    // Add animation to info view
                    UIView.animate(withDuration: 1.0) {
                        self.infoView.center = self.view.center
                    } completion: { (finished) in
                    }
                }
            }
        }
    }
}

