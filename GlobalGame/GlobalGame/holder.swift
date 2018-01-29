//
////
////  Message.swift
////  GGG-GGJ2018
////
////  Created by Elliot Richard John Winch on 1/27/18.
////  Copyright © 2018 Elliot Richard John Winch. All rights reserved.
////
//import Foundation
//import SpriteKit
//
//public let maxLineCharCount = 20
//
//public class Option : NSObject {
//
//    let messageToDisplay : Message
//    let responseIndex : Int
//    let additionalEffects : (() -> ())?
//
//    public init(_ m: Message, responseIndex: Int, additionalEffects: (() -> ())? = nil) {
//        self.messageToDisplay = m
//        self.responseIndex = responseIndex
//        self.additionalEffects = additionalEffects
//    }
//
//    public func triggerAdditionals(){
//        if(additionalEffects != nil) {
//            additionalEffects!()
//        }
//    }
//}
//
//public class Sender : NSObject {
//
//    let name : String
//    let color : UIColor
//
//    public init(name: String, color: UIColor) {
//        self.name = name
//        self.color = color
//    }
//}
//
//public class Message : NSObject {
//
//    let message : String
//    let sender : Sender?
//    public let options : [Option]?
//
//    public var wordCount = 0
//
//    public init(_ message: String, sender: Sender? = nil, optionsTriggered: [Option]? = nil){
//        self.message = message
//        self.sender = sender
//        self.options = optionsTriggered
//
//        var i = 0
//
//        while(i < message.count ) {
//            let startWordIndex = message.index(message.startIndex, offsetBy: i)
//            var iAsIndex = startWordIndex
//
//            while i < message.count && message[iAsIndex] != " "  {
//                i+=1
//                iAsIndex = message.index(message.startIndex, offsetBy: i)
//            }
//
//            wordCount += 1
//            i+=1
//        }
//    }
//}
//public class ImageMessage : Message {
//
//    let pictureURL : String
//
//    public init (_ message: String, pictureURL: String, sender: Sender? = nil, optionsTriggered: [Option]? = nil){
//        self.pictureURL = pictureURL
//
//        super.init(message, sender: sender, optionsTriggered: optionsTriggered)
//    }
//}
//
//public class MessageNode : SKSpriteNode{
//
//    let message : Message
//
//    var messageLabel : [SKLabelNode]
//    var blueMessage : SKSpriteNode = SKSpriteNode(imageNamed: "blueMessage.png")
//    var grayMessage : SKSpriteNode = SKSpriteNode(imageNamed: "grayMessage.png")
//    let messagePicture : SKSpriteNode?
//
//
//    public init(m: Message, p : SKNode) {
//        message = m
//        messageLabel = [SKLabelNode]()
//
//        var i = 0
//
//        var counter : CGFloat = 0
//        var lineNums = 0
//
//
//        while i < m.message.count {
//            lineNums += 1
//
//            var lineString = ""
//
//            while(i < m.message.count && i < maxLineCharCount * lineNums) {
//                //Find word
//                let startWordIndex = m.message.index(m.message.startIndex, offsetBy: i)
//                var iAsIndex = startWordIndex
//
//                while i < m.message.count && m.message[iAsIndex] != " "  {
//                    i+=1
//                    iAsIndex = m.message.index(m.message.startIndex, offsetBy: i)
//                }
//
//                lineString += m.message[startWordIndex..<iAsIndex]
//                lineString += " "
//                i+=1
//            }
//
//            let lineNode = SKLabelNode(text: lineString)
//            lineNode.fontSize = 36
//            lineNode.fontName = "Avenir"
//
//
//            lineNode.position = CGPoint(x: 0, y: -counter)
//            counter += lineNode.frame.height
//
//            messageLabel.append(lineNode)
//        }
//
//        if let Im = m as? ImageMessage {
//            messagePicture = SKSpriteNode(imageNamed: Im.pictureURL)
//
//        } else {
//            messagePicture = nil
//        }
//
//        //texture should be the background
//        var maxWidth :CGFloat = 0
//        var maxHeight :CGFloat = 0
//        var totalHeight : CGFloat = 0
//
//        for l in messageLabel {
//            if(maxWidth < l.frame.width){
//                maxWidth = l.frame.width
//            }
//
//            if(maxHeight < l.frame.height){
//                maxHeight = l.frame.height
//            }
//
//            totalHeight += l.frame.height
//        }
//
//        var color : UIColor = UIColor.gray
//
//        if m.sender != nil {
//            color = m.sender!.color
//        }
//
//        super.init(texture: nil, color: color, size: CGSize(width: maxWidth * 1.2, height: 1.2 * totalHeight))
//        blueMessage.size = CGSize(width: maxWidth * 1.2, height: 1.2 * totalHeight)
//        grayMessage.size = CGSize(width: maxWidth * 1.2, height: 1.2 * totalHeight)
//        self.position = CGPoint(x: 0, y: position.y - (totalHeight * 0.5) + messageLabel[0].frame.height)
//
//        for l in messageLabel {
//            l.move(toParent: self)
//            l.zPosition = 20
//            l.color = UIColor.white
//
//        }
//
//        self.move(toParent: p)
//        self.zPosition = -1
//
//
//    }
//
//    required public init?(coder aDecoder: NSCoder) {
//        messagePicture = nil
//
//        message = Message("")
//        messageLabel = [SKLabelNode]()
//
//        super.init(coder: aDecoder)
//    }
//
//}
//
//public class OptionNode : MessageNode {
//
//    let option : Option
//
//    public init(_ o: Option, p: SKNode) {
//        option = o
//
//        super.init(m: o.messageToDisplay, p: p)
//
//        self.size = CGSize(width: self.size.width * 4, height: self.size.height * 2)
//    }
//
//    required public init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//public class SenderNode : MessageNode {
//
//    let sender : Sender
//
//    public init(_ s: Sender, p: SKNode) {
//        sender = s
//
//        super.init(m: Message(s.name), p: p)
//
//        self.size = CGSize(width: self.size.width * 2, height: 100)
//        self.color = s.color
//    }
//
//    required public init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

