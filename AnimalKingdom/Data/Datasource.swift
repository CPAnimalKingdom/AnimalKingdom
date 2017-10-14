//
//  Datasource.swift
//  AnimalKingdom
//
//  Created by Dan on 10/14/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit

class Datasource: NSObject {

    static let data = Datasource()
    var version: NSString
    var releaseDate: NSString
    var bundleData: [NSDictionary]

    override init() {
        self.version = "1.0"
        self.releaseDate = "10/14/2017"
        self.bundleData =
        [
        [
        "name": "Group 1",
        "image": "imageString",
        "animals":
        [
        [
        "commonName": "Dog",
        "scientificName": "Dogis Draculla",
        "type": "Canine",
        "diet": "Everthing",
        "groupName": "Gang",
        "lifeSpan": "15 years",
        "size": "Heck if I know",
        "weight": "Pass",
        "mainPhoto": "mainPhotoString",
        "thumbnailPhoto": "thumbnailSting",
        "relativeSize": "relSizeImage",
        "about":
        [
        "Section 1":
        [
        "blablabla1",
        "blablabla2",
        "blablabla3"
        ],
        "Section 2":
        [
        "plepleple1", "plepleple2", "plepleple3"
        ]
        ],
        "facts":
        [
        "some fact 1",
        "some fact 2"
        ]
        ],
        [
        "commonName": "Cat",
        "scientificName": "Dogis Draculla",
        "type": "Canine",
        "diet": "Everthing",
        "groupName": "Gang",
        "lifeSpan": "15 years",
        "size": "Heck if I know",
        "weight": "Pass",
        "mainPhoto": "mainPhotoString",
        "thumbnailPhoto": "thumbnailSting",
        "relativeSize": "relSizeImage",
        "about":
        [
        "Section 1":
        [
        "blablabla1",
        "blablabla2",
        "blablabla3"
        ],
        "Section 2":
        [
        "plepleple1", "plepleple2", "plepleple3"
        ]
        ],
        "facts":
        [
        "some fact 1",
        "some fact 2"
        ]
        ]
        ],
        "enabled": true
        ],
        [
        "name": "Group 2",
        "image": "imageString",
        "animals":
        [
        [
        "commonName": "Dog",
        "scientificName": "Dogis Draculla",
        "type": "Canine",
        "diet": "Everthing",
        "groupName": "Gang",
        "lifeSpan": "15 years",
        "size": "Heck if I know",
        "weight": "Pass",
        "mainPhoto": "mainPhotoString",
        "thumbnailPhoto": "thumbnailSting",
        "relativeSize": "relSizeImage",
        "about":
        [
        "Section 1":
        [
        "blablabla1",
        "blablabla2",
        "blablabla3"
        ],
        "Section 2":
        [
        "plepleple1", "plepleple2", "plepleple3"
        ]
        ],
        "facts":
        [
        "some fact 1",
        "some fact 2"
        ]
        ],
        [
        "commonName": "Cat",
        "scientificName": "Dogis Draculla",
        "type": "Canine",
        "diet": "Everthing",
        "groupName": "Gang",
        "lifeSpan": "15 years",
        "size": "Heck if I know",
        "weight": "Pass",
        "mainPhoto": "mainPhotoString",
        "thumbnailPhoto": "thumbnailSting",
        "relativeSize": "relSizeImage",
        "about":
        [
        "Section 1":
        [
        "blablabla1",
        "blablabla2",
        "blablabla3"
        ],
        "Section 2":
        [
        "plepleple1", "plepleple2", "plepleple3"
        ]
        ],
        "facts":
        [
        "some fact 1",
        "some fact 2"
        ]
        ]
        ],
        "enabled": true
        ]
        ]
        
    }
    func getData()
    {
        let appBundle: [Bundle] = Bundle.bundleArray(dictionaries: bundleData)
        print(appBundle)
    }
}
