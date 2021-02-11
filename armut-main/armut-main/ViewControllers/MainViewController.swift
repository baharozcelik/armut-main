//
//  ViewController.swift
//  armut-main
//
//  Created by Bahar on 10.02.2021.
//

import UIKit

class MainViewController: UIViewController {
    var homeModel = HomeModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        homeModel.requestCocktailData()


        // Do any additional setup after loading the view.
    }


}

