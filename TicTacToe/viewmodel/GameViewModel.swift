//
//  GameBoardViewModel.swift
//  TicTacToe
//
//  Created by Chaniel Yu on 2019/5/8.
//  Copyright © 2019 Chaniel Yu. All rights reserved.
//

import UIKit

class GameViewModel {
    private let WIN_THRESHOLD = 3
    private let chessSize: CGSize
    private let inset: CGFloat
    private var chessMatrix = Array<Array<CGRect>>()
    private var boardMatrix = Array(repeating: Array(repeating: 0, count: GameBoardView.MATRIX_SIZE), count: GameBoardView.MATRIX_SIZE)
    private let gameBoardDelegate: GameViewModelDelegate
    private var playerCircle = true
    private var winner = 0
    private var startPos = 0
    private var winningMode = 0 // 0->horizontal 1->vertical 2->slash 3->reverse slash
    private var round = 0

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

    private func checkResult(x: Int, y: Int) {
        let upperBound = GameBoardView.MATRIX_SIZE-1
        let checkOffset = WIN_THRESHOLD-1
        // Check row
        let row = boardMatrix[y]
        var result = checkWinner(candidate: row)
        winner = result[0]
        startPos = result[1]
        winningMode = 0
        if winner != 0 {
            return
        }
        var candidate = Array<Int>()
        let startY = y-checkOffset < 0 ? 0 : y-checkOffset
        let endY = y+checkOffset > upperBound ? upperBound : y+checkOffset
        // Check column
        for idx in startY...endY {
            candidate.append(boardMatrix[idx][x])
        }
        result = checkWinner(candidate: candidate)
        winner = result[0]
        startPos = result[1]
        winningMode = 1
        if winner != 0 {
            return
        }
        // Check diagonal
        candidate.removeAll()
        let minStart = min(x, y)
        let start = minStart-checkOffset < 0 ? 0 : minStart-checkOffset
        let end = minStart+checkOffset > upperBound ? upperBound : minStart+checkOffset
        for idx in start...end {
            candidate.append(boardMatrix[idx][idx])
        }
        result = checkWinner(candidate: candidate)
        winner = result[0]
        startPos = result[1]
        winningMode = 2
        if winner != 0 {
            return
        }
        candidate.removeAll()
        for idx in start...end {
            candidate.append(boardMatrix[idx][end - idx])
        }
        result = checkWinner(candidate: candidate)
        winner = result[0]
        startPos = result[1]
        winningMode = 3
    }

    private func checkWinner(candidate: Array<Int>) -> Array<Int> {
        var winningPlayer = 0
        var pos = 0
        var circle = 0
        var cross = 0
        var last = 0
        for (idx, chess) in candidate.enumerated() {
            switch chess {
            case 1:
                if last == 1 {
                    circle += 1
                } else {
                    circle = 1
                    pos = idx
                }
                last = 1
                if circle >= WIN_THRESHOLD {
                    winningPlayer = 1
                }
                break
            case 2:
                if last == 2 {
                    cross += 1
                } else {
                    cross = 1
                    pos = idx
                }
                last = 2
                if cross >= WIN_THRESHOLD {
                    winningPlayer = 2
                }
            default:
                circle = 0
                cross = 0
                last = 0
                break
            }
            if circle >= WIN_THRESHOLD || cross >= WIN_THRESHOLD {
                break
            }
        }
        return [winningPlayer, pos]
    }

    private func mayGotWinner() {
        if winner != 0 || round >= GameBoardView.MATRIX_SIZE*GameBoardView.MATRIX_SIZE {
            boardMatrix = Array(repeating: Array(repeating: 0, count: GameBoardView.MATRIX_SIZE), count: GameBoardView.MATRIX_SIZE)
            gameBoardDelegate.onGameBoardChange(chessBoard: boardMatrix)
            round = 0
            print(winner, startPos, winningMode)
        }
        winner = 0
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
                    checkResult(x: x, y: y)
                    round+=1
                    break root
                }
            }
        }
        mayGotWinner()
    }
}
