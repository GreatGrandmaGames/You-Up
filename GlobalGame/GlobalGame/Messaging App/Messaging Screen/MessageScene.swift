
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
let messageIndentPercentage : CGFloat = 0.03

class MessageScene: SKScene {
    
    public var speechTimer : Double = 0
    
    public var currentMessageUID : String = ""
    var currentMessageIndex : Int = 0
    public var messages : [Message] = [Message]() //this is for intial parsing
    public var messageNodes : [MessageNode] = [MessageNode]() //this is actual nodes in the scene
    public var optionNodes : [OptionNode] = [OptionNode]()
    
    public var sender : Sender
    
    public init(_ sender: Sender) {
        self.sender = sender
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        //init your senders manually for now
        sender = Sender(name: "Jason", color: UIColor.blue)
        
        super.init(coder: aDecoder)
    }
    
    override func didMove(to view: SKView) {
        //Background
        let background = SKSpriteNode(color: UIColor.white, size: self.size)
        background.zPosition = -10
        
        self.addChild(background)

        //Load contents - parsing
        do {
            let contents = try readFile(path: "test1")
            
            var entries = [[String]]()
            
            contents.enumerateLines(invoking: { (string, b : inout Bool) in
                entries.append(string.components(separatedBy: "\t"))
            })
            
            for i in 1..<entries.count {
                
                let line = entries[i]
                
                if line[2] == "-1" {
                    
                    var options = [Option]()
                    
                    for j in [5,7,9]{
                        if j + 1 < line.count && line[j] != "" && line[j] != "" {
                            print(line[j + 1])
                            options.append(Option(line[j], responseUID: line[j + 1]))
                        }
                    }
                    
                    messages.append(Message(line[3], uid: line[1], nextUID: String(-1), sender: sender, options: options))
                    
                } else {
                    if line[0] == "$player" {
                        messages.append(Message(line[3], uid: line[1], nextUID: line[2]))
                        
                    } else {
                        messages.append(Message(line[3], uid: line[1], nextUID: line[2], sender: sender))
                        
                    }
                }
            }
            
        } catch TSVParsingError.FileNotFound{
            print("Error: Please provide a TSV")
        } catch TSVParsingError.FileNotVaid {
            print("Error: TSV file not valid")
        } catch {
            print("Error: Parsing failed")
        }
    }
    
    
    enum TSVParsingError : Error {
        case FileNotFound
        case FileNotVaid
    }
    
    func readFile(path : String) throws -> String {
        guard let filePath = Bundle.main.path(forResource: path, ofType: "tsv") else {
            throw TSVParsingError.FileNotFound
        }
        
        do {
            let contents = try String(contentsOfFile: filePath)
            print(contents)
            return contents
        } catch {
            throw TSVParsingError.FileNotVaid
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let labelNode = touchedNode as? SKLabelNode {
            if let optParent = labelNode.parent as? OptionNode {
                onOption(opt: optParent.option)
            }
        } else if let spriteNode = touchedNode as? SKSpriteNode {
            if let optParent = spriteNode.parent as? OptionNode {
                onOption(opt: optParent.option)
            }
        }
    }
    
    //Helper for touches
    func onOption(opt : Option){
        
        spawnMessageNode(withUID: opt.responseUID)
        
        self.removeChildren(in: optionNodes)
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
        
        //Handle timer
        if optionNodes.count <= 0 {
            speechTimer += timeInterval
            
            if (currentMessageIndex >= 0 && speechTimer > Double(messages[currentMessageIndex].wordCount) * readingFactor) {
                
                spawnNextNode()
                
                speechTimer = 0
            }
        }
    }
    
    
    //Spawning Nodes
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
            
            let m = MessageNode(messages[currentMessageIndex])
            m.move(toParent: self)
            
            print("Message: " + m.message.text)
            
            var xPos : CGFloat
            if m.message.sender != nil {
                playASound(fileName: "textSent")
                //hardcode, needs to scale
                xPos = self.frame.width * (messageIndentPercentage - 1/2)

            } else {
                //hardcode, needs to scale
                xPos = self.frame.width * (-messageIndentPercentage + 1/2)
            }
            
            
            let moveInAnimation = SKAction.move(to: CGPoint(x: xPos, y:0.0), duration: 0.3)
             
             m.position = CGPoint(x: m.position.x + (m.message.sender != nil ? -600 : 600), y: m.position.y)
             
             m.run(SKAction.group([moveInAnimation]))
 
            for l in messageNodes {
                
                let point = CGPoint(x: l.position.x, y: l.position.y + (m.background.size.height * 1.2 ) + 40)
                if(l.position.y + (l.background.size.height * 0.5) >= ceiling - 200){
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
    
    //Helper for spawnMessageNode
    func spawnOptions(_ message: Message){
        
        var counter :CGFloat = 0
        
        for o in message.options! {
            let optionNode = OptionNode(o)
            optionNode.move(toParent: self)
            
            optionNode.position = CGPoint(x: optionNode.position.x, y: -300 - counter * 120)
            
            counter += 1.0
            
            optionNodes.append(optionNode)
        }
    }
    
    //Helper for spawnMessageNode
    func findMessageIndex(withUID: String) -> Int{
        
        for i in 0..<messages.count{
            if messages[i].uid! == withUID {
                return i
            }
        }
        
        return -1
    }
}
