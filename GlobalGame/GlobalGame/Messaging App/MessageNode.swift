//
//  MessageNode.swift
//  GlobalGame
//
//  Created by Elliot Richard John Winch on 2/17/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

import Foundation
import SpriteKit

public class MessageNode : MultiLineLabelNode {
    
    let message : Message
    
    public init(_ m: Message) {
        self.message = m
        
        if m.sender != nil {
            //Character sent message - needs to be left aligned and sender color
            super.init(backgroundTexture: SKTexture(imageNamed: "whiteMessage"), backgroundColor: m.sender!.color, text: m.text, fontName: "Avenir", textSize: 36.0)
            
            for l in super.lines {
                l.horizontalAlignmentMode = .left
                l.name = "Message Node"
            }
            
            super.background.position = CGPoint(x: super.background.position.x + (super.background.size.width / 2), y: super.background.position.y)
            super.background.name = "Message Node"
        } else {
            //Player sent message - needs to be right aligned and grey
            super.init(backgroundTexture: SKTexture(imageNamed: "whiteMessage"), backgroundColor: UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0), text: m.text, fontName: "Avenir", textSize: 36.0)
            
            for l in super.lines {
                l.horizontalAlignmentMode = .right
                l.name = "Message Node"
            }
            super.background.position = CGPoint(x: super.background.position.x - (super.background.size.width / 2), y: super.background.position.y)
            super.background.name = "Message Node"
        }

    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Message Node cannot be spawned by a coder")
    }
    
}
