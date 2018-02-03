//
//  tinderLayout.swift
//  GGG-GGJ2018
//
//  Created by Nina Demirjian on 1/27/18.
//  Copyright © 2018 Elliot Richard John Winch. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit
import AudioToolbox


class GameScene: SKScene {
    
    var boys : [boy] = []
    var counter : Int = -1;
    
    var parentBox : SKSpriteNode = SKSpriteNode()
    
    var xStart : CGFloat!
    var xEnd : CGFloat!
    
    var isBeingSwiped : Bool!
    
    var likeButton : SKSpriteNode!
    var dislikeButton : SKSpriteNode!
    
    var matches : [String] = []
    var currentBoy : boy!
    
    var canTouch : Bool!
  
    
    
    
    override func didMove(to view: SKView) {
        
        canTouch = true
        
        let likeButton = SKSpriteNode(imageNamed:"yesFace.png")
        likeButton.size = CGSize(width: 141, height : 141)
        likeButton.position = CGPoint(x: 160, y: -535)
        likeButton.name = "likeButton"
        likeButton.zPosition = 50
        self.addChild(likeButton)
        
        let dislikeButton = SKSpriteNode(imageNamed:"nahFace.png")
        dislikeButton.size = CGSize(width: 141, height : 141)
        dislikeButton.position = CGPoint(x: -160, y: -535)
        dislikeButton.zPosition = 50
        dislikeButton.name = "dislike"
        self.addChild(dislikeButton)
        
        
        
        
        
        
        
        self.addChild(parentBox)
        
        
        //Create all the boys
        let boy1 = boy(myName: "Alvaro", myAge: 20, myBio: "Cuban boy, great cook!", myImage: "Alvaro.jpg")
        boys.append(boy1)
        let boy2 = boy(myName: "Chris", myAge: 21, myBio: "British programmer. Swipe right!", myImage: "Chris.jpg")
        boys.append(boy2)
        let boy3 = boy(myName: "Dean", myAge: 20, myBio: "Just looking for a nice girl.", myImage: "Dean.jpg")
        boys.append(boy3)
        let boy4 = boy(myName: "Frank", myAge: 74, myBio: "Age is just a number.", myImage: "Frank.jpg")
        boys.append(boy4)
        let boy5 = boy(myName: "Grady", myAge: 19, myBio: "Animal lover and vegetarian.", myImage: "Grady.jpg")
        boys.append(boy5)
        let boy6 = boy(myName: "Eli", myAge: 22, myBio: "My hair matches my soul.", myImage: "Eli.png")
        boys.append(boy6)
        let boy7 = boy(myName: "Lovett", myAge: 20, myBio: "Let's hang out at a cool coffee shop?", myImage: "Lovett.png")
        boys.append(boy7)
        let boy8 = boy(myName: "Jordan", myAge: 19, myBio: "Ask me about my ties!", myImage: "Jordan.jpg")
        boys.append(boy8)
        
        createBoyCard()
        
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            let node : SKNode? = self.atPoint(location)
            
            
            
            if(canTouch && node != nil){
                if(node!.name == "profile"){
                    xStart = location.x
                    isBeingSwiped = true
                }
                else if(node!.name == "likeButton"){
                    offScreenRight()
                    isBeingSwiped = false
                }
                else if(node!.name == "dislike"){
                    offScreenLeft()
                    isBeingSwiped = false
                }
            }
            else{
                if(node!.name == "newMessage"){
                    if let scene = SKScene(fileNamed: "MessageScene") {
                        scene.scaleMode = .aspectFill
                        let transition = SKTransition.push(with: .left, duration: 0.5)
                        
                        self.view!.presentScene(scene, transition: transition)
                    }
                }
            }
            print(location)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            let location = touch.location(in: self)
            let node : SKNode? = self.atPoint(location)
            if(isBeingSwiped && canTouch && node != nil){
                parentBox.position = location
                
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            let node : SKNode? = self.atPoint(location)
            xEnd = location.x
             if(canTouch && node != nil){
                if(node!.name == "profile"){
                    isBeingSwiped = false
                    if(abs((xEnd - xStart)) > 200){
                        if(xEnd > xStart){
                            offScreenRight()
                        }
                        else{
                            offScreenLeft()
                        }
                    }
                }
            }
            parentBox.position = CGPoint(x:0,y:0)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func createBoyCard(){
        counter = counter + 1
        if(counter>=boys.count){
            counter = 0;
        }
        
        currentBoy = boys[counter]
        
        
        var backBox : SKSpriteNode = SKSpriteNode(imageNamed: "lightgray.png")
        backBox.position = CGPoint(x:0,y:90)
        backBox.size = CGSize(width: 690, height: 1045)
        backBox.name = "profile"
        parentBox.addChild(backBox)
        var nameLabel : SKLabelNode = SKLabelNode(fontNamed: "Avenir")
        nameLabel.text = boys[counter].name
        nameLabel.fontColor = UIColor.black
        nameLabel.fontSize = 64.0
        nameLabel.position = CGPoint(x: -288, y:-135)
        nameLabel.zPosition = 10
        nameLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        parentBox.addChild(nameLabel)
        var ageLabel : SKLabelNode = SKLabelNode(fontNamed: "Avenir")
        ageLabel.text = String(boys[counter].age)
        ageLabel.fontColor = UIColor.black
        ageLabel.fontSize = 55.0
        ageLabel.position = CGPoint(x: -288, y:-201)
        ageLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        ageLabel.zPosition = 10
        parentBox.addChild(ageLabel)
        var bioLabel : SKLabelNode = SKLabelNode(fontNamed: "Avenir")
        bioLabel.text = boys[counter].bio
        bioLabel.fontColor = UIColor.black
        bioLabel.fontSize = 38.0
        bioLabel.position = CGPoint(x: 0, y:-300)
        bioLabel.zPosition = 10
        parentBox.addChild(bioLabel)
        var profPic : SKSpriteNode = SKSpriteNode(imageNamed: boys[counter].image)
        profPic.position = CGPoint(x:0,y:240)
        profPic.size = CGSize(width: 580, height : 580)
        profPic.zPosition = 10
        profPic.name = "profile"
        parentBox.addChild(profPic)
        
    }
    
    func offScreenRight(){
        let RotateRight = SKAction.rotate(byAngle: CGFloat(-Double.pi * 0.5), duration: 1)
        let flyRight = SKAction.moveTo(x: 2000, duration: 1.0)
        parentBox.run(RotateRight)
        parentBox.run(flyRight)
        parentBox.zPosition = 40
        // parentBox.removeAllChildren()
        print("BOY CHOSEN!!!")
        
        
        matches.append(currentBoy.name)
        let i = boys.index(of: currentBoy)
        boys.remove(at: i!)
        
        var parentBoxNew : SKSpriteNode = SKSpriteNode()
        self.addChild(parentBoxNew)
        parentBoxNew.zPosition = 20
        parentBoxNew.size = CGSize(width: self.size.width, height: self.size.height)
        parentBoxNew.position = CGPoint(x:0,y:0)
        parentBox = parentBoxNew
        
        createBoyCard()
        
        if(matches.count==3){
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.canTouch = false
               // AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                playASound(fileName: "notification")
          
                var gray : SKSpriteNode = SKSpriteNode(imageNamed: "alphaGray.png")
                gray.name = "ah"
                gray.position = CGPoint(x: 0, y: 0)
                gray.size = CGSize(width: self.size.width, height: self.size.height)
                gray.zPosition = 90
                self.addChild(gray)
            
                var newMessage : SKSpriteNode = SKSpriteNode(imageNamed: "newMessage.png")
                newMessage.name = "newMessage"
                newMessage.position = CGPoint(x: 0, y: 90)
                newMessage.size = CGSize(width: 640, height: 185)
                newMessage.zPosition = 100
                self.addChild(newMessage)
            }
     
            
        }
        
       
        
        
    }
    func offScreenLeft(){
        let RotateLeft = SKAction.rotate(byAngle: CGFloat(Double.pi * 0.5), duration: 1)
        let flyLeft = SKAction.moveTo(x: -2000, duration: 1.0)
        parentBox.run(RotateLeft)
        parentBox.run(flyLeft)
        parentBox.zPosition = 40
        
        //parentBox.removeAllChildren()
        var parentBoxNew : SKSpriteNode = SKSpriteNode()
        self.addChild(parentBoxNew)
        parentBoxNew.zPosition = 20
        parentBoxNew.size = CGSize(width: self.size.width, height: self.size.height)
        parentBoxNew.position = CGPoint(x:0,y:0)
        parentBox = parentBoxNew
        
        createBoyCard()
        
        
    }
}
