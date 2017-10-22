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

    func populate(post: Post) {
        imageCaption.text = post.imageCaption
        username.text = post.userName

        if let imageURL = NSURL(string: post.photoUrl) {
            if let data = NSData(contentsOf: imageURL as URL) {
                animalImage.image = UIImage(data: data as Data)
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
