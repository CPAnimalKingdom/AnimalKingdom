//
//  Animal.swift
//  AnimalKingdom
//
//  Created by Dan on 10/13/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit

class Animal: NSObject {
    var name: NSDictionary
    var card: NSDictionary
    var about: NSDictionary
    var actions: NSDictionary
    //var facts: [NSString]
    var mainPhoto: NSDictionary
    //var thumbnailPhoto: NSDictionary
    var relativeSize: NSDictionary
    var detailsArray: [NSDictionary]

    init(dictionary: NSDictionary) {
        self.mainPhoto = dictionary["mainPhoto"] as! NSDictionary
        self.name = dictionary["name"] as! NSDictionary
        self.actions = dictionary["actions"] as! NSDictionary
        self.card = dictionary["card"] as! NSDictionary
        //self.thumbnailPhoto = dictionary["thumbnailPhoto"] as! NSDictionary
        self.relativeSize = dictionary["relativeSize"] as! NSDictionary
        self.about = dictionary["about"] as! NSDictionary
        //self.facts = dictionary["facts"] as! [NSString]
        self.detailsArray = [self.mainPhoto, self.name, self.actions, self.card]
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

