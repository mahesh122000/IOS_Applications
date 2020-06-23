//
//  ViewController.swift
//  MatchCardGame
//
//  Created by Mahesh Pondugula on 19/06/20.
//  Copyright © 2020 Mahesh Pondugula. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstFlippedCardIndex: IndexPath?
    
    var timer:Timer?
    var milliseconds:Float = 30 * 1000 //10 seconds
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cardArray = model.getCards()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //create timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        SoundManager.playSound(.shuffle)
        
    }
    
    //timer method
    @objc func timerElapsed() {
        
        milliseconds -= 1
        
        //convert to seconds
        let seconds = String(format: "%.2f", milliseconds/1000)
        
        timerLabel.text = "Time Remaining: \(seconds)"
        
        if milliseconds <= 0 {
            
            //stop the timer
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
            
            //check if all cards are matched
            checkGameEnded()
        }
        
    }

    //Mark: - Protocol methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cardArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardsCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        cell.setCard(card)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //check if there is any time left
        if milliseconds <= 0 {
            return 
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as! CardsCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false && card.isMatched == false{
            //flip the card
            cell.flip()
            
            // play the flip sound
            SoundManager.playSound(.flip)
            
            card.isFlipped = true
            
            //detrmine if its first or second
            if firstFlippedCardIndex == nil {
                
                firstFlippedCardIndex = indexPath
            
            }
            else {
                
                checkForMatches(indexPath)
                
            }
            
        }
        
        
    }
    
    func checkForMatches(_ secondFlippedCardIndex:IndexPath) {
        
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardsCollectionViewCell
        
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardsCollectionViewCell
        
        let card1 = cardArray[firstFlippedCardIndex!.row]
        let card2 = cardArray[secondFlippedCardIndex.row]
        
        //compare cards
        if card1.imageName == card2.imageName {
            
            //matched
            
            //play match sound
            SoundManager.playSound(.match)
            
            //set the statuses of the cards
            card1.isMatched = true
            card2.isMatched = true
            
            //remove the cards
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            //check if any cards unmatched
            checkGameEnded()
        }
        else {
            
            //not matched
            
            //play not matched sound
            SoundManager.playSound(.nomatch)
            
            
            card1.isMatched = false
            card2.isMatched = false
            card1.isFlipped = false
            card2.isFlipped = false
            //flip back
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
            
        }
        
        //tell the collection view to relode the cell of first card if it is mil
        if cardOneCell == nil {
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
        }
        
        // reset the property that tracks the first card flipped
        firstFlippedCardIndex = nil
    
    }
    
    func checkGameEnded() {
        
        //determone if there are any cards unmatched
        var isWon = true
        
        for card in cardArray {
            
            if card.isMatched == false {
                isWon = false
                break
            }
        }
        //Messaging variables
        var title = ""
        var message = ""
        
        //if not, then user won, stop timer
        if isWon == true {
            
            if milliseconds > 0 {
                timer?.invalidate()
            }
            
            title = "Congratulations!"
            message = "You've Won"
        }
        else {
            //if cards are left , check if times left
            if milliseconds > 0 {
                return
            }
            
            title = "Game Over"
            message = "You've Lost"
        }
        
        
        //show won or lost
        showAlert(title, message)
        
        
    }
    
    func showAlert(_ title:String, _ message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
}

