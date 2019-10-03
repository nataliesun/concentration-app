//  ViewController.swift
//  Concentration
//
//  Coding as done by Instructor CS193P Michel Deiman on 11/11/2017.
//  Copyright © 2017 Michel Deiman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
	
    
    var themes = [
        ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"],
        ["🤖", "👽", "👾", "🚀", "🛰", "🔭", "🧬", "🥼", "🧪"],
        ["🧀", "🌭", "🥗", "🌮", "🍟", "🌯", "🥞", "🍕", "🍔"]
    ]
	
    @IBAction func touchNewGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        themeIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
        emojiChoices = themes
        updateViewFromModel()
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
	
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
	
	
	@IBAction func touchCard(_ sender: UIButton) {
		if let cardNumber = cardButtons.index(of: sender) {
			game.chooseCard(at: cardNumber)
			updateViewFromModel()

		} else {
			print("choosen card was not in cardButtons")
		}
	}
	
	func updateViewFromModel() {
        let score = game.score
        let flipCount = game.flipCount
        scoreLabel.text = "Score: \(score)"
        flipCountLabel.text = "Flips: \(flipCount)"
		for index in cardButtons.indices {
			let button = cardButtons[index]
			let card = game.cards[index]
			if card.isFaceUp {
				button.setTitle(emoji(for: card), for: UIControlState.normal)
				button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
			} else {
				button.setTitle("", for: UIControlState.normal)
				button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
			}
		}
		
	}
	
	lazy var emojiChoices = themes
    
    var themeIndex: Int = 0
	var emoji = [Int: String]()
	
	func emoji(for card: Card) -> String {
		if emoji[card.identifier] == nil, emojiChoices[themeIndex].count > 0 {
			let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices[themeIndex].count - 1)))
			emoji[card.identifier] = emojiChoices[themeIndex].remove(at: randomIndex)
		}
		return emoji[card.identifier] ?? "?"
	}
}















