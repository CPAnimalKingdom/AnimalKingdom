//
//  ProfileCollectionViewCell.swift
//  AnimalKingdom
//
//  Created by Aabeeya on 10/22/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var animalImage: UIImageView!
    override func awakeFromNib() {
        animalImage.layer.cornerRadius = 10
        animalImage.clipsToBounds = true
    }
    
}
