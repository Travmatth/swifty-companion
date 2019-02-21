//
//  ViewController.swift
//  Swifty-Companion
//
//  Created by Travis Matthews on 2/17/19.
//  Copyright © 2019 Travis Matthews. All rights reserved.
//

import UIKit

// shara data between view controllers
// https://learnappmaking.com/pass-data-between-view-controllers-swift-how-to/

class ViewController: UIViewController {
    let session = Session()
    @IBOutlet weak var loginTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        session.startOAuthFlow()
    }

    override func viewDidAppear(_ animated: Bool) {
        if (session.token == nil) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ErrorView")
            present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func lookupButton(_ sender: Any) {
        if let userData = loginTextField.text {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
            session.getUser(user: userData) { (model, image) in
                vc.model = model
                vc.profileImage = image
            }
            present(vc, animated: true, completion: nil)

        } else {
            print("Error: text field empty")
        }
    }
}
