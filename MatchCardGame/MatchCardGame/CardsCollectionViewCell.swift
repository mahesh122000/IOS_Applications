//
//  CardsCollectionViewCell.swift
//  MatchCardGame
//
//  Created by Mahesh Pondugula on 19/06/20.
//  Copyright © 2020 Mahesh Pondugula. All rights reserved.
//

import UIKit

class CardsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card:Card?
    
    func setCard(_ card:Card) {
        //keep track of card that gets passed in.
        self.card = card
        
        if card.isMatched == true {
            //if the card is matched make image views invisible
            backImageView.alpha = 0
            frontImageView.alpha = 0
            return
        
        }
        else {
            //if the card is not matched make image views visible
            backImageView.alpha = 1
            frontImageView.alpha = 1
            
        }
        
        frontImageView.image = UIImage(named: card.imageName)
        
        //Determine if the card is flipped upstate or downstate
        if card.isFlipped == true {
            //make sure the frontimageview is on top
            UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }
        else {
            //make sure the backimageview is on top
            UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.showHideTransitionViews, .transitionFlipFromRight], completion: nil)
        }
    }
    
    func flip() {
        
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft,.showHideTransitionViews], completion: nil)
        
    }
    
    func flipBack() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
            
        }
        
    }
    
    func remove() {
        
        backImageView.alpha = 0
        //Animate it
        
        //Removes both imageviews
        UIView.animate(withDuration: 0.3, delay: 0.5, usingSpringWithDamping: 0, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            self.frontImageView.alpha = 0
            
        }, completion: nil)
        
        
    }
    
}
