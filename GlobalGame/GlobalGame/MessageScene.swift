
//
//  GameScene.swift
//  GGG-GGJ2018
//
//  Created by Elliot Richard John Winch on 1/27/18.
//  Copyright © 2018 Elliot Richard John Winch. All rights reserved.
//

import SpriteKit
import GameplayKit

var ceiling : CGFloat = 400
var readingFactor : Double = 0.4

class MessageScene: SKScene {
    
    var messageViews = [MessageView]()
    var currentViewIndex : Int = 0
    
    override func didMove(to view: SKView) {
        //Background
        let background = SKSpriteNode(color: UIColor.white, size: self.size)
        background.zPosition = -10
        
        self.addChild(background)
        
        ///Load CSV
        var senders = [Sender]()
        
        //init your senders manually
        senders.append(Sender(name: "Jason", color: UIColor.darkGray))
        
        ceiling = (size.height * 0.5) - (size.height * 0.075)
        
        let inc : CGFloat = size.width / CGFloat(senders.count + 1)
        var counter : CGFloat = 1
        
        for s in senders {
            let senderNode = SenderNode(s, p: self)
            senderNode.position = CGPoint(x: (counter * inc) - (size.width / 2), y: ceiling)
            
            counter += 1
            
            let messageView = MessageView(s, parent: self)
            
            messageViews.append(messageView)
            
            //Load contents
            let contents = readFile(path: "done - Master")!
            
            var entries = [[String]]()
            
            contents.enumerateLines(invoking: { (string, b : inout Bool) in
                entries.append(string.components(separatedBy: "\t"))
            })
            
            for i in 1..<entries.count {
                
                let line = entries[i]
                
                if line[2] == "-0001" {
                    
                    var options = [Option]()
                    
                    for j in [4,6,8]{
                        if j + 1 < line.count && line[j] != "" && line[j] != "" {
                            print(line[j + 1])
                            options.append(Option(Message(line[j]), responseUID: line[j + 1]))
                        }
                    }
                    
                    messageView.messages.append(Message(line[3], uid: line[1], nextUID: String(-1), sender: s, options: options))
                    
                } else {
                    if line[0] == "$playerName" {
                        messageView.messages.append(Message(line[3], uid: line[1], nextUID: line[2]))
                        
                    } else {
                        messageView.messages.append(Message(line[3], uid: line[1], nextUID: line[2], sender: s))
                        
                    }
                }
            }
        }
        
        currentViewIndex = 0
        messageViews[0].toggleHidden(isHidden: false)
    }
    
    func readFile(path : String) -> String? {
        guard let filePath = Bundle.main.path(forResource: path, ofType: "tsv") else {
            print ("Provide me a CSV please")
            return nil
        }
        
        do {
            let contents = try String(contentsOfFile: filePath)
            return contents
        } catch {
            print("File Read Error")
            return nil
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let optionNode = touchedNode as? OptionNode{
            onOption(opt: optionNode.option)
        } else if let senderNode = touchedNode as? SenderNode {
            onSender(sender: senderNode.sender)
        } else if let labelNode = touchedNode as? SKLabelNode {
            if let optParent = labelNode.parent as? OptionNode {
                onOption(opt: optParent.option)
            } else if let senderParent = labelNode.parent as? SenderNode{
                onSender(sender: senderParent.sender)
            }
        }
    }
    
    func onOption(opt : Option){
        
        messageViews[currentViewIndex].spawnMessageNode(withUID: opt.responseUID)
        
        self.removeChildren(in: messageViews[currentViewIndex].optionNodes)
    }
    
    func onSender(sender : Sender) {
        for i in 0..<messageViews.count{
            if messageViews[i].sender == sender {
                messageViews[currentViewIndex].toggleHidden(isHidden: true)
                
                currentViewIndex = i
                messageViews[currentViewIndex].toggleHidden(isHidden: false)
                
                return
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    var timeInterval : Double = 0
    var prevTime : Double = 0
    var beginTimer : Double = 0
    let waitAtStart : Double = 0.3
    
    override func update(_ currentTime: TimeInterval) {
        timeInterval = currentTime - prevTime
        prevTime = currentTime
        
        if timeInterval > 1 {
            return
        }
        
        beginTimer += timeInterval
        
        if beginTimer < waitAtStart {
            return
        }
        
        messageViews[currentViewIndex].handleTimer(timeInterval)
    }
    
    
}

public class MessageView : SKSpriteNode {
    
    public var speechTimer : Double = 0
    
    public var currentMessageUID : String = ""
    var currentMessageIndex : Int = 0
    public var messages : [Message]
    public var messageNodes : [MessageNode]
    public var optionNodes : [OptionNode]
    
    public var sender : Sender
    
    public init(_ s: Sender, parent: SKNode){
        
        messages = [Message]()
        messageNodes = [MessageNode]()
        optionNodes = [OptionNode]()
        
        sender = s
        
        super.init(texture: nil, color: UIColor.clear, size: CGSize.zero)
        
        self.move(toParent: parent)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func spawnNextNode(){
        
        if currentMessageUID == "" {
            spawnMessageNode(withUID: messages[0].uid!)
        } else {
            spawnMessageNode(withUID: messages[currentMessageIndex].nextUID!)
        }
    }
    
    public func spawnMessageNode(withUID: String){
        print("Attempting to spawn: " + withUID)
        currentMessageIndex = findMessageIndex(withUID: withUID)
        currentMessageUID = withUID
        
        for o in optionNodes {
            o.removeFromParent()
        }
        
        optionNodes.removeAll()
        
        if currentMessageIndex >= 0 {
            
            let m = MessageNode(m: messages[currentMessageIndex], p: self)
            
            print("Message " + m.message.message)
            m.texture = SKTexture(imageNamed: "blueMessage")
            
            /*
             if m.message.sender != nil {
             xPosition = -160
             } else if m.message.options == nil {
             xPosition = 260
             }
             */
            
            if m.message.sender != nil {
                m.colorBlendFactor = 1
                m.color = UIColor(white: 0.6, alpha: 1)
                playASound(fileName: "textSent")
            }
            
            let moveInAnimation = SKAction.move(to: CGPoint.zero, duration: 0.3)
            
            m.position = CGPoint(x: m.position.x + (m.message.sender != nil ? -600 : 600), y: m.position.y)
            
            m.run(SKAction.group([moveInAnimation]))
            
            for l in messageNodes {
                print(m.size.height)
                
                
                let point = CGPoint(x: l.position.x, y: l.position.y + (m.size.height * 1.2 ) + 40)
                if(l.position.y + (l.size.height * 0.5) >= ceiling - 200){
                    l.removeFromParent()
                    continue
                }
                
                let moveAnimation = SKAction.move(to: point, duration: 0.3)
                moveAnimation.timingMode = .easeInEaseOut
                
                l.run(moveAnimation)
                
            }
            
            messageNodes.append(m)
            
            if m.message.options != nil && m.message.options!.count > 0 {
                spawnOptions(messages[currentMessageIndex])
            }
        }
    }
    
    func spawnOptions(_ message: Message){
        
        var counter :CGFloat = 0
        
        for o in message.options! {
            let optionNode = OptionNode(o, p: self)
            
            optionNode.position = CGPoint(x: optionNode.position.x, y: -300 - counter * 120)
            
            counter += 1.0
            
            optionNodes.append(optionNode)
        }
    }
    
    func toggleHidden (isHidden : Bool){
        for o in optionNodes {
            o.isHidden = isHidden
        }
        
        for m in messageNodes {
            m.isHidden = isHidden
        }
        
        
    }
    
    func handleTimer(_ time: Double){
        
        if optionNodes.count <= 0 {
            speechTimer += time
            
            if (currentMessageIndex >= 0 && speechTimer > Double(messages[currentMessageIndex].wordCount) * readingFactor) {
                
                spawnNextNode()
                
                speechTimer = 0
            }
        }
    }
    
    func findMessageIndex(withUID: String) -> Int{
        
        for i in 0..<messages.count{
            if messages[i].uid! == withUID {
                return i
            }
        }
        
        return -1
    }
}
