//
//  Post.swift
//  AnimalKingdom
//
//  Created by Aabeeya on 10/15/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import Foundation

struct Post {
    var userName: String
    var photoUrl: String
    var imageCaption: String
    var animalTag: String
    var dateImageTaken: String
    var locationTag: String
}

extension Post: DocumentSerializable {
    init?(dictionary: [String : Any]) {
        guard let userName = dictionary["userName"] as? String,
            let photoUrl = dictionary["photoUrl"] as? String,
            let imageCaption = dictionary["imageCaption"] as? String,
            let animalTag = dictionary["animalTag"] as? String,
            let dateImageTaken =  dictionary ["date"] as? String,
            let locationTag = dictionary["locationTag"] as? String else { return nil }


        self.init(userName: userName,
                  photoUrl: photoUrl,
                  imageCaption: imageCaption,
                  animalTag: animalTag,
                  dateImageTaken:dateImageTaken,
                  locationTag:locationTag)
    }
}
