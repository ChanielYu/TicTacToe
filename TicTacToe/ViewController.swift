//
//  ViewController.swift
//  TicTacToe
//
//  Created by Chaniel Yu on 2019/5/6.
//  Copyright © 2019 Chaniel Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let square = min(view.bounds.width, view.bounds.height)
        let gameView = GameBoardView(frame: CGRect(x: 0, y: 0, width: square, height: square))
        view.addSubview(gameView)
        view.backgroundColor = UIColor.blue
        addChild(GameBoardViewController(nibName: "GameBoardViewController", bundle: nil))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

