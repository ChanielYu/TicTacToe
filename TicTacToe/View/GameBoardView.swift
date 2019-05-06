//
//  GameBoardView.swift
//  TicTacToe
//
//  Created by Chaniel Yu on 2019/5/6.
//  Copyright © 2019 Chaniel Yu. All rights reserved.
//

import UIKit

class GameBoardView: UIView {
    private let backGroudColor = UIColor.black
    private let foreGroudColor = UIColor.white

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backGroudColor.setFill()
        foreGroudColor.setStroke()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(backGroudColor.cgColor)
        context?.fill(rect)
        context?.setStrokeColor(foreGroudColor.cgColor)
        context?.setLineWidth(20)
        context?.stroke(bounds)
        context?.move(to: CGPoint(x: rect.minX,y: rect.minY))
        context?.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context?.strokePath()
    }
}
