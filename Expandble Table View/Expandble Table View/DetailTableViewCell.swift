//
//  DetailTableViewCell.swift
//  Expandble Table View
//
//  Created by abhay singh on 10/02/17.
//  Copyright © 2017 abhay singh. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var teamLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
