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
    var imageUrl: URL
    var imageCaption: String
    var animalTag: String
    var dateImageTaken: String
    var locationTag: String
}

extension Post: DocumentSerializable {
    init?(dictionary: [String : Any]) {
        guard let userId = dictionary["userId"] as? String,
            let imageUrl = dictionary["imageUrl"] as? URL,
            let imageCaption = dictionary["caption"] as? String,
            let animalTag = dictionary["animalTag"]  as? String,
            let dateImageTaken =  dictionary ["date"] as? String,
            let locationTag = dictionary["locationTag"] as? String else { return nil }


        self.init(userId: userId,
                  imageUrl: imageUrl,
                  imageCaption: imageCaption,
                  animalTag: animalTag,
                  dateImageTaken:dateImageTaken,
                  locationTag:locationTag)
    }
}
