//
//  ViewController.swift
//  armut-main
//
//  Created by Bahar on 10.02.2021.
//

import UIKit
import RxCocoa
import RxSwift


class MainViewController: UIViewController {
    
    @IBOutlet weak var ServicesVCView: UIView!
    var mainviewmodel = MainViewModel()

    override func viewDidLoad() {
    super.viewDidLoad()
        
    mainviewmodel.requestServicesData() //veriler çekilir.


        // Do any additional setup after loading the view.
    }


}

