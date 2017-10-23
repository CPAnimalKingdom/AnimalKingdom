//
//  Post.swift
//  AnimalKingdom
//
//  Created by Aabeeya on 10/15/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import Foundation

struct Post {
    var userId: String
    var userName: String
    var photoUrl: String
    var imageCaption: String
    var animalTag: String
    var dateImageTaken: String
    var locationTag: String

    func save() {
        db.collection("posts").document().setData([
            "userId": self.userId,
            "userName": self.userName,
            "photoUrl": self.photoUrl,
            "imageCaption": self.imageCaption,
            "animalTag": self.animalTag,
            "date": self.dateImageTaken,
            "locationTag": self.locationTag
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

    }
}

extension Post: DocumentSerializable {
    init?(dictionary: [String : Any]) {
        guard let userId = dictionary["userId"] as? String,
            let userName = dictionary["userName"] as? String,
            let photoUrl = dictionary["photoUrl"] as? String,
            let imageCaption = dictionary["imageCaption"] as? String,
            let animalTag = dictionary["animalTag"] as? String,
            let dateImageTaken =  dictionary ["date"] as? String,
            let locationTag = dictionary["locationTag"] as? String else { return nil }


        self.init(userId: userId,
                  userName: userName,
                  photoUrl: photoUrl,
                  imageCaption: imageCaption,
                  animalTag: animalTag,
                  dateImageTaken:dateImageTaken,
                  locationTag:locationTag)
    }
}
