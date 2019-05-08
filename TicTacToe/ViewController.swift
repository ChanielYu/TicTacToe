//
//  ViewController.swift
//  TicTacToe
//
//  Created by Chaniel Yu on 2019/5/6.
//  Copyright © 2019 Chaniel Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GameViewModelDelegate {
    let gameView = GameBoardView()
    private var gameViewModel: GameViewModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(gameView)
        gameView.addGestureRecognizer(UITapGestureRecognizer(target: self ,action: #selector(self.tapAction)))
        view.backgroundColor = UIColor.white
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let square = min(view.bounds.width, view.bounds.height)
        let frame = CGRect(x: 0, y: view.bounds.height / 2 - square / 2, width: square, height: square)
        gameView.frame = frame
        gameViewModel = GameViewModel(boardSize: CGSize(width: frame.width, height: frame.height), matrixSize: GameBoardView.MATRIX_SIZE, delegate: self)
    }

    @objc func tapAction(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let location = sender.location(in: sender.view)
            gameViewModel?.tapHandler(location: location)
        }
    }

    func onGameBoardChange(chessBoard: Array<Array<Int>>) {
        gameView.updateGameBoard(chessBoard: chessBoard)
    }
}

