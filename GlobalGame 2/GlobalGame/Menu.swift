//
//  Menu.swift
//  GlobalGame
//
//  Created by Nina Demirjian on 1/28/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit
import AudioToolbox


class Menu: SKScene {
    
    var settingsButton : SKSpriteNode!
    var startButton : SKSpriteNode!
    var creditsButton : SKSpriteNode!
    var loadButton : SKSpriteNode!
    
    
    
     override func didMove(to view: SKView) {
        
        
        let settingsButton = SKSpriteNode(imageNamed: "settingsIcon.png")
        settingsButton.name = "settings"
        settingsButton.position = CGPoint(x: 138, y: 135)
        settingsButton.size = CGSize(width: 190,height:190)
        self.addChild(settingsButton)
        
        let startButton = SKSpriteNode(imageNamed: "cinderIcon.png")
        startButton.name = "start"
        startButton.position = CGPoint(x: -138, y: 135)
        startButton.size = CGSize(width: 190,height:190)
        self.addChild(startButton)
        
        let creditsButton = SKSpriteNode(imageNamed: "creditsIcon.png")
        creditsButton.name = "credits"
        creditsButton.position = CGPoint(x: -138, y: -190)
        creditsButton.size = CGSize(width: 190,height:190)
        self.addChild(creditsButton)
        
        let loadButton = SKSpriteNode(imageNamed: "loadIcon.png")
        loadButton.name = "load"
        loadButton.position = CGPoint(x: 138, y: -190)
        loadButton.size = CGSize(width: 190,height:190)
        self.addChild(loadButton)
        
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            let node : SKNode? = self.atPoint(location)
            if(node!.name=="start"){
                self.removeAllChildren()
                var instructions = SKSpriteNode(imageNamed: "cinderInstructions")
                instructions.size = CGSize(width: self.size.width, height: self.size.height)
                instructions.name = "go"
                instructions.zPosition = 20
                self.addChild(instructions)
                
            }
            else if(node!.name=="credits"){
                
            }
            else if(node!.name == "go"){
                if let scene = SKScene(fileNamed: "GameScene") {
                    scene.scaleMode = .aspectFill
                    let transition = SKTransition.push(with: .up, duration: 0.5)
                    
                    self.view!.presentScene(scene, transition: transition)
                }
            }
        }
    }
    
    
}
