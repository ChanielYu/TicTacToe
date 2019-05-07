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
        context?.saveGState()
        context?.setFillColor(backGroudColor.cgColor)
        context?.fill(rect)
        context?.setStrokeColor(foreGroudColor.cgColor)
        context?.setLineWidth(10)
        context?.move(to: CGPoint(x: rect.minX, y: rect.minY))
        context?.addLine(to: CGPoint(x: rect.maxX,y: rect.maxY))
        context?.strokePath()
        drawCircle(context: context, rect: rect)
        drawCross(context: context, rect: rect)
        context?.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context?.addLine(to: CGPoint(x: rect.maxX,y: rect.minY))
        context?.strokePath()
        context?.restoreGState()
    }

    private func drawCircle(context: CGContext?, rect: CGRect) {
        let bound = rect.insetBy(dx: rect.midX/5, dy: rect.midY/5)
        context?.saveGState()
        context?.setLineWidth(min(bound.width, bound.height)/10)
        context?.addEllipse(in: bound)
        context?.strokePath()
        context?.restoreGState()
    }

    private func drawCross(context: CGContext?, rect: CGRect) {
        let bound = rect.insetBy(dx: rect.midX/5, dy: rect.midY/5)
        context?.saveGState()
        context?.setLineWidth(min(bound.width, bound.height)/10)
        context?.move(to: CGPoint(x: bound.minX, y: bound.minY))
        context?.addLine(to: CGPoint(x: bound.maxX,y: bound.maxY))
        context?.move(to: CGPoint(x: bound.minX, y: bound.maxY))
        context?.addLine(to: CGPoint(x: bound.maxX,y: bound.minY))
        context?.strokePath()
        context?.restoreGState()
    }
}
