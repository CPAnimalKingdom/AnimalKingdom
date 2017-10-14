//
//  Bundle.swift
//  AnimalKingdom
//
//  Created by Dan on 10/13/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit

class Bundle: NSObject {
    var name: NSString
    var image: NSString
    var animals: [Animal]
    var enabled: Bool
    init(dictionary: NSDictionary) {
        self.name = dictionary["name"] as! NSString
        self.image = dictionary["image"] as! NSString
        self.animals = dictionary["animals"] as! [Animal]
        self.enabled = dictionary["enables"] as! Bool
    }
    
    class func bundleArray(dictionaries: [NSDictionary]) -> [Bundle] {
        var bundles: [Bundle] = []
        
        for dictionary in dictionaries {
            let bundle = Bundle(dictionary: dictionary)
            bundles.append(bundle)
        }
        return bundles
    }
}
