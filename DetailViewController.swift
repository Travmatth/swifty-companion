//
//  DetailViewController.swift
//  Swifty-Companion
//
//  Created by Travis Matthews on 2/17/19.
//  Copyright © 2019 Travis Matthews. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var model: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(model?.email)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
