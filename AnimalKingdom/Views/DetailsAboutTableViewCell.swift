//
//  DetailsAboutTableViewCell.swift
//  AnimalKingdom
//
//  Created by Dan on 12/31/16.
//  Copyright © 2016 Dan. All rights reserved.
//

import UIKit

class DetailsAboutTableViewCell: UITableViewCell {

    @IBOutlet var detailsAboutTitleTextLabel: UILabel!
    @IBOutlet var detailsAboutTextTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
