//
//  PhotoFeedCell.swift
//  AnimalKingdom
//
//  Created by Aabeeya on 10/20/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit

class PhotoFeedCell: UITableViewCell {

    @IBOutlet weak var animalImage: UIImageView!

    @IBOutlet weak var imageCaption: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var imageDateTimeStamp: UILabel!
    @IBOutlet weak var locationTag: UILabel!


    var myImage: UIImage? = nil
    func populate(post: Post) {
        imageCaption.text = post.imageCaption
        username.text = post.userName
        locationTag.text = post.locationTag
        imageDateTimeStamp.text = post.dateImageTaken

        self.animalImage.image = UIImage(named: "defaultPictureIcon")
        DispatchQueue.global().async {
            do {
                if let imageURL = NSURL(string: post.photoUrl) {
                    if let data = NSData(contentsOf: imageURL as URL) {
                    self.myImage = UIImage(data: data as Data)
                    }
                }
            }
            DispatchQueue.main.async {
                if self.myImage != nil {
                    UIView.transition(with: self.animalImage,
                                      duration: 0.5,
                                      options: .transitionCrossDissolve,
                                      animations: { self.animalImage.image = self.myImage },
                                      completion: nil)
                }
            }
        }

    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
