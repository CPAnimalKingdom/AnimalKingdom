//
//  Animal.swift
//  AnimalKingdom
//
//  Created by Dan on 10/13/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit

class Animal: NSObject {
    var details: [NSDictionary]
    var about: NSDictionary
    //var facts: [NSString]
    //var thumbnailPhoto: NSDictionary

    init(dictionary: NSDictionary) {
        self.details = dictionary["details"] as! [NSDictionary]
        self.about = dictionary["about"] as! NSDictionary
        //self.thumbnailPhoto = dictionary["thumbnailPhoto"] as! NSDictionary
        //self.facts = dictionary["facts"] as! [NSString]
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

