//
//  GameBoardView.swift
//  TicTacToe
//
//  Created by Chaniel Yu on 2019/5/6.
//  Copyright © 2019 Chaniel Yu. All rights reserved.
//

import UIKit

class GameBoardView: UIView {
    static let MATRIX_SIZE = 3
    private static let CHESS_LINE_WIDTH_FACTOR = CGFloat(8)
    private let backGroudColor = UIColor.black
    private let foreGroudColor = UIColor.white
    private let winningColor = UIColor.red
    private var boardMatrix = Array(repeating: Array(repeating: 0, count: MATRIX_SIZE), count: MATRIX_SIZE)

    private var mode = -1
    private var startX = 0
    private var startY = 0

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
        let offset = getBoardLineWidth(rect: rect)
        let chessRectWidth = rect.width/3
        let chessRectHeight = rect.height/3
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        context?.setFillColor(backGroudColor.cgColor)
        context?.fill(rect)
        drawBoard(context: context, rect: rect)
        for (y, row) in boardMatrix.enumerated() {
            for (x, chess) in row.enumerated() {
                if (chess == 1) {
                    drawCircle(context: context, rect: CGRect(origin: CGPoint(x: chessRectWidth*CGFloat(x), y: chessRectHeight*CGFloat(y)), size: CGSize(width: chessRectWidth - offset, height: chessRectHeight - offset)))
                } else if (chess == 2) {
                    drawCross(context: context, rect: CGRect(origin: CGPoint(x: chessRectWidth*CGFloat(x), y: chessRectHeight*CGFloat(y)), size: CGSize(width: chessRectWidth - offset, height: chessRectHeight - offset)))
                } else {
                    // clear
                }
            }
        }
        context?.setStrokeColor(winningColor.cgColor)
        context?.setLineWidth(getBoardLineWidth(rect: rect))
        switch mode {
        case 0:
            context?.move(to: CGPoint(x: rect.minX, y: chessRectHeight*CGFloat(startY)+chessRectHeight/2))
            context?.addLine(to: CGPoint(x: rect.maxX, y: chessRectHeight*CGFloat(startY)+chessRectHeight/2))
            break
        case 1:
            context?.move(to: CGPoint(x: chessRectWidth*CGFloat(startX)+chessRectWidth/2, y: rect.minY))
            context?.addLine(to: CGPoint(x: chessRectWidth*CGFloat(startX)+chessRectWidth/2, y: rect.maxY))
            break
        case 2:
            context?.move(to: CGPoint(x: rect.minX, y: rect.minY))
            context?.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            break
        case 3:
            context?.move(to: CGPoint(x: rect.minX, y: rect.maxY - offset))
            context?.addLine(to: CGPoint(x: rect.maxX, y: rect.minY - offset))
            break
        default:
            break
        }
        context?.strokePath()
        context?.restoreGState()
    }

    private func drawCircle(context: CGContext?, rect: CGRect) {
        let bound = rect.insetBy(dx: rect.width/10, dy: rect.height/10)
        context?.saveGState()
        context?.setStrokeColor(foreGroudColor.cgColor)
        context?.setLineWidth(min(bound.width, bound.height)/GameBoardView.CHESS_LINE_WIDTH_FACTOR)
        context?.addEllipse(in: bound)
        context?.strokePath()
        context?.restoreGState()
    }

    private func drawCross(context: CGContext?, rect: CGRect) {
        let bound = rect.insetBy(dx: rect.width/10, dy: rect.height/10)
        context?.saveGState()
        context?.setStrokeColor(foreGroudColor.cgColor)
        context?.setLineWidth(min(bound.width, bound.height)/GameBoardView.CHESS_LINE_WIDTH_FACTOR)
        context?.move(to: CGPoint(x: bound.minX, y: bound.minY))
        context?.addLine(to: CGPoint(x: bound.maxX,y: bound.maxY))
        context?.move(to: CGPoint(x: bound.minX, y: bound.maxY))
        context?.addLine(to: CGPoint(x: bound.maxX,y: bound.minY))
        context?.strokePath()
        context?.restoreGState()
    }

    private func drawBoard(context: CGContext?, rect: CGRect) {
        let lineWidth = getBoardLineWidth(rect: rect)
        context?.saveGState()
        context?.setStrokeColor(foreGroudColor.cgColor)
        context?.setLineWidth(lineWidth)
        let step = rect.maxX/3
        for index in 1 ... 2 {
            context?.move(to: CGPoint(x: step * CGFloat(index) - lineWidth/2, y: rect.minY))
            context?.addLine(to: CGPoint(x: step * CGFloat(index) - lineWidth/2, y: rect.maxY))
            context?.move(to: CGPoint(x: rect.minX, y: step * CGFloat(index) - lineWidth/2))
            context?.addLine(to: CGPoint(x: rect.maxY, y: step * CGFloat(index) - lineWidth/2))
        }
        context?.strokePath()
        context?.restoreGState()
    }

    private func getBoardLineWidth(rect: CGRect) -> CGFloat {
        return min(rect.width, rect.height)/50
    }

    func updateGameBoard(chessBoard: Array<Array<Int>>) {
        if chessBoard.count == GameBoardView.MATRIX_SIZE {
            for (colIdx, row) in chessBoard.enumerated() {
                if row.count == GameBoardView.MATRIX_SIZE {
                    for (index, chess) in row.enumerated() {
                        boardMatrix[colIdx][index] = chess
                    }
                }
            }
        }
        setNeedsDisplay()
    }

    func updateWinner(mode: Int, x: Int, y: Int) {
        self.mode = mode
        startX = x
        startY = y
        setNeedsDisplay()
    }
}
