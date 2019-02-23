//
//  ErrorViewController.swift
//  Swifty-Companion
//
//  Created by Travis Matthews on 2/18/19.
//  Copyright © 2019 Travis Matthews. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {
    var errorMsg: String = "Error"
    @IBOutlet weak var errorLabel: UILabel!

    @IBAction func backButton(_ sender: Any) {
        (self.presentingViewController as! ViewController).errorMsg = nil
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        errorLabel.text = errorMsg
        errorLabel.sizeToFit()
        errorLabel.center.x = self.view.center.x
    }
}
