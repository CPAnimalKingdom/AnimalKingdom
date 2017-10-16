//
//  User.swift
//  AnimalKingdom
//
//  Created by Aabeeya on 10/15/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import Foundation
import FirebaseFirestore

var db = Firestore.firestore()

struct User {
    var id: String
    var name: String
    var profileImageUrl: String

    func save() {
        db.collection("users").document(self.id).setData([
            "name": self.name,
            "profileImageUrl": self.profileImageUrl
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }

    }
}

extension User: DocumentSerializable {
    init?(dictionary: [String : Any]) {
        guard let id = dictionary["id"] as? String,
            let name = dictionary["name"] as? String,
            let profileImageUrl = dictionary["profileImageUrl"] as? String else { return nil }

        self.init(id: id, name: name, profileImageUrl: profileImageUrl)
    }
}
