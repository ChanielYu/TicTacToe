//
//  GameBoardViewModel.swift
//  TicTacToe
//
//  Created by Chaniel Yu on 2019/5/8.
//  Copyright © 2019 Chaniel Yu. All rights reserved.
//

import UIKit

class GameViewModel {
    private let chessSize: CGSize
    private let inset: CGFloat
    private var chessMatrix = Array<Array<CGRect>>()
    private var boardMatrix = Array(repeating: Array(repeating: 0, count: GameBoardView.MATRIX_SIZE), count: GameBoardView.MATRIX_SIZE)
    private let gameBoardDelegate: GameViewModelDelegate
    private var playerCircle = true

    required init(boardSize: CGSize, matrixSize: Int, delegate: GameViewModelDelegate) {
        gameBoardDelegate = delegate
        chessSize = CGSize(width: boardSize.width/CGFloat(matrixSize), height: boardSize.height/CGFloat(matrixSize))
        inset = min(boardSize.width, boardSize.height)/CGFloat(matrixSize)/CGFloat(8)
        let len = GameBoardView.MATRIX_SIZE-1
        for colInx in 0...len {
            var row = Array<CGRect>()
            for rectInx in 0...len {
                row.append(CGRect(origin: CGPoint(x: chessSize.width*CGFloat(rectInx),y: chessSize.height*CGFloat(colInx)), size: CGSize(width: chessSize.width,height: chessSize.height)).insetBy(dx: inset, dy: inset))
            }
            chessMatrix.append(row)
        }
    }

    func tapHandler(location: CGPoint) {
        root:
        for (y, row) in chessMatrix.enumerated() {
            for (x, rect) in row.enumerated() {
                if rect.contains(location) && boardMatrix[y][x]==0 {
                    if playerCircle {
                        boardMatrix[y][x] = 1
                        playerCircle = false
                    } else {
                        boardMatrix[y][x] = 2
                        playerCircle = true
                    }
                    gameBoardDelegate.onGameBoardChange(chessBoard: boardMatrix)
                    break root
                }
            }
        }
    }
}
