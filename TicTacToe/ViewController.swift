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
        /*let square = min(view.bounds.width, view.bounds.height)
        let gameView = GameBoardView(frame: CGRect(x: 0, y: view.bounds.height / 2 - square / 2, width: square, height: square))
        view.addSubview(gameView)*/
        let gameController = GameBoardViewController(nibName: nil, bundle: nil)
        addChild(gameController)
        view.addSubview(gameController.view)
        //gameController.didMove(toParent: self)
        view.backgroundColor = UIColor.white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

