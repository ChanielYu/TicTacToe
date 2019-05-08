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
    private var boardMatrix = Array(repeating: Array(repeating: 0, count: MATRIX_SIZE), count: MATRIX_SIZE)

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
        let chessRectWidth = rect.width/3
        let chessRectHeight = rect.height/3
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        context?.setFillColor(backGroudColor.cgColor)
        context?.fill(rect)
        drawBoard(context: context, rect: rect)
        drawCircle(context: context, rect: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: chessRectWidth - getBoardLineWidth(rect: rect), height: chessRectHeight - getBoardLineWidth(rect: rect))))
        drawCross(context: context, rect: CGRect(origin: CGPoint(x: chessRectWidth, y: chessRectHeight), size: CGSize(width: chessRectWidth - getBoardLineWidth(rect: rect), height: chessRectHeight - getBoardLineWidth(rect: rect))))
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
            for (rowIdx, row) in chessBoard.enumerated() {
                if row.count == GameBoardView.MATRIX_SIZE {
                    for (index, chess) in row.enumerated() {
                        boardMatrix[rowIdx][index] = chess
                    }
                }
            }
        }
        setNeedsDisplay()
    }
}
