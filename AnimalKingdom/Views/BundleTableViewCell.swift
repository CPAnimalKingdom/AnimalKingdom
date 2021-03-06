//
//  GroupTableViewCell.swift
//  AnimalKingdom
//
//  Created by Dan on 10/14/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit

class BundleTableViewCell: UITableViewCell {
    
    @IBOutlet var bundleImageView: UIImageView!
    @IBOutlet var bundleNameTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        bundleImageView.layer.cornerRadius = 10
        bundleImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
