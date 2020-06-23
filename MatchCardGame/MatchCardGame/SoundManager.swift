//
//  SoundManager.swift
//  MatchCardGame
//
//  Created by Mahesh Pondugula on 22/06/20.
//  Copyright © 2020 Mahesh Pondugula. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    
    static var audioPlayer:AVAudioPlayer?
    
    enum SoundEffect {
        
        case flip
        case shuffle
        case match
        case nomatch
        
    }
    
    static func playSound(_ effect:SoundEffect) {
        
        var soundFilename = ""
        
        //determine the sound effect to be played
        switch effect {
        
        case .flip:
            soundFilename = "cardflip"
            
        case .shuffle:
            soundFilename = "shuffle"
            
        case .match:
            soundFilename = "dingcorrect"
            
        case.nomatch:
            soundFilename = "dingwrong"
            
        }
        
        //get the path to sound file
        let bundlePath = Bundle.main.path(forResource: soundFilename, ofType: "wav")
        
        guard bundlePath != nil else {
            print("Couldn't find sound fila \(soundFilename)")
            return
        }
        
        //create url object
        let soundURL = URL(fileURLWithPath: bundlePath!)
        
        do {
            //create audioplayer object
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            
            //play the sound
            audioPlayer?.play()
        }
        catch {
            //couldn't create audiopalyer object
            print("Couldn't create the audio player \(soundFilename)")
        }
        
    }
    
}
