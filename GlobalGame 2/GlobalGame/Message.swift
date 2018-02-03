//
//  Message.swift
//  GGG-GGJ2018
//
//  Created by Elliot Richard John Winch on 1/27/18.
//  Copyright © 2018 Elliot Richard John Winch. All rights reserved.
//

import Foundation
import SpriteKit

public let maxLineCharCount = 35

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

public class Sender : NSObject {
    
    let name : String
    let color : UIColor
    
    public init(name: String, color: UIColor) {
        self.name = name
        self.color = color
    }
}

public class Message : NSObject {
    
    let message : String
    let sender : Sender?
    public let options : [Option]?
    let uid : String?
    public let nextUID : String?
    
    public var wordCount = 0
    
    public init(_ message: String, uid: String, nextUID: String?, sender: Sender? = nil, options: [Option]? = nil){
        self.message = message
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
        self.message = message
        self.uid = uid
        self.nextUID = nextUID
        self.sender = s
        self.options = nil
    }
}

public class MessageNode : SKSpriteNode{
    
    let message : Message
    var messageLabel : [SKLabelNode]
    
    public init(m: Message, p : SKNode) {
        message = m
        messageLabel = [SKLabelNode]()
        
        var i = 0
        
        var counter : CGFloat = 0
        var lineNums = 0
        
        while i < m.message.count {
            lineNums += 1
            
            var lineString = ""
            
            while(i < m.message.count && i < maxLineCharCount * lineNums) {
                //Find word
                let startWordIndex = m.message.index(m.message.startIndex, offsetBy: i)
                var iAsIndex = startWordIndex
                
                while i < m.message.count && m.message[iAsIndex] != " "  {
                    i+=1
                    iAsIndex = m.message.index(m.message.startIndex, offsetBy: i)
                }
                
                lineString += m.message[startWordIndex..<iAsIndex]
                lineString += " "
                i+=1
            }
            
            let lineNode = SKLabelNode(text: lineString)
            lineNode.fontSize = 36
            lineNode.fontName = "Avenir"
            
            lineNode.position = CGPoint(x: 0, y: -counter)
            
            counter += lineNode.frame.height
            
            messageLabel.append(lineNode)
        }
        
        //texture should be the background
        var maxWidth :CGFloat = 0
        var maxHeight :CGFloat = 0
        var totalHeight : CGFloat = 0
        
        for l in messageLabel {
            if(maxWidth < l.frame.width){
                maxWidth = l.frame.width
            }
            
            if(maxHeight < l.frame.height){
                maxHeight = l.frame.height
            }
            
            totalHeight += l.frame.height
        }
        
        var color : UIColor = UIColor.gray
        
        if m.sender != nil {
            color = m.sender!.color
        }
        
        super.init(texture: nil, color: color, size: CGSize(width: maxWidth * 1.05, height: 1.4 * totalHeight))
        
        for l in messageLabel {
            l.move(toParent: self)
            l.zPosition = 20
            l.position = CGPoint(x: 0, y: l.position.y + (totalHeight * 0.6) - messageLabel[0].frame.height)
        }
        
        
        self.move(toParent: p)
        self.zPosition = -1
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        message = Message("")
        messageLabel = [SKLabelNode]()
        
        super.init(coder: aDecoder)
    }
    
}

public class OptionNode : MessageNode {
    
    let option : Option
    
    public init(_ o: Option, p: SKNode) {
        option = o
        
        super.init(m: o.messageToDisplay, p: p)
        
        self.size = CGSize(width: (self.scene?.size.width)! * 0.85, height: CGFloat(60))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class SenderNode : MessageNode {
    
    let sender : Sender
    
    public init(_ s: Sender, p: SKNode) {
        sender = s
        
        super.init(m: Message(s.name), p: p)
        
        self.size = CGSize(width: self.size.width * 2, height: 100)
        self.color = s.color
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
