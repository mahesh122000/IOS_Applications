//
//  CardMode.swift
//  MatchCardGame
//
//  Created by Mahesh Pondugula on 19/06/20.
//  Copyright © 2020 Mahesh Pondugula. All rights reserved.
//

import Foundation

class CardModel {
    
    var generatedCardsArray = [Card]()
    
    //array for checking no repetition
    var generatedNumbersArray = [Int]()
    
    func getCards() -> [Card] {
        
        //intialising array with unique pairs of cards
        while generatedNumbersArray.count < 8 {
            
            let randomNumber = arc4random_uniform(13) + 1
            
            if generatedNumbersArray.contains(Int(randomNumber)) == false {
                
                let card1 = Card()
                card1.imageName = "card\(randomNumber)"
                
                generatedCardsArray.append(card1)
                
                generatedNumbersArray.append(Int(randomNumber))
                
                let card2 = Card()
                card2.imageName = "card\(randomNumber)"
                
                generatedCardsArray.append(card2)
                
            }

        }
        
        //randomize the pair of cards
        for i in 0...generatedCardsArray.count-1 {
            
            //swap the cards
            let randomNUmber = arc4random_uniform(UInt32(generatedCardsArray.count))
            let tempStore = generatedCardsArray[i]
            generatedCardsArray[i] = generatedCardsArray[Int(randomNUmber)]
            generatedCardsArray[Int(randomNUmber)] = tempStore
            
        }
        
        
    return generatedCardsArray
    }
}
