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
                    "image": "imageString",
                    "animals":
                        [
                            [
                                "details":
                                    [
                                        ["mainPhoto": "african-elephant-main.jpg"],
                                        ["displayName": "THE AFRICAN ELEPHANT"],
                                        ["actions": "xxx"],
                                        ["COMMON NAME": "African Elephant"],
                                        ["SCIENTIFIC NAME": "Loxodonta Africana"],
                                        ["TYPE": "Mammals"],
                                        ["DIET": "Herbivores"],
                                        ["GROUP NAME": "Herd"],
                                        ["AVERAGE LIFESPAN": "Up to 70 years"],
                                        ["SIZE": "Height at the shoulder, 8.2 to 13 ft"],
                                        ["WEIGHT": "2.5 to 7 tons"],
                                        ["RELATIVE SIZE TO A 6-FT HUMAN": "african-elephant-main.jpg"],
                                        ["Section 1": "blablabla blablabla1blablabla1 blablabla1 blablabla1 blablabla1blablabla1blablabla1 blablabla1 blablabla1"]
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
                ]
        ]
    }
    
}


