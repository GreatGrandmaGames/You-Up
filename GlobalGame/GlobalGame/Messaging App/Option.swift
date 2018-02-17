//
//  Option.swift
//  GlobalGame
//
//  Created by Elliot Richard John Winch on 2/17/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

import Foundation

public class Option : NSObject {
    
    let messageToDisplay : Message
    let responseUID : String
    let additionalEffects : (() -> ())?
    
    public init(_ m: Message, responseUID: String, additionalEffects: (() -> ())? = nil) {
        self.messageToDisplay = m
        self.responseUID = responseUID
        self.additionalEffects = additionalEffects
    }
    
    public func triggerAdditionals(){
        if(additionalEffects != nil) {
            additionalEffects!()
        }
    }
}
