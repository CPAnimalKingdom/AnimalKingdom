//
//  DetailsActionsPanelTableViewCell.swift
//  AnimalKingdom
//
//  Created by Dan on 10/19/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit

class DetailsActionsPanelTableViewCell: UITableViewCell {

    
    @IBOutlet var ShowSoundButton: UIButton!
    @IBOutlet var ShowVideoButton: UIButton!
    @IBOutlet var ShowCreatorButton: UIButton!
    @IBOutlet var ShowARButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
