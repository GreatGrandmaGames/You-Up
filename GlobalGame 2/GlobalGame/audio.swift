//
//  audio.swift
//  MagnumOpus
//
//  Created by nyuguest on 12/11/17.
//  Copyright © 2017 nyu.edu. All rights reserved.
//
import Foundation
import AVFoundation

var audioPlayer : AVAudioPlayer! = nil

func playASound(fileName : String){
    
    
    guard let url = Bundle.main.url(forResource: fileName, withExtension: "wav") else {
        print("AudioError: Could not find file")
        return
    }
    
    do {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        try AVAudioSession.sharedInstance().setActive(true)
        
        audioPlayer = try AVAudioPlayer(contentsOf: url)
        
        guard let audioPlayer = audioPlayer else {
            return }
        
        audioPlayer.play()
        
    } catch let error {
        print(error.localizedDescription)
    }
}
