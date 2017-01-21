//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by doohwan Lee on 2017. 1. 18..
//  Copyright © 2017년 doohwan Lee. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var bottomText: UILabel!
    @IBOutlet weak var imageText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
