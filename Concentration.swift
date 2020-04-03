//
//  Concentration.swift
//  concentration2020
//
//  Created by krupakhar gandeepan on 27/03/20.
//  Copyright © 2020 krupakhar. All rights reserved.
//

import Foundation

struct Concentration{
    
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get{
            return cards.indices.filter {cards[$0].isFaceUp}.oneAndOnly
//            var foundIndex: Int?
//            for index in cards.indices{
//                if cards[index].isFaceUp{
//                    if foundIndex == nil{
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    
    //var flipCount = 0
    var score = 0
    
    mutating func chooseCard(at index: Int){
        assert(cards.indices.contains(index),"Concentration.chooseCard(at: \(index)): Chosen index not in the cards")
        if !cards[index].isMatched {
            //flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                //check if cards match
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }
                cards[index].isFaceUp = true
            }else{
                //either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }

    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0,"Concentration.init(\(numberOfPairsOfCards)): You must have atleast one pair")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            //cards += [card,card]
            cards.insert(card, at: Int(arc4random_uniform(UInt32(cards.count))))
            cards.insert(card, at: Int(arc4random_uniform(UInt32(cards.count))))
        }
    }
    
    //Reset the Game
     mutating func NewGame() {
         //flipCount = 0
         for index in 0..<cards.count {
             cards[index].isFaceUp = false
             cards[index].isMatched = false
         }
    }
}


extension Collection{
    var oneAndOnly: Element?{
        return count == 1 ? first: nil
    }
}
