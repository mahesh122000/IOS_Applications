//
//  ViewController.swift
//  WarCardGame
//
//  Created by Mahesh Pondugula on 14/06/20.
//  Copyright © 2020 Mahesh Pondugula. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var leftimageview: UIImageView!
    
    @IBOutlet weak var rightimageview: UIImageView!
    
    @IBOutlet weak var leftscorelabel: UILabel!
    
    @IBOutlet weak var rightscorelabel: UILabel!
    
    var leftscore = 0
    var rightscore = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func DealTapped(_ sender: Any) {
        //randomize numbers
        let leftnumber = Int.random(in: 2...14)
        let rightnumber = Int.random(in: 2...14)
        
        //update the image views
        leftimageview.image = UIImage(named: "card\(leftnumber)")
        
        rightimageview.image = UIImage(named: "card\(rightnumber)")
        
        if leftnumber > rightnumber {
            leftscore += 1
            leftscorelabel.text = String(leftscore)
        }
        else if leftnumber < rightnumber {
            rightscore += 1
            rightscorelabel.text = String(rightscore)
        }
        else {
            
        }
    }
    
    


}

