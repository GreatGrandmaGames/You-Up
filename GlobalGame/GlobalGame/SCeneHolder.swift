////
////  GameScene.swift
////  GGG-GGJ2018
////
////  Created by Elliot Richard John Winch on 1/27/18.
////  Copyright © 2018 Elliot Richard John Winch. All rights reserved.
////
//import SpriteKit
//import GameplayKit
//
//class MessageScene: SKScene {
//    
//    var ceiling : CGFloat = 400
//    
//    var readingFactor : Double = 0.5
//    var speechTimer : Double = 0
//    var updateSpeechTimer : Bool = false
//    
//    var currentMessageIndex : Int = 0
//    var messages : [Message] =  [Message]()
//    var messageNodes = [MessageNode]()
//    var optionNodes = [OptionNode]()
//    
//    var currentSenderIndex : Int = 0
//    var senders : [Sender] = [Sender]()
//    
//    override func didMove(to view: SKView) {
//        let background = SKSpriteNode(color: UIColor.white, size: self.size)
//        background.zPosition = -10
//        
//        self.addChild(background)
//        
//        ceiling = (size.height * 0.5) - (size.height * 0.075)
//        
//        //Sender spawning
//        senders.append(Sender(name: "Boy", color: UIColor.red))
//        senders.append(Sender(name: "Jenna", color: UIColor.green))
//        senders.append(Sender(name: "Bob", color: UIColor.yellow))
//        currentSenderIndex = 0
//        
//        let inc : CGFloat = size.width / CGFloat(senders.count + 1)
//        var counter : CGFloat = 1
//        
//        for s in senders {
//            let senderNode = SenderNode(s, p: self)
//            senderNode.position = CGPoint(x: (counter * inc) - (size.width / 2), y: ceiling)
//            
//            counter += 1
//            
//            print(senderNode.position)
//        }
//        
//        //Messages
//        speechTimer = 0
//        
//        messages.append(Message("Did I ever tell you the tragedy of Darth Plagus the Wise?"))
//        
//        let option1 = Option(Message("Pick me"), responseIndex: 2)
//        let option2 = Option(Message("No, me!"), responseIndex: 3)
//        
//        
//        messages.append(Message("It's not a story the jedi would tell you", sender: senders[currentSenderIndex], optionsTriggered: [option1, option2]))
//        
//        messages.append(Message("Fuck you, science"))
//        messages.append(Message("Fuck me, science"))
//        
//        messages.append(Message("Fuck you, science"))
//        messages.append(Message("Fuck me, science. Heheheheheheh"))
//        
//        spawnMessageNode()
//        updateSpeechTimer = true
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//        let touch = touches.first!
//        let positionInScene = touch.location(in: self)
//        let touchedNode = self.atPoint(positionInScene) as? SKSpriteNode
//        
//        if(touchedNode != nil){
//            if let optionNode = touchedNode as? OptionNode{
//                
//                currentMessageIndex = optionNode.option.responseIndex
//                
//                spawnMessageNode()
//                
//                updateSpeechTimer = true
//                
//                self.removeChildren(in: optionNodes)
//            } else if let senderNode = touchedNode as? SenderNode {
//                
//                for o in optionNodes{
//                    //switch to another view
//                }
//            }
//        }
//    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//    }
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//    }
//    
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//    }
//    
//    var timeInterval : Double = 0
//    var prevTime : Double = 0
//    var beginTimer : Double = 0
//    let waitAtStart : Double = 2
//    
//    override func update(_ currentTime: TimeInterval) {
//        timeInterval = currentTime - prevTime
//        prevTime = currentTime
//        
//        if timeInterval > 1 {
//            return
//        }
//        
//        beginTimer += timeInterval
//        
//        if beginTimer < waitAtStart {
//            return
//        }
//        
//        if updateSpeechTimer {
//            speechTimer += timeInterval
//            
//            if (currentMessageIndex < messages.count && speechTimer > Double(messages[currentMessageIndex].wordCount) * readingFactor) {
//                spawnMessageNode()
//                speechTimer = 0
//            }
//        }
//    }
//    
//    func spawnMessageNode(){
//        
//        if currentMessageIndex < messages.count {
//            
//            let m = MessageNode(m: messages[currentMessageIndex], p: self)
//            var owner : String = ""
//            var xPosition : CGFloat = 0
//            var messageBackground : SKSpriteNode = SKSpriteNode(imageNamed: "blueMessage")
//            
//            if m.message.sender != nil {
//                xPosition = -200
//            } else if m.message.options == nil {
//                xPosition = 200
//            }
//            print(m.color)
//            if(m.color==UIColor.gray){
//                owner = "player"
//            }
//            else if(m.color == UIColor.red){
//                owner = "boy"
//            }
//            
//            m.color = UIColor.clear
//            
//            m.position = CGPoint(x: xPosition, y: m.position.y)
//            m.blueMessage.position = CGPoint(x: xPosition, y: m.position.y-8)
//            m.grayMessage.position = CGPoint(x: xPosition, y: m.position.y-8)
//            
//            if(owner=="player"){
//                self.addChild(m.blueMessage)
//            }
//            else if(owner=="boy"){
//                self.addChild(m.grayMessage)
//            }
//            else{
//                self.addChild(m.blueMessage)
//            }
//            
//            
//            for l in messageNodes {
//                l.position = CGPoint(x: l.position.x, y: l.position.y + l.size.height + 10)
//                l.color = UIColor.clear
//                l.blueMessage.position = CGPoint(x: l.position.x, y: l.position.y - 8 )
//                l.grayMessage.position = CGPoint(x: l.position.x, y: l.position.y - 8)
//                if(l.position.y + (l.size.height * 0.5) > ceiling){
//                    l.removeFromParent()
//                    l.blueMessage.removeFromParent()
//                    l.grayMessage.removeFromParent()
//                    
//                }
//                
//            }
//            
//            messageNodes.append(m)
//            
//            if m.message.options != nil && m.message.options!.count > 0 {
//                spawnOptions(messages[currentMessageIndex])
//                
//                updateSpeechTimer = false
//            }
//            
//            currentMessageIndex+=1
//        }
//    }
//    
//    func spawnOptions(_ message: Message){
//        
//        var counter :CGFloat = 0
//        for o in message.options! {
//            let optionNode = OptionNode(o, p: self)
//            
//            optionNode.position = CGPoint(x: optionNode.position.x, y: -300 - (counter * optionNode.size.height))
//            
//            counter += 1.0
//            
//            optionNodes.append(optionNode)
//        }
//    }
//}

