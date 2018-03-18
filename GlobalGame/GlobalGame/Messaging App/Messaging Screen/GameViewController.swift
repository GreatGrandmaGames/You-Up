//
//  GameViewController.swift
//  GlobalGame
//
//  Created by Nina Demirjian on 1/28/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var sender : Sender?
    
    @IBOutlet weak var toProfile: UIButton!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    @IBOutlet weak var skview: SKView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the SKScene from 'GameScene.sks' or load from gameManager
        
        navBarTitle.title = sender!.name
        toProfile.setBackgroundImage(UIImage(named: (sender!.name)), for: UIControlState.normal)
        
        skview.ignoresSiblingOrder = true
        
        skview.showsFPS = true
        skview.showsNodeCount = true
        
        if sender != nil {
            
            if gameManager.senderScenes.keys.contains(sender!) {
                
                skview.presentScene(gameManager.senderScenes[sender!]!)
                
            } else {
            
                if let scene = SKScene(fileNamed: "MessageScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .fill
                    
                    if let messagingScene = scene as? MessageScene {
                            messagingScene.setSender(sender: sender!)
                    }
                    
                    skview.presentScene(scene)
                
                } else {
                    fatalError("Scene is not messaging scene")
                }
            }
        } else {
            fatalError("Transferring to Message Scene without valid sender")
        }
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    @IBAction func goToProfilePressed(_ sender: Any) {
        //here we would load a profile (presumably only if the contact is from WInk?)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        if let messageScene = self.skview.scene as? MessageScene {
        
            gameManager.senderScenes[self.sender!] = messageScene
        }
        
        self.dismiss(animated: false, completion: nil)
    }
    
}


//extension MessageScene: UIViewControllerTransitioningDelegate {
//    func animationController(forPresented presented: UIViewController,
//                             presenting: UIViewController,
//                             source: UIViewController)
//        -> UIViewControllerAnimatedTransitioning? {
//            return AnimationController()
//    }
//}

