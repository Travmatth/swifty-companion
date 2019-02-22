//
//  ViewController.swift
//  Swifty-Companion
//
//  Created by Travis Matthews on 2/17/19.
//  Copyright © 2019 Travis Matthews. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var errorMsg: String?
    let session = Session()
    @IBOutlet weak var loginTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        session.startOAuthFlow()
        print(session.token!)
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
            let vc = storyboard.instantiateViewController(withIdentifier: "DetailView")
            session.getUser(user: userData.trimmingCharacters(in: .whitespacesAndNewlines)) { (model, image, err) in
                guard err == nil else {
                    self.errorMsg = err
                    return
                }
                (vc as! DetailViewController).model = model
                (vc as! DetailViewController).profileImage = image
            }
            if errorMsg != nil {
                let vc2 = storyboard.instantiateViewController(withIdentifier: "ErrorView")
                (vc2 as! ErrorViewController).errorMsg = errorMsg!
                self.present(vc2, animated: true, completion: nil)
                return
            }
            self.present(vc, animated: true, completion: nil)
        } else {
            print("Error: text field empty")
        }
    }
}
