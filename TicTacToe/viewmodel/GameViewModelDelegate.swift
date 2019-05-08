//
//  GameViewModelDelegate.swift
//  TicTacToe
//
//  Created by Yu, Chaniel on 5/9/19.
//  Copyright © 2019 Chaniel Yu. All rights reserved.
//

import Foundation

protocol GameViewModelDelegate {
    func onGameBoardChange(chessBoard: Array<Array<Int>>)
}
