//
//  Card.swift
//  concentration2020
//
//  Created by krupakhar gandeepan on 27/03/20.
//  Copyright © 2020 krupakhar. All rights reserved.
//

import Foundation

struct Card: Hashable{
    
//    var hashValue: Int{
//        return identifier
//    }
    
     func hash(into hasher: inout Hasher) {
           hasher.combine(identifier)
       }
    
    static func ==(lhs: Card, rhs: Card) -> Bool{
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
