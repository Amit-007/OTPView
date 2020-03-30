//
//  ViewController.swift
//  OTPViewExampleProject
//
//  Created by Majumdar, Amit on 30/03/20.
//  Copyright © 2020 Stride[247]. All rights reserved.
//

import UIKit
import OTPView

class ViewController: UIViewController {

    @IBOutlet weak var otpView: OTPView!
    override func viewDidLoad() {
        super.viewDidLoad()
        otpView.numberOfDigits = 5
        otpView.borderWidth = 0.5
        // Do any additional setup after loading the view.
    }


}

