//
//  Concentration.swift
//  Lecture 2 - Concentration
//
//  Created by Michel Deiman on 13/11/2017.
//  Copyright © 2017 Michel Deiman. All rights reserved.
//

import Foundation

class Concentration {
	
	var cards = [Card]()
    var score = 0
    var flipCount = 0
	var indexOfOneAndOnlyFaceUpCard: Int?
    
	func chooseCard(at index: Int) {
        if(!cards[index].isFaceUp) {
            flipCount += 1
        }
        
		if !cards[index].isMatched {
			if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
				// check if cards match
				if cards[matchIndex].identifier == cards[index].identifier {

					cards[matchIndex].isMatched = true
					cards[index].isMatched = true
                    score += 2
                } else {
                    if cards[matchIndex].seenBefore {
                        score -= 1
                    }
                    if cards[index].seenBefore {
                        score -= 1
                    }
                }
				cards[index].isFaceUp = true
				indexOfOneAndOnlyFaceUpCard = nil	// not one and only ...
			} else {
				for flipdownIndex in cards.indices {
                    if cards[flipdownIndex].isFaceUp {
                        cards[flipdownIndex].seenBefore = true
                    }
					cards[flipdownIndex].isFaceUp = false
				}
				cards[index].isFaceUp = true
				indexOfOneAndOnlyFaceUpCard = index
			}
			
		}
       


	}
	
	init(numberOfPairsOfCards: Int) {
		for _ in 1...numberOfPairsOfCards {
			let card = Card()
			cards += [card, card]
		}
        cards.shuffle()
	}
	
}
