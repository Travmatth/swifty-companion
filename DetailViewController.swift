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
    var profileImage: UIImage!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var walletLabel: UILabel!
    @IBOutlet weak var skillsTableView: UITableView!
    @IBOutlet weak var projectsTableView: UITableView!
    
    @IBAction func backButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        configureLabels()
        configureProfileImage()
        self.skillsTableView.dataSource = self
        self.projectsTableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }

    func configureLabels() {
        levelLabel.text = parseLevel(model: model)
        loginLabel.text = model?.login != nil ? model?.login! : "Unavaible";
        mobileLabel.text = model?.phone != nil
            ? "Phone: \(model!.phone!)" : "Unavaible";
        pointsLabel.text = model?.correctionPoint != nil
            ? "Points: \(model!.correctionPoint!)" : "Unavaible";
        emailLabel.text = model?.email != nil
            ? "Email: \(model!.email!)" : "Unavaible";
        walletLabel.text = model?.wallet != nil
            ? "Wallet: \(model!.wallet!)" : "Unavaible";
        //levelLabel.sizeToFit()
        //loginLabel.sizeToFit()
        //mobileLabel.sizeToFit()
        //pointsLabel.sizeToFit()
        //emailLabel.sizeToFit()
        //walletLabel.sizeToFit()
        //emailLabel.center.x = self.view.center.x
        //mobileLabel.center.x = self.view.center.x
    }
    
    func configureProfileImage() {
        profileImageView.image = profileImage
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.black.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.clipsToBounds = true
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == skillsTableView {
            for cursus in model!.cursusUsers! {
                if cursus.cursus!.name! == "42" {
                    return cursus.skills!.count
                }
            }
        }
        return model!.projectsUsers!.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == skillsTableView {
            for cursus in model!.cursusUsers! {
                if cursus.cursus!.name! == "42" {
                    let level = String(describing: (cursus.skills![indexPath.row].level)!)
                    let cell = skillsTableView.dequeueReusableCell(withIdentifier: "skillsTableViewCell") as! SkillsTableViewCell
                    cell.skillNameLabel.text = cursus.skills![indexPath.row].name!
                    cell.skillLevelLabel.text = level
                    cell.skillNameLabel.sizeToFit()
                    cell.skillLevelLabel.sizeToFit()
                    return cell
                }
            }
        }
        let score = String(describing: (model?.projectsUsers![indexPath.row].finalMark) ?? 0)
        let cell = projectsTableView.dequeueReusableCell(withIdentifier: "projectsTableViewCell") as! ProjectsTableViewCell
        cell.projectNameLabel.text = model?.projectsUsers![indexPath.row].project!.name!
        cell.projectScoreLabel.text = score
        cell.projectNameLabel.sizeToFit()
        cell.projectScoreLabel.sizeToFit()
        return cell
    }
}
