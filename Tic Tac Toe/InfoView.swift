//
//  InfoView.swift
//  Tic Tac Toe
//
//  Created by Yin-Lin Chen on 2023/1/31.
//

import Foundation
import UIKit

class InfoView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        // reference: https://developer.apple.com/documentation/quartzcore/calayer
        self.layer.cornerRadius = 10.0
        self.layer.borderColor = UIColor.systemBlue.cgColor
        self.layer.borderWidth = 5.0
        self.layer.backgroundColor = UIColor.lightGray.cgColor
    }
}
