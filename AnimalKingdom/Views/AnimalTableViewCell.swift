//
//  AnimalTableViewCell.swift
//  AnimalKingdom
//
//  Created by Dan on 10/14/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit

class AnimalTableViewCell: UITableViewCell {

    @IBOutlet var animalImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        animalImageView.layer.cornerRadius = 10
        animalImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
