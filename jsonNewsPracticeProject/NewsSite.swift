//
//  NewsSite.swift
//  jsonNewsPracticeProject
//
//  Created by Dylan Robson on 9/5/16.
//  Copyright © 2016 Dylan Robson. All rights reserved.
//

import UIKit

class NewsSite: NSObject {
    var nameOfSite: String
    var subscribed: Bool
    
    init(nameOfSite: String, subscribed: String) {
        self.nameOfSite = nameOfSite
        self.subscribed = false
    }
}
