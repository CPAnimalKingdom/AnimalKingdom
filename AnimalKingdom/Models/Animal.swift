//
//  Animal.swift
//  AnimalKingdom
//
//  Created by Dan on 10/13/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit

class Animal: NSObject {
    var commonName: NSString
    var scientificName: NSString
    var type: NSString
    var diet: NSString
    var groupName: NSString
    var lifeSpan: NSString
    var size: NSString
    var weight: NSString
    var mainPhoto: NSString
    var thumbnailPhoto: NSString
    var relativeSize: NSString
    var about: NSDictionary
    var facts: [NSString]

    init(dictionary: NSDictionary) {
        self.commonName = dictionary["commonName"] as! NSString
        self.scientificName = dictionary["scientificName"] as! NSString
        self.type = dictionary["type"] as! NSString
        self.diet = dictionary["diet"]  as! NSString
        self.groupName = dictionary["groupName"] as! NSString
        self.lifeSpan = dictionary["lifeSpan"] as! NSString
        self.size = dictionary["size"] as! NSString
        self.weight = dictionary["weight"] as! NSString
        self.mainPhoto = dictionary["mainPhoto"] as! NSString
        self.thumbnailPhoto = dictionary["thumbnailPhoto"] as! NSString
        self.relativeSize = dictionary["relativeSize"] as! NSString
        self.about = dictionary["about"] as! NSDictionary
        self.facts = dictionary["facts"] as! [NSString]
    }
    
    class func animalArray(dictionaries: [NSDictionary]) -> [Animal] {
        var animals: [Animal] = []
        
        for dictionary in dictionaries {
            let animal = Animal(dictionary: dictionary)
            animals.append(animal)
        }
        return animals
    }

}
