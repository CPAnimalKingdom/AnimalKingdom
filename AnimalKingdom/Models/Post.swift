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
    var caption: String
}

extension Post: DocumentSerializable {
    init?(dictionary: [String : Any]) {
        guard let userId = dictionary["userId"] as? String,
            let imageUrl = dictionary["imageUrl"] as? URL,
            let caption = dictionary["caption"] as? String else { return nil }

        self.init(userId: userId,
                  imageUrl: imageUrl,
                  caption: caption)
    }
}
