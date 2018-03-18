//
//  Message.swift
//  GGG-GGJ2018
//
//  Created by Elliot Richard John Winch on 1/27/18.
//  Copyright © 2018 Elliot Richard John Winch. All rights reserved.
//

import Foundation
import SpriteKit

public class Message : NSObject {
    
    let text : String
    let sender : Sender?
    public let options : [Option]?
    let uid : String?
    public let nextUID : String?
    
    public var wordCount = 0
    
    public init(_ message: String, uid: String, nextUID: String?, sender: Sender? = nil, options: [Option]? = nil){
        self.text = message
        self.uid = uid
        self.nextUID = nextUID
        self.sender = sender
        self.options = options
        
        var i = 0
        
        while(i < message.count ) {
            let startWordIndex = message.index(message.startIndex, offsetBy: i)
            var iAsIndex = startWordIndex
            
            while i < message.count && message[iAsIndex] != " "  {
                i+=1
                iAsIndex = message.index(message.startIndex, offsetBy: i)
            }
            
            wordCount += 1
            i+=1
        }
    }
    
    //For option text boxes
    public init(_ message: String, uid: String? = nil, nextUID: String? = nil, s: Sender? = nil){
        self.text = message
        self.uid = uid
        self.nextUID = nextUID
        self.sender = s
        self.options = nil
    }
}

