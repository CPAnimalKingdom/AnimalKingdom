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
                    "name": "Africa Savannas",
                    "image": "african-savanna",
                    "animals":
                        [
                            [
                                "details":
                                    [
                                        ["photo": "baboon"],
                                        ["displayName": "THE BABOON"],
                                        ["actions": "xxx"]
                                        //["COMMON NAME": "African Elephant"],
                                        //["SCIENTIFIC NAME": "Loxodonta Africana"],
                                        //["TYPE": "Mammals"],
                                        //["DIET": "Herbivores"],
                                        //["GROUP NAME": "Herd"],
                                        //["AVERAGE LIFESPAN": "Up to 70 years"],
                                        //["SIZE": "Height at the shoulder, 8.2 to 13 ft"],
                                        //["WEIGHT": "2.5 to 7 tons"],
                                        //["RELATIVE SIZE TO A 6-FT HUMAN": "african-elephant-main.jpg"]
                                ],
                                "facts":
                                    [
                                        "some fact 1",
                                        "some fact 2"
                                ],
                                "vr": true,
                                "videos": true,
                                "360": true,
                            ],
                            [
                                "details":
                                    [
                                        ["photo": "cheetah"],
                                        ["displayName": "THE CHEETAH"],
                                        ["actions": "xxx"]
                                        //["COMMON NAME": "African Elephant"],
                                        //["SCIENTIFIC NAME": "Loxodonta Africana"],
                                        //["TYPE": "Mammals"],
                                        //["DIET": "Herbivores"],
                                        //["GROUP NAME": "Herd"],
                                        //["AVERAGE LIFESPAN": "Up to 70 years"],
                                        //["SIZE": "Height at the shoulder, 8.2 to 13 ft"],
                                        //["WEIGHT": "2.5 to 7 tons"],
                                        //["RELATIVE SIZE TO A 6-FT HUMAN": "african-elephant-main.jpg"]
                                ],
                                "facts":
                                    [
                                        "some fact 1",
                                        "some fact 2"
                                ],
                                "vr": true,
                                "videos": true,
                                "360": true,
                                ],
                            [
                                "details":
                                    [
                                        ["photo": "african-elephant"],
                                        ["displayName": "THE AFRICAN ELEPHANT"],
                                        ["actions": "xxx"]
                                        //["COMMON NAME": "African Elephant"],
                                        //["SCIENTIFIC NAME": "Loxodonta Africana"],
                                        //["TYPE": "Mammals"],
                                        //["DIET": "Herbivores"],
                                        //["GROUP NAME": "Herd"],
                                        //["AVERAGE LIFESPAN": "Up to 70 years"],
                                        //["SIZE": "Height at the shoulder, 8.2 to 13 ft"],
                                        //["WEIGHT": "2.5 to 7 tons"],
                                        //["RELATIVE SIZE TO A 6-FT HUMAN": "african-elephant-main.jpg"]
                                ],
                                "facts":
                                    [
                                        "some fact 1",
                                        "some fact 2"
                                ],
                                "vr": true,
                                "videos": true,
                                "360": true,
                                ],
                            [
                                "details":
                                    [
                                        ["photo": "flying-snake"],
                                        ["displayName": "THE FLYING SNAKE"],
                                        ["actions": "xxx"]
                                        //["COMMON NAME": "African Elephant"],
                                        //["SCIENTIFIC NAME": "Loxodonta Africana"],
                                        //["TYPE": "Mammals"],
                                        //["DIET": "Herbivores"],
                                        //["GROUP NAME": "Herd"],
                                        //["AVERAGE LIFESPAN": "Up to 70 years"],
                                        //["SIZE": "Height at the shoulder, 8.2 to 13 ft"],
                                        //["WEIGHT": "2.5 to 7 tons"],
                                        //["RELATIVE SIZE TO A 6-FT HUMAN": "african-elephant-main.jpg"]
                                ],
                                "facts":
                                    [
                                        "some fact 1",
                                        "some fact 2"
                                ],
                                "vr": true,
                                "videos": true,
                                "360": true,
                                ],
                            [
                                "details":
                                    [
                                        ["photo": "tiger"],
                                        ["displayName": "THE TIGER"],
                                        ["actions": "xxx"]
                                        //["COMMON NAME": "African Elephant"],
                                        //["SCIENTIFIC NAME": "Loxodonta Africana"],
                                        //["TYPE": "Mammals"],
                                        //["DIET": "Herbivores"],
                                        //["GROUP NAME": "Herd"],
                                        //["AVERAGE LIFESPAN": "Up to 70 years"],
                                        //["SIZE": "Height at the shoulder, 8.2 to 13 ft"],
                                        //["WEIGHT": "2.5 to 7 tons"],
                                        //["RELATIVE SIZE TO A 6-FT HUMAN": "african-elephant-main.jpg"]
                                ],
                                "facts":
                                    [
                                        "some fact 1",
                                        "some fact 2"
                                ],
                                "vr": true,
                                "videos": true,
                                "360": true,
                                ],
                            [
                                "details":
                                    [
                                        ["photo": "zebra"],
                                        ["displayName": "THE ZEBRA"],
                                        ["actions": "xxx"]
                                        //["COMMON NAME": "African Elephant"],
                                        //["SCIENTIFIC NAME": "Loxodonta Africana"],
                                        //["TYPE": "Mammals"],
                                        //["DIET": "Herbivores"],
                                        //["GROUP NAME": "Herd"],
                                        //["AVERAGE LIFESPAN": "Up to 70 years"],
                                        //["SIZE": "Height at the shoulder, 8.2 to 13 ft"],
                                        //["WEIGHT": "2.5 to 7 tons"],
                                        //["RELATIVE SIZE TO A 6-FT HUMAN": "african-elephant-main.jpg"]
                                ],
                                "facts":
                                    [
                                        "some fact 1",
                                        "some fact 2"
                                ],
                                "vr": true,
                                "videos": true,
                                "360": true,
                                ]
                    ],
                    "enabled": true
                ],
                [
                    "name": "Arctic Animals",
                    "image": "arctic-animals-image",
                    "animals":
                        [
                    ],
                    "enabled": true
                ],
                [
                    "name": "Deep Sea Creatures",
                    "image": "deep-sea-creatures-image",
                    "animals":
                        [
                    ],
                    "enabled": true
                ],
                [
                    "name": "Farm Animals",
                    "image": "farm-animals-image",
                    "animals":
                        [
                    ],
                    "enabled": true
                ],
                [
                    "name": "Rare Birds",
                    "image": "rare-birds-image",
                    "animals":
                        [
                    ],
                    "enabled": true
                ],
                [
                    "name": "Add New",
                    "image": "add-bundle-image",
                    "animals":
                        [
                    ],
                    "enabled": true
                ],
                [
                    "name": "Add New",
                    "image": "add-bundle-image",
                    "animals":
                        [
                    ],
                    "enabled": true
                ],
                [
                    "name": "Add New",
                    "image": "add-bundle-image",
                    "animals":
                        [
                    ],
                    "enabled": true
                ],
                [
                    "name": "Add New",
                    "image": "add-bundle-image",
                    "animals":
                        [
                    ],
                    "enabled": true
                ],
                [
                    "name": "Add New",
                    "image": "add-bundle-image",
                    "animals":
                        [
                    ],
                    "enabled": true
                ],
                [
                    "name": "Add New",
                    "image": "add-bundle-image",
                    "animals":
                        [
                    ],
                    "enabled": true
                ],
                [
                    "name": "Add New",
                    "image": "add-bundle-image",
                    "animals":
                        [
                    ],
                    "enabled": true
                ],
                [
                    "name": "Add New",
                    "image": "add-bundle-image",
                    "animals":
                        [
                    ],
                    "enabled": true
                ]
        ]
    }
    
}


