//
//  SkillsTableViewCell.swift
//  Swifty-Companion
//
//  Created by Travis Matthews on 2/20/19.
//  Copyright © 2019 Travis Matthews. All rights reserved.
//

import UIKit

class SkillsTableViewCell: UITableViewCell {
    @IBOutlet weak var skillNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
