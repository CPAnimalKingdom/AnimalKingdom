//
//  AnimalTableViewCell.swift
//  AnimalKingdom
//
//  Created by Dan on 10/14/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit

class AnimalTableViewCell: UITableViewCell {

    @IBOutlet var animalNameTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
