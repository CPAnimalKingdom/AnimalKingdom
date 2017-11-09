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
    @IBOutlet var userImage: UIImageView!
    @IBOutlet weak var imageDateTimeStamp: UILabel!
    @IBOutlet weak var locationTag: UILabel!

    var myImage: UIImage? = nil
    var profileImage: UIImage? = nil

    var user: User? = nil

    func populate(post: Post) {
        imageCaption.text = post.imageCaption
        username.text = post.userName
        locationTag.text = post.locationTag
        imageDateTimeStamp.text = post.dateImageTaken

        let docRef = db.collection("users").document(post.userId)

        docRef.getDocument { (document, error) in
            if let document = document {
                if (document.exists) {
                    self.user = User.init(id: post.userId, dictionary: document.data());
                    self.setProfileImage()
                } else {
                    print("Couldn't find user id: " + post.userId)
                }
            } else {
                print("Couldn't find user id: " + post.userId)
            }
        }

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
        userImage.layer.cornerRadius = userImage.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setProfileImage() {
        DispatchQueue.global().async {
            do {
                if let imageURL = NSURL(string: (self.user?.profileImageUrl)!) {
                    if let data = NSData(contentsOf: imageURL as URL) {
                        self.profileImage = UIImage(data: data as Data)
                    }
                }
            }
            DispatchQueue.main.async {
                if self.profileImage != nil {
                    UIView.transition(with: self.userImage,
                                      duration: 0.5,
                                      options: .transitionCrossDissolve,
                                      animations: { self.userImage.image = self.profileImage },
                                      completion: nil)
                }
            }
        }
    }

}
