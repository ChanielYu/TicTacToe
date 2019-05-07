//
//  GameBoardViewController.swift
//  TicTacToe
//
//  Created by Chaniel Yu on 2019/5/6.
//  Copyright © 2019 Chaniel Yu. All rights reserved.
//

import UIKit

class GameBoardViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let square = min(view.bounds.width, view.bounds.height) / 2
        let gameView = GameBoardView(frame: CGRect(x: view.bounds.width / 4, y: view.bounds.height / 4, width: square, height: square))
        view.addSubview(gameView)
    }
}
