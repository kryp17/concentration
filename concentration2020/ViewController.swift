//
//  ViewController.swift
//  concentration2020
//
//  Created by krupakhar gandeepan on 23/03/20.
//  Copyright © 2020 krupakhar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game:Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int{
            return (cardButtons.count+1)/2
    }
    
    func newTheme(_ count:Int) -> String {
        return themesKeys[ Int(arc4random_uniform(UInt32(count)))]
    }
    
    private(set) var flipCount = 0{
        didSet{
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel(){
        let attributes: [NSAttributedString.Key:Any] = [
                    .strokeWidth: 5.0,
                    .strokeColor: UIColor.orange,
                ]
             let attributedString = NSAttributedString(string: "Flips: \(flipCount)",attributes: attributes)
             FlipCountLabel.attributedText = attributedString
    }
    
   
    @IBAction private func NewGameButton(_ sender: UIButton) {
        game.NewGame()
        updateViewFromModel()
        emoji.removeAll()
        let theme = newTheme(themesKeys.count)
        emojiChoice =  sender.currentTitle! == "NEW GAME" ? emojiChoices[theme]!: emojiChoices[sender.currentTitle!]!
        //FlipCountLabel.text = "Flips: \(game.flipCount)"
        
    }
    
    @IBAction private func TouchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            flipCount += 1
            //FlipCountLabel.text = "Flips: \(game.flipCount)"
            ScoreCard.text = "Score: \(game.score)"
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private var ThemeButtons: [UIButton]!
    
    @IBOutlet private weak var FlipCountLabel: UILabel!{
        didSet{
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private weak var ScoreCard: UILabel!
    
    
    private func updateViewFromModel() {
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
    }
    
    private var emojiChoices = ["Faces": ["😇","😎","🤓","🥳","🥺","🤗"],
                        "Food": ["🍏","🥕","🧅","🌶","🍖","🍕"],
                        "Sports": ["🏓","🏹","⛸","🥋","🥏","🪁"],
                        "animals": ["🐥","🦄","🦇","🦂","🦋","🐌"],
                        "Objects": ["⌚️","📱","💻","☎️","💡","💰"],
                        "Symbols": ["❤️","💟","🔱","🚸","🌀","⚠️"]
    ]
    
    private lazy var themesKeys = Array(emojiChoices.keys)
    
    private lazy var emojiChoice = emojiChoices[newTheme(themesKeys.count)]!
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil , emojiChoice.count > 0{
                emoji[card] = emojiChoice.remove(at: emojiChoice.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
}

extension Int{
    var arc4random: Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
